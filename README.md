# Rime（小狼毫）输入法配置

## 目标解决的痛点

跨平台工作用系统默认输入法，作为 Windows 平台微软输入法的难民，切换一个 IME 肯定需要有充足的理由，且 Rime 输入法的自定义能力可以满足我的需求。

- 按 `[` 键要能输入 `「`，而不是 `【`
- 指定程序中默认英文模式
- CapsLock 键作为输入法切换键

## 下载词库

词库和模型文件较大，不适合通过 Git 传播，这部分数据需要手动下载。
安装 [Task](https://taskfile.dev/) 后运行如下命令下载（当前仅为 Windows 平台适配）

```bash
task download-assets
```

## 功能用法

- <kbd>Ctrl+Shift+F5</kbd> 调出模式选单，把 `声杳` 改为 `声起` 可以显示声调。

## 参考及感谢

- [Rime 官方文档](https://rime.im/)
- [Rime 双拼方案](https://github.com/rime/rime-double-pinyin)
- [Oh-My-Rime 薄荷输入法](https://www.mintimate.cc/)
- [万象语法模型](https://github.com/amzxyz/RIME-LMDG)
- [白霜拼音词库](https://github.com/gaboolic/rime-frost)
- [LufsX/rime](https://github.com/LufsX/rime)
- [ASC8384/myRime](https://github.com/ASC8384/myRime)
