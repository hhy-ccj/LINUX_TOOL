#!/bin/sh
filter_path="find . \
			 ! -path "*git*" \
			 ! -path ".*br16*" \
			 ! -path ".*bt16*" \
			 ! -path ".*mini_uboot*" \
			 ! -path ".*ac461x_uboot_lib*" \
			 ! -path ".*ram1_fix_run*""

file_format='.*\.\(c\|h\|s\|S\|ld\)'

# echo $filter_path
rm tags cscope.out filenametags
$filter_path -regex $file_format | xargs ctags -R --fields=+lS --languages=+Asm --c++-kinds=+p --fields=+iaS --extra=+q
# ctags -R --fields=+lS --languages=+Asm --c++-kinds=+p --fields=+iaS --extra=+q
# ctags -R --c++-kinds=+p --fields=+liaS --extra=+q .
# cscope -bR
# find ! -path "*br17*" ! -path "*ac461x_uboot_lib*" ! -path "*bt16*" -regex '.*\.\(c\|h\)' > cscope.input
$filter_path -regex $file_format > cscope.input
cscope -b -i cscope.input
echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/">filenametags
# find . -not -regex '.*\.\(png\|gif\|o\|d\|obj\|swp\)' ! -path "*br17*" ! -path "*ac461x_uboot_lib*" ! -path "*bt16*" ! -path "*git*" -type f -printf "%f\t%p\t1\n" | sort -f>>filenametags
$filter_path -not -regex '.*\.\(png\|gif\|o\|d\|obj\|swp\)' -type f -printf "%f\t%p\t1\n" | sort -f>>filenametags
