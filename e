#!/bin/bash -
# :vim sw=2:ts=2:et
# Copied from git://github.com/lzap/dancepill.git

e() {
  for F in "$@"; do
    if [ -f "$F" ] ; then
      FT1=$(file -b --mime-type "$F" | grep -Eo '[[:alnum:]_-]+/[[:alnum:]_-]+')
      #FT1=$(file -bi "$F" | grep -Eo '[[:alnum:]_-]+/[[:alnum:]_-]+')
      #DIR="$F-e"
	  dirnm=`dirname $F`
	  basnm=`basename $F`
	  DIR="${dirnm}/${basnm%%.*}"
      mkdir "$DIR" || exit 1
      pushd "$DIR"
      case $FT1 in
        "application/x-bzip2") tar xjf "../$F" || bunzip2 "../$F" ;;
        "application/x-gzip") tar xzf "../$F" || gunzip "../$F" ;;
        "application/x-xz") tar xJf "../$F" ;;
        "application/x-rar") unrar x "../$F" || rar x "../$F" ;;
        "application/x-arj") arj x "../$F" || 7za x "../$F" ;;
        "application/x-lha") lha x "../$F" || 7za x "../$F" ;;
        "application/x-cpio") cpio -i "../$F" ;;
        "application/x-tar") tar xf "../$F" || gunzip "../$F" ;;
        "application/x-zip") unzip "../$F" ;;
        "application/zip") unzip "../$F" ;;
        "application/x-7z-compressed") 7za x "../$F" ;;
        "application/x-7za-compressed") 7za x "../$F" ;;
        "application/octet-stream") unlzma "../$F" || 7za x "../$F" || uncompress "../$F" ;;
        *) echo "'../$F' ($FT1) cannot be extracted via e() bash function" ;;
      esac
      popd
      # expecting only one file
      if [ "$(\ls "$DIR" | wc -l)" == "1" ]; then
        mv -v "$DIR"/* . && rmdir "$DIR"
      fi
    else
      echo "'$F' is not a valid file"
    fi
  done
}
