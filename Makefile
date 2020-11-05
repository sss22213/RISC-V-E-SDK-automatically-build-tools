SIFIVE_DEV_TOOLS = https://static.dev.sifive.com/dev-tools
OS=ubuntu14
GNU_TOOLCHAIN = riscv64-unknown-elf-gcc-8.3.0-2020.04.0-x86_64-linux-${OS}.tar.gz
OPENOCD = riscv-openocd-0.10.0-2020.04.6-x86_64-linux-${OS}.tar.gz
QEMU = riscv-qemu-4.2.0-2020.04.0-x86_64-linux-${OS}.tar.gz

GNU_TOOLCHAIN_FOLDER = ```echo ${GNU_TOOLCHAIN} | sed 's/'.tar.gz'/''/g'```
OPENOCD_FOLDER = ```echo ${OPENOCD} | sed 's/'.tar.gz'/''/g'```
QEMU_FOLDER = ```echo ${QEMU} | sed 's/'.tar.gz'/''/g'```

.PHONY: all install

install: clean install_init install_gnu_toolchain install_openocd install_qemu install_freedom_e_sdk install_freedom_e_sdk_python

install_init:
	mkdir -p tools
	sudo mkdir -p /opt/sifive
	touch e_sdk_env.bash
	echo "#!/usr/bin/bash" >> e_sdk_env.bash

install_gnu_toolchain:
	sudo wget ${SIFIVE_DEV_TOOLS}/${GNU_TOOLCHAIN} -O tools/${GNU_TOOLCHAIN}
	sudo tar zxvf tools/${GNU_TOOLCHAIN} -C /opt/sifive
	echo "export RISCV_PATH=/opt/sifive/${GNU_TOOLCHAIN_FOLDER}" >> e_sdk_env.bash

install_openocd:
	sudo wget ${SIFIVE_DEV_TOOLS}/${OPENOCD} -O tools/${OPENOCD}
	sudo tar zxvf tools/${OPENOCD} -C /opt/sifive
	echo "export RISCV_OPENOCD_PATH=/opt/sifive/${OPENOCD_FOLDER}" >> e_sdk_env.bash

install_qemu:
	sudo wget ${SIFIVE_DEV_TOOLS}/${QEMU} -O tools/${QEMU}
	sudo tar zxvf tools/${QEMU} -C /opt/sifive
	echo "export PATH=/opt/sifive/${QEMU_FOLDER}:$(PATH)" >> e_sdk_env.bash

install_freedom_e_sdk:
	git clone --recursive https://github.com/sifive/freedom-e-sdk.git
	cd freedom-e-sdk;git submodule update --init --recursive

install_freedom_e_sdk_python:
	cd freedom-e-sdk;make pip-cache
	echo "export FREEDOM_E_SDK_PIP_CACHE_PATH=```pwd```/freedom-e-sdk/pip-cache" >> e_sdk_env.bash
	mkdir -p venv
	echo "export FREEDOM_E_SDK_VENV_PATH=```pwd```/venv" >> e_sdk_env.bash
	
clean:
	rm -rf venv
	rm -f e_sdk_env.bash
	rm -rf tools
	rm -rf freedom-e-sdk
	sudo rm -rf /opt/sifive
