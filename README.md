参考Cores-VeeR-EH1项目
(https://github.com/chipsalliance/Cores-VeeR-EH1.git)

## 一、环境配置

### 1.1 RISC-V工具链

#### 1.1.1 克隆仓库
该过程时间较长
```
git clone https://github.com/riscv-collab/riscv-gnu-toolchain.git
cd riscv-gnu-toolchain
git submodule update --init --recursive
```
#### 1.1.2 配置编译
```
./configure --prefix=/home/wyj/opt/riscv/rv32imc --with-arch=rv32imc --with-abi=ilp32
make -j
```
#### 1.1.3 添加路径
```
export PATH=/home/wyj/opt/riscv/rv32imc/bin:$PATH
```

### 1.2 Verilator

#### 1.2.1 克隆仓库
```
git clone https://github.com/verilator/verilator 
cd verilator
git checkout v4.220
```
#### 1.2.2 编译
该过程会自动添加可执行文件至本地bin目录
```
autoconf
./configure
make -j
sudo make install
```

### 1.3 Espresso

#### 1.3.1 克隆仓库
```
git clone https://github.com/classabbyamp/espresso-logic.git
```
#### 1.3.2 编译
该过程需手动添加可执行文件至本地bin目录
```
cd espresso-logic/espresso-src
make
sudo cp ../bin/espresso /usr/local/bin
```

## 二、仿真测试

### 2.1 配置项目路径
```
export RV_ROOT=/home/wyj/work/eh1-rv32
```

### 2.2 建立并进入仿真目录
```
cd $RV_ROOT
mkdir build
cd build
```

### 2.3 执行测试

1. 配置target=default或target=high_perf

2. 配置eh1-rv32/testbench/asm/crt0.s和eh1-rv32/testbench/tb_top.sv以打开硬件性能计数器

3. 配置debug=1以生成vcd文件，从而使用gtkwave观测波形

#### 2.3.1 测试Hello_world
```
make -f $RV_ROOT/tools/Makefile verilator target=high_perf TEST=hello_world
```
#### 2.3.2 测试Dhrystone
可修改eh1-rv32/testbench/tests/dhrystone/dhrystone.mki内迭代次数，默认值10000
```
make -f $RV_ROOT/tools/Makefile verilator target=high_perf TEST=dhrystone
```
#### 2.3.3 测试Coremark
可修改eh1-rv32/testbench/tests/coremark/coremark.mki内迭代次数，默认值50
```
make -f $RV_ROOT/tools/Makefile verilator target=high_perf TEST=coremark
```

## 三、使用Espresso进行逻辑简化

### 3.1 生成译码逻辑
```
cd ${RV_ROOT}/design/dec
${RV_ROOT}/tools/coredecode -in decode > coredecode.e
espresso -Dso -oeqntott coredecode.e | ${RV_ROOT}/tools/addassign -pre out. > equations
```

### 3.2 生成legal逻辑
```
cd ${RV_ROOT}/design/dec
${RV_ROOT}/tools/coredecode -in decode -legal > legal.e
espresso -Dso -oeqntott legal.e |  ${RV_ROOT}/tools/addassign -pre out. > legal_equation
```
将生成的equations和legal_equation内的assign语句，复制到dec_decode_ctl.sv内译码器中，即完成译码逻辑简化