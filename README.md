# DBZJ浏览器 - Electron桌面应用

这是一个基于 Vue 3 + Vite + Electron 的桌面应用程序，用于在独立窗口中显示指定网站内容。

## 功能特性

- 🖥️ 使用 Electron 打包成桌面应用（支持 Windows/Mac/Linux）
- 🚀 基于 Vue 3 + Vite 构建
- 🌐 内嵌网站显示：https://qzwb.asia/
- 📦 可打包成 .exe 可执行文件

## 项目设置

### 安装依赖

```sh
npm install
```

## 开发模式

### Web开发模式（浏览器）

```sh
npm run dev
```

### Electron开发模式（桌面应用）

首先在一个终端启动 Vite 开发服务器：
```sh
npm run dev
```

然后在另一个终端启动 Electron：
```sh
npm run electron:dev
```

## 打包成可执行文件

### 使用 Tauri 打包（推荐，体积更小）

#### Tauri 开发模式
```sh
npm run tauri:dev
```

#### 打包成可执行文件

**方法1：使用 GitHub Actions 自动打包 Windows EXE（推荐）**

1. 将代码推送到 GitHub
2. GitHub Actions 会自动打包
3. 在 Actions 页面下载打包好的 exe 文件

详细步骤请查看 [BUILD_WINDOWS.md](./BUILD_WINDOWS.md)

**方法2：本地打包（需要对应系统）**
```sh
# Mac 系统打包 Mac 应用
npm run tauri:build

# Windows 系统打包 Windows exe
npm run tauri:build
```

打包后的文件会在 `src-tauri/target/release/bundle` 目录中生成。

### 使用 Electron 打包（备选方案）

#### 打包成 Windows exe 文件
```sh
npm run electron:build:win
```

#### 打包成 Mac dmg 文件
```sh
npm run electron:build:mac
```

#### 打包成 Linux AppImage 文件
```sh
npm run electron:build:linux
```

打包后的文件会在 `release` 目录中生成。

## 项目结构

```
dbzj-exe/
├── electron/          # Electron 主进程文件
│   ├── main.js       # Electron 入口文件
│   └── preload.js    # 预加载脚本
├── src/              # Vue 源代码
│   └── App.vue       # 主应用组件（显示网站）
├── dist/             # 构建输出目录
├── release/          # Electron 打包输出目录
└── package.json      # 项目配置
```

## 技术栈

- **前端框架**: Vue 3
- **构建工具**: Vite
- **桌面框架**: Tauri (推荐) / Electron (备选)
- **打包工具**: Tauri CLI / electron-builder
- **图标库**: Lucide Vue Next

## 注意事项

- 确保已安装 Node.js (版本 20.19.0 或 22.12.0+)
- Windows 打包需要在 Windows 系统上进行
- Mac 打包需要在 macOS 系统上进行
- 首次打包会下载 Electron 二进制文件，可能需要较长时间
