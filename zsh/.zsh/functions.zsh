# Create a new directory and enter it
function md() {
	mkdir -p "$@" && cd "$@"
}

# find shorthand
function f() {
    find . -name "$1"
}

# Copy w/ progress
function cp_p () {
  rsync -WavP --human-readable --progress $1 $2
}
