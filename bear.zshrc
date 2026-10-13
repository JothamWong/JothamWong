make() {
    if [[ "$1" == "clean" || "$*" == *" clean"* ]]; then
        command make "$@"
    else
        command bear --append -- make "$@"
    fi
}