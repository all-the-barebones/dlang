set -ex

nasm -fbin bootelf/bootelf.asm -o build/bootelf.bin -Ibootelf
ldc2 --mtriple=x86_64-elf src/*.d --oq --od build -c -betterC
ld.lld -Tsrc/linker.ld build/*.o -o build/atb_dlang.elf

cat build/bootelf.bin build/atb_dlang.elf >build/atb_dlang.bin
