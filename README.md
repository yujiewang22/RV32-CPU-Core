## 一、环境配置

### 1.1 rv32imc工具链
(https://github.com/riscv-collab/riscv-gnu-toolchain.git)

将rv32imc工具链添加到～/.bashrc内
```
export PATH=/home/wyj/opt/riscv/rv32imc/bin:$PATH
```

### 1.2 Verilator
(https://github.com/verilator/verilator.git)

将Verilator添加到本地bin目录内

### 1.3 Espresso
(https://github.com/classabbyamp/espresso-logic.git)

将Espresso添加到本地bin目录内

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