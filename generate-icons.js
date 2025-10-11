const fs = require('fs');
const toIco = require('to-ico');

async function generateIcons() {
  try {
    // 读取源图标文件
    const sourceIcon = fs.readFileSync('src-tauri/icons/round.PNG');
    
    // 生成ICO文件
    const icoBuffer = await toIco([sourceIcon]);
    fs.writeFileSync('src-tauri/icons/icon.ico', icoBuffer);
    
    // 对于icns文件，我们暂时使用PNG文件
    fs.copyFileSync('src-tauri/icons/round.PNG', 'src-tauri/icons/icon.icns');
    
    console.log('✅ 图标文件已生成');
    console.log('  - icon.ico: Windows ICO格式');
    console.log('  - icon.icns: macOS图标（PNG格式）');
    
  } catch (error) {
    console.error('❌ 生成图标文件时出错:', error);
  }
}

generateIcons();