// Non-blocking keyboard input with 10 ms delay (get_ch)
// Reference: http://stackoverflow.com/a/6665815 and http://stackoverflow.com/a/13129698

#if defined(__unix__) || defined(__APPLE__)

  #include <stdio.h>
  #include <termios.h>
  #include <unistd.h>
  #include <sys/time.h>

  void get_ch(int*);
  void changemode(int);
  int  kbhit(void);

  void get_ch(int *ch) {
    changemode(1);
    usleep(10000);
    if (kbhit()) {
      *ch = getchar();
    } else {
      *ch = 0;
    }
    changemode(0);
    return;
  }

  void changemode(int dir) {
    static struct termios oldt, newt;
    if (dir == 1) {
      tcgetattr(STDIN_FILENO, &oldt);
      newt = oldt;
      newt.c_lflag &= ~(ICANON | ECHO);
      tcsetattr(STDIN_FILENO, TCSANOW, &newt);
    } else {
      tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
    }
  }

  int kbhit(void) {
    struct timeval tv;
    fd_set rdfs;
    tv.tv_sec = 0;
    tv.tv_usec = 0;
    FD_ZERO(&rdfs);
    FD_SET(STDIN_FILENO, &rdfs);
    select(STDIN_FILENO + 1, &rdfs, NULL, NULL, &tv);
    return FD_ISSET(STDIN_FILENO, &rdfs);
  }

#else  

  #include <conio.h>
  #include <windows.h>

  void get_ch(int*);

  void get_ch(int *ch) {
    Sleep(10);
    if (kbhit()) {
      *ch = getch();
    } else {
      *ch = 0;
    }
    return;
  }

#endif
