cs() {
    local dir=""
    local -a ls_args=()
    # Pass first non flag to cd and the rest as flags to ls
    for arg in "$@"; do
        if [[ "$arg" != -* && -z "$dir" ]]; then
            dir="$arg"
        else
            ls_args+=("$arg")
        fi
    done
    if [[ -n "$dir" ]] then
        cd "$dir" || return
    else
        cd || return
    fi
    ls "${ls_args[@]}"
}