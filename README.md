# RISC-V E-SDK automatically build tools

Special

-   automatically download and build gnu toolchain tools

-   automatically download and build e-sdk

-   automatically generate environment

Support OS: Ubuntu

Install

```
make install
source ~/.bashrc
```

Uninstall
```
make clean
```

Modify e-sdk and other version(In Makefile line 3-5)
```
GNU_TOOLCHAIN
OPENOCD
QEMU
```
