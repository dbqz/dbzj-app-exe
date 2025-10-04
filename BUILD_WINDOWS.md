# 如何使用 GitHub Actions 打包 Windows EXE

## 步骤说明

### 1. 将代码推送到 GitHub

首先需要将项目上传到 GitHub：

```bash
# 初始化 git（如果还没有）
git init

# 添加所有文件
git add .

# 提交
git commit -m "Initial commit"

# 添加远程仓库（替换成你的 GitHub 仓库地址）
git remote add origin https://github.com/你的用户名/dbzj-exe.git

# 推送到 GitHub
git push -u origin main
```

如果你的默认分支是 `master` 而不是 `main`，使用：
```bash
git push -u origin master
```

### 2. 触发自动打包

推送代码后，GitHub Actions 会自动开始打包。你也可以手动触发：

1. 打开你的 GitHub 仓库
2. 点击 **Actions** 标签
3. 选择 **Build Windows EXE** 工作流
4. 点击右侧的 **Run workflow** 按钮
5. 点击绿色的 **Run workflow** 确认

### 3. 下载打包好的 EXE

等待打包完成（大约 5-10 分钟）：

1. 在 Actions 页面，点击最新的工作流运行
2. 滚动到底部的 **Artifacts** 部分
3. 下载 `windows-installer` 文件
4. 解压后就能得到 `.exe` 安装程序

## 打包内容

- **NSIS 安装程序** (.exe) - Windows 标准安装程序
- **MSI 安装程序** (.msi) - 可选的 Windows Installer 格式

## 注意事项

- 首次打包可能需要较长时间（10-15分钟）
- 后续打包会更快（5-8分钟）
- 完全免费，GitHub Actions 提供免费的构建时间
- 不需要 Windows 电脑，在 Mac 上也能打包 Windows 程序

## 本地测试

如果你有 Windows 电脑，也可以本地打包：

```bash
npm install
npm run tauri:build
```

打包后的文件在：`src-tauri/target/release/bundle/nsis/`
