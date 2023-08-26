# Lux

Lux System from ZERO to DEATH

## 结构说明

```
└── src       # 源码目录
    └── boot  # 系统引导程序目录
```

- **.bochsrc** 为 `bochs` 配置文件
- **.bochsrc.bak** 为备份的默认 `bochs` 配置文件（文件为 `v2.7` 版本的 `bochs` 提供）
- **build** 文件里面写了使用源文件的方法

## 启动虚拟机

确保你已安装了 `bochs` ，之后你可以直接运行 `run.sh` 启动虚拟机。

你可以根据 `build` 文件内容手动执行指令并单独测试各源程序。（可能需要安装 **nasm**）

