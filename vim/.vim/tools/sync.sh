#!/bin/sh
rm tags cscope.out filenametags
ctags -R --fields=+lS --languages=+Asm
cscope -bR
echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/">filenametags
find . -not -regex '.*\.\(png\|gif\|o\|d\|obj\)'  ! -path "*git*" -type f -printf "%f\t%p\t1\n" | sort -f>>filenametags
