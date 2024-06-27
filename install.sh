#!/bin/sh

die() {
    printf '\33[1;91mfatal:\33[m %s\n' "$2" 1>&2
    exit "$1"
}

wd="$(dirname "$0")"
cd "$wd" || die 69 'Cannot `cd` into correct directory! I give up!'
unset wd

# find XDG_DATA_HOME
if [ -n "$XDG_DATA_HOME" ]; then
    target_dir="$XDG_DATA_HOME"/fastfetch/logos
else
    target_dir="$HOME"/.local/share/fastfetch/logos
fi

# mkdir the logos directory
mkdir -p "$target_dir" || die 2 'Directory creation failed! I don'"'"'t know what to do!'

# Try to ln the source files to where they need to go
# if that fails, try again with a symlink
if ! ln -i logos/cat1 "$target_dir"/cat1; then
    echo Trying again with a symlink... 1>&2
    ln -si logos/cat1 "$target_dir"/cat1 || die 3 'I can'"'"'t link the logo file! RAAAAAAH!!!'
fi

#echo Logo file linked successfully! \<3 1>&2
printf 'Logo file linked successfully! \33[1;95m<3\33[m\n' 1>&2

