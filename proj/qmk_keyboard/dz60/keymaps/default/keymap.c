#include QMK_KEYBOARD_H
/* Standard arrangement / LAYOUT
 * ┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┐
 * │00 │01 │02 │03 │04 │05 │06 │07 │08 │09 │0a │0b │0c │0d │0e │
 * ├───┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴───┤
 * │10   │12 │13 │14 │15 │16 │17 │18 │19 │1a │1b │1c │1d │1e   │
 * ├─────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴─────┤
 * │20    │22 │23 │24 │25 │26 │27 │28 │29 │2a │2b │2c │2d      │
 * ├────┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴────┬───┤
 * │30  │31 │32 │33 │34 │35 │36 │37 │38 │39 │3a │3b │3d    │3e │
 * ├────┼───┴┬──┴─┬─┴───┴──┬┴───┼───┴───┴──┬┴──┬┴──┬┴──┬───┼───┤
 * │40  │41  │43  │44      │46  │48        │4a │4b │4c │4d │4e │
 * └────┴────┴────┴────────┴────┴──────────┴───┴───┴───┴───┴───┘
*/

/* LAYOUT_60_ansi_split_bs_rshift
 * ┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┐
 * │00 │01 │02 │03 │04 │05 │06 │07 │08 │09 │0a │0b │0c │0d │0e │
 * ├───┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴───┤
 * │10   │12 │13 │14 │15 │16 │17 │18 │19 │1a │1b │1c │1d │1e   │
 * ├─────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴─────┤
 * │20    │22 │23 │24 │25 │26 │27 │28 │29 │2a │2b │2c │2d      │
 * ├──────┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴────┬───┤
 * │30      │32 │33 │34 │35 │36 │37 │38 │39 │3a │3b │3d    │3e │
 * ├────┬───┴┬──┴─┬─┴───┴───┴───┴───┴───┴──┬┴───┼───┴┬────┬┴───┤
 * │40  │41  │43  │46                      │4a  │4b  │4d  │4e  │
 * └────┴────┴────┴────────────────────────┴────┴────┴────┴────┘
*/

//const uint16_t PROGMEM emoji_combo[] = {KC_LCTL, KC_LGUI, KC_SPC, COMBO_END};

// added this patch to get KC_APPLE_FN to work
// https://gist.github.com/fauxpark/010dcf5d6377c3a71ac98ce37414c6c4#file-applefn-patch

enum custom_keycodes {
    BACKTICK = SAFE_RANGE,
    MAC_EMOJI,
    LOCK_SCREEN,
    WIN_EMOJI,
};

enum tapdance_keycodes {
    TD_BACKTICK_ESC,       //Tap Dance Backtick / Esc
};

void td_backtick_exactly_2_esc(qk_tap_dance_state_t *state, void *user_data) {
    int i;

    if (state->count == 1) {
        tap_code(KC_ESC);
        return;
    }

    for (i=1; i<state->count; i++) {
        tap_code(KC_GRV);
    }
}

// Tap Dance definitions
qk_tap_dance_action_t tap_dance_actions[] = {
    [TD_BACKTICK_ESC] = ACTION_TAP_DANCE_FN(td_backtick_exactly_2_esc),
};


bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    static uint16_t key_timer;
    switch (keycode) {
    case BACKTICK:
        if (record->event.pressed) {
            // when keycode QMKBEST is pressed
            SEND_STRING("`");
        } else {
            // when keycode QMKBEST is released
        }
        break;

    // and emoji keypress with a twist. Tap the key for emoji keyboard, long press for RCMD
    case MAC_EMOJI:
        if (record->event.pressed) { 
            key_timer = timer_read(); 
            register_code(KC_RGUI); 
        } 
        else { 
            unregister_code(KC_RGUI); 
            if (timer_elapsed(key_timer) < TAPPING_TERM) { 
                SEND_STRING(SS_DOWN(X_LCTL) SS_DOWN(X_LGUI) SS_TAP(X_SPACE) SS_UP(X_LCTL) SS_UP(X_LGUI)); 
            } 
        } 
        break;
    case WIN_EMOJI:
        if (record->event.pressed) { 
            key_timer = timer_read(); 
            register_code(KC_RALT); 
        } 
        else { 
            unregister_code(KC_RALT); 
            if (timer_elapsed(key_timer) < TAPPING_TERM) { 
                    // nothing
                    // SEND_STRING("wack");
                    SEND_STRING(SS_DOWN(X_LGUI) "." SS_UP(X_LGUI));
            } 
        } 
        break;
    case LOCK_SCREEN:
        if (record->event.pressed) { 
            SEND_STRING(SS_DOWN(X_LCTL) SS_DOWN(X_LGUI) "q" SS_UP(X_LCTL) SS_UP(X_LGUI));
        } 
        else { 
//            SEND_STRING(SS_DOWN(X_LCTL) SS_UP(X_LGUI));
        } 
        break;
    }

    return true;
};



const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {


    // mac os layers
    // DF(0) switch back to windows mode
    LAYOUT_60_ansi_split_bs_rshift(
        KC_GESC, KC_1,    KC_2,    KC_3,   KC_4,    KC_5, KC_6,     KC_7, KC_8,     KC_9,                KC_0,    KC_MINS,     KC_EQL,  XXXXXXX,     KC_BSPC,
        KC_TAB,          KC_Q,    KC_W,    KC_E,   KC_R,    KC_T, KC_Y,     KC_U, KC_I,     KC_O,                KC_P,    KC_LBRC,     KC_RBRC, KC_BSLS,
        LT(1,KC_CAPS),   KC_A,    KC_S,    KC_D,   KC_F,    KC_G, KC_H,     KC_J, KC_K,     KC_L,                KC_SCLN, KC_QUOT,     KC_ENT,
        KC_LSFT,         KC_Z,    KC_X,    KC_C,   KC_V,    KC_B, KC_N,     KC_M, KC_COMM,  KC_DOT,              KC_SLSH, MT(MOD_RSFT, KC_UP),  KC_APPLE_FN,
        KC_LCTL,         KC_LALT, KC_LGUI, KC_SPC, KC_RGUI, LT(1, KC_LEFT), LT(2, KC_DOWN), MT(MOD_RCTL,KC_RGHT)
    ),

    LAYOUT_60_ansi_split_bs_rshift(
        BACKTICK, KC_F1,   KC_F2,   KC_F3,    KC_F4,   KC_F5, KC_F6,   KC_F7,   KC_F8,   KC_F9,    KC_F10,  KC_F11,  KC_F12, XXXXXXX, KC_DEL,
        KC_TAB,   KC_Q,    KC_UP,   KC_E,     KC_R,    KC_T,  KC_Y,    KC_U,    KC_I,    KC_O,     KC_P,    KC_HOME, KC_END, KC_NO,
        KC_CAPS,  KC_LEFT, KC_DOWN, KC_RIGHT, KC_F,    KC_G,  KC_LEFT, KC_DOWN, KC_UP,   KC_RIGHT, KC_SCLN, KC_QUOT, KC_ENT,
        KC_LSFT,  KC_Z,    KC_X,    KC_C,     KC_V,    KC_B,  KC_N,    KC_M,    KC_COMM, KC_DOT,   KC_SLSH, KC_RSFT, DF(3),
        KC_LCTL,  KC_LALT, KC_LGUI, KC_SPC,   KC_RGUI, KC_C,  KC_D,    KC_RCTL
    ),

    LAYOUT_60_ansi_split_bs_rshift(
        LOCK_SCREEN, KC_BRMD, KC_BRMU, KC_3,   KC_4,    KC_5, KC_6, KC_7,   KC_8,    KC_9,   KC_0,    KC_AUDIO_VOL_DOWN, KC_AUDIO_VOL_UP,     XXXXXXX,             KC_MEDIA_PLAY_PAUSE,
        KC_TAB,      KC_Q,    KC_W,    KC_E,   KC_R,    KC_T, KC_Y, KC_U,   KC_I,    KC_O,   KC_P,    KC_LBRC,           KC_MEDIA_PREV_TRACK, KC_MEDIA_NEXT_TRACK,
        KC_CAPS,     KC_A,    KC_S,    KC_D,   KC_F,    KC_G, KC_H, KC_J,   KC_K,    KC_L,   KC_SCLN, KC_QUOT,           KC_ENT,
        KC_LSFT,     KC_Z,    KC_X,    KC_C,   KC_V,    KC_B, KC_N, KC_M,   KC_COMM, KC_DOT, KC_SLSH, KC_RSFT,           KC_INSERT,
        KC_LCTL,     KC_LALT, KC_LGUI, KC_SPC, KC_RGUI, KC_C, KC_D, KC_RCTL
    ),

    // DF(3) switches default layer to windows mode
    LAYOUT_60_ansi_split_bs_rshift(
        KC_GESC,       KC_1,    KC_2,    KC_3,   KC_4,    KC_5, KC_6,     KC_7, KC_8,     KC_9,                KC_0,    KC_MINS,     KC_EQL,  XXXXXXX,   KC_BSPC,
        KC_TAB,        KC_Q,    KC_W,    KC_E,   KC_R,    KC_T, KC_Y,     KC_U, KC_I,     KC_O,                KC_P,    KC_LBRC,     KC_RBRC, KC_BSLS,
        LT(4,KC_CAPS), KC_A,    KC_S,    KC_D,   KC_F,    KC_G, KC_H,     KC_J, KC_K,     KC_L,                KC_SCLN, KC_QUOT,     KC_ENT,
        KC_LSFT,       KC_Z,    KC_X,    KC_C,   KC_V,    KC_B, KC_N,     KC_M, KC_COMM,  KC_DOT,              KC_SLSH, MT(MOD_RSFT, KC_UP),  KC_INSERT,
        KC_LCTL,       KC_LGUI, KC_LALT, KC_SPC, KC_RALT, LT(4, KC_LEFT), LT(5, KC_DOWN), MT(MOD_RCTL,KC_RGHT)
    ),
    LAYOUT_60_ansi_split_bs_rshift(
        BACKTICK, KC_F1,   KC_F2,   KC_F3,    KC_F4,   KC_F5, KC_F6,   KC_F7,   KC_F8,   KC_F9,    KC_F10,  KC_F11,  KC_F12, XXXXXXX, KC_DEL,
        KC_TAB,   KC_Q,    KC_UP,   KC_E,     KC_R,    KC_T,  KC_Y,    KC_U,    KC_I,    KC_O,     KC_P,    KC_HOME, KC_END, KC_NO,
        KC_CAPS,  KC_LEFT, KC_DOWN, KC_RIGHT, KC_F,    KC_G,  KC_LEFT, KC_DOWN, KC_UP,   KC_RIGHT, KC_SCLN, KC_PGUP, KC_ENT,
        KC_LSFT,  KC_Z,    KC_X,    KC_C,     KC_V,    KC_B,  KC_N,    KC_M,    KC_COMM, KC_DOT,   KC_PGDN, KC_RSFT, DF(0),
        KC_LCTL,  KC_LGUI, KC_LALT, KC_SPC,   KC_RALT, KC_C,  KC_D,    KC_RCTL
    ),
    // windows media keys
    LAYOUT_60_ansi_split_bs_rshift(
        LOCK_SCREEN, KC_BRMD, KC_BRMU, KC_3,   KC_4,    KC_5, KC_6, KC_7,   KC_8,    KC_9,   KC_0,    KC_AUDIO_VOL_DOWN, KC_AUDIO_VOL_UP,     XXXXXXX,             KC_MEDIA_PLAY_PAUSE,
        KC_TAB,      KC_Q,    KC_W,    KC_E,   KC_R,    KC_T, KC_Y, KC_U,   KC_I,    KC_O,   KC_P,    KC_LBRC,           KC_MEDIA_PREV_TRACK, KC_MEDIA_NEXT_TRACK,
        KC_CAPS,     KC_A,    KC_S,    KC_D,   KC_F,    KC_G, KC_H, KC_J,   KC_K,    KC_L,   KC_SCLN, KC_QUOT,           KC_ENT,
        KC_LSFT,     KC_Z,    KC_X,    KC_C,   KC_V,    KC_B, KC_N, KC_M,   KC_COMM, KC_DOT, KC_SLSH, KC_RSFT,           KC_INSERT,
        KC_LCTL,     KC_LGUI, KC_LALT, KC_SPC, KC_RALT, KC_C, KC_D, KC_RCTL
    ),




   
};
