del tags cscope.out filenametags
ctags -R --fields=+lS --languages=+Asm
cscope -bR
::echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/">filenametags
find_linux . -not -regex ".*\.\(doc\|pdf\|o\|d\|obj\|lst\)" ! -path "*git*" -type f -printf "%1" | sort_linux -f>>filenametags
