nasm -o boot.bin boot.s

# dd if=boot.bin of=../../hd60M.img bs=512 count=1 conv=notrunc
