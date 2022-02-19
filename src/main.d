__gshared ubyte* vga = cast(ubyte*)0xb8000;
__gshared ulong vgaoff = 2;

void putc(char c) {
    vga[vgaoff+0] = c;
    vga[vgaoff+1] = 0xf;
    vgaoff += 2;
}
void puts(string s) {
    foreach(c; s) {
        putc(c);
    }
    vgaoff = (vgaoff / 160 + 1) * 160 + 2;
    vga[vgaoff] = ' ';
    vga[vgaoff+1] = 0xf0;
}

extern(C) void _start() {
    foreach (i; 0 .. 80*25*2) {
        vga[i] = 0;
    }
    puts("Welcome to D on bare metal x86_64!");
    puts("  => github.com/all-the-barebones/dlang");

    while(true) asm { cli; hlt; }
}