WSL OPEN:
https://gitlab.com/4U6U57/wsl-open

WSLU:
https://wslutiliti.es/blog/2021/12/01/brand-new-arch-linux-server/

sudo pacman-key --init
sudo pacman-key -r A2861ABFD897DD37

wget https://pkg.wslutiliti.es/public.key
pacman-key --add public.key

sudo pacman -Syu