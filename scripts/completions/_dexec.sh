#compdef dexec


_dexec() {
  local state

  _arguments \
    '1: :->container'\
    # '*: :->eb_name'

  case $state in
    (container) compadd $(docker ps --format "{{.Names}}");;
              # (*) compadd "$@" prod staging dev
  esac
}

_dexec "$@"

# _arguments '1:first arg:__docker_runningcontainers'
