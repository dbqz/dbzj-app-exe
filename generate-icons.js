const fs = require('fs');
const path = require('path');

// 简单的方法：复制PNG文件并重命名为ico
// 在实际项目中，你可能需要使用专门的工具来创建真正的ico文件

const sourceIcon = 'src-tauri/icons/round.PNG';
const targetIco = 'src-tauri/icons/icon.ico';
const targetIcns = 'src-tauri/icons/icon.icns';

// 复制文件作为临时解决方案
fs.copyFileSync(sourceIcon, targetIco);
fs.copyFileSync(sourceIcon, targetIcns);

console.log('图标文件已生成');
console.log('注意：这是临时解决方案，建议使用专门的工具生成真正的ico和icns文件');