const fs = require('fs');

// 创建一个最小的有效ICO文件头
// 这是一个16x16像素的简单ICO文件结构
const icoHeader = Buffer.from([
  0x00, 0x00, // Reserved (must be 0)
  0x01, 0x00, // Image type (1 = ICO)
  0x01, 0x00, // Number of images
  // Image directory entry
  0x10,       // Width (16 pixels)
  0x10,       // Height (16 pixels)
  0x00,       // Color count (0 = no palette)
  0x00,       // Reserved
  0x01, 0x00, // Color planes
  0x20, 0x00, // Bits per pixel (32)
  0x00, 0x04, 0x00, 0x00, // Image size (1024 bytes)
  0x16, 0x00, 0x00, 0x00  // Image offset (22 bytes)
]);

// 创建一个简单的32位RGBA图像数据 (16x16 = 256 pixels * 4 bytes = 1024 bytes)
const imageData = Buffer.alloc(1024);
// 填充为蓝色像素 (BGRA格式)
for (let i = 0; i < 1024; i += 4) {
  imageData[i] = 0xFF;     // Blue
  imageData[i + 1] = 0x00; // Green
  imageData[i + 2] = 0x00; // Red
  imageData[i + 3] = 0xFF; // Alpha
}

// 合并头部和图像数据
const icoFile = Buffer.concat([icoHeader, imageData]);

// 写入文件
fs.writeFileSync('src-tauri/icons/icon.ico', icoFile);
console.log('创建了基本的ICO文件');