@echo off
del tags cscope.out filenametags
ctags -R --fields=+lS --languages=+Asm
cscope -bR
::echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/">filenametags
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
   %~dp0\win32\find_linux32 . -not -regex ".*\.\(doc\|pdf\|o\|d\|obj\|lst\)" ^
   ! -path "*git*" ^
   ! -path "*bt16*" ^
   ! -path "*br16*" ^
   ! -path "*tools*" ^
   ! -path "*download*" ^
   ! -path "*doc*" ^
   -type f -printf "%1" | %~dp0\win32\sort_linux32 -f>>filenametags
)
if "%PROCESSOR_ARCHITECTURE%"=="x64" (
   %~dp0\win64\find_linux64 . -not -regex ".*\.\(doc\|pdf\|o\|d\|obj\|lst\)" ! -path "*git*" ! -path "*bt16*" -type f -printf "%1" | %~dp0\win64\sort_linux64 -f>>filenametags
)
