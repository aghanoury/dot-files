# this file provides useful aliases and functions for common git actions

alias ga='git add'
alias cm='git commit -m'
alias gpush='git push'
alias gpull='git pull'
alias gs='git status'

# add, commit, and push all in one go
function acp() {
	git add -A
	git commit -am $1
	git push
}

function check_dot_files () {
	
	old_cwd=$(pwd) # save cwd
	cd ~/.dot-files # cd
	# echo "Updating .dot-files..."
	# git pull

	st=( $(git status --porcelain) )
	if [[ -n "$st" ]]; then
		git status

		echo "WARNING: Changes found in .dot-files"
		# echo "Changes found in .dot-files"
		# read -k "?Add, commit, and push changes? [Y/n] " yn
		# echo # blank line
		# case $yn in
			# ACP, print file differences
			# [Yy]* ) 
				# read "?Commit message: " message
				# git add .
				# git commit -am "$message"
				# git push
				# ;;
			# * ) echo "Not commiting changes";;
		# esac
	fi

	cd $old_cwd	
}
