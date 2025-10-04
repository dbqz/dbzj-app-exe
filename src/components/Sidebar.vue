<script setup>
import { ref } from 'vue'
import { Home, LogIn, LayoutDashboard, ChevronLeft, ChevronRight } from 'lucide-vue-next'

const emit = defineEmits(['navigate'])
const isCollapsed = ref(false)

const menuItems = [
  {
    id: 'home',
    label: '首页',
    url: 'https://qzwb.asia/',
    icon: Home
  },
  {
    id: 'login',
    label: '登录',
    url: 'https://qzwb.asia/login',
    icon: LogIn
  },
  {
    id: 'dashboard',
    label: '仪表盘',
    url: 'https://qzwb.asia/dashboard',
    icon: LayoutDashboard
  }
]

const activeItem = ref('home')

const toggleSidebar = () => {
  isCollapsed.value = !isCollapsed.value
}

const navigateTo = (item) => {
  activeItem.value = item.id
  emit('navigate', item.url)
}
</script>

<template>
  <div class="sidebar" :class="{ collapsed: isCollapsed }">
    <div class="sidebar-header">
      <h2 v-if="!isCollapsed" class="sidebar-title">定边职教</h2>
      <button class="toggle-btn" @click="toggleSidebar">
        <ChevronLeft v-if="!isCollapsed" :size="20" />
        <ChevronRight v-if="isCollapsed" :size="20" />
      </button>
    </div>

    <nav class="sidebar-nav">
      <button
        v-for="item in menuItems"
        :key="item.id"
        class="nav-item"
        :class="{ active: activeItem === item.id }"
        @click="navigateTo(item)"
        :title="isCollapsed ? item.label : ''"
      >
        <component :is="item.icon" :size="20" class="nav-icon" />
        <span v-if="!isCollapsed" class="nav-label">{{ item.label }}</span>
      </button>
    </nav>

    <div class="sidebar-footer">
      <div v-if="!isCollapsed" class="copyright">
        <p class="copyright-text">© 2025 定边职教</p>
        <p class="copyright-subtext">版权所有</p>
      </div>
      <div v-else class="copyright-icon">©</div>
    </div>
  </div>
</template>

<style scoped>
.sidebar {
  width: 240px;
  height: 100vh;
  background: linear-gradient(180deg, #1e293b 0%, #0f172a 100%);
  color: #fff;
  display: flex;
  flex-direction: column;
  transition: width 0.3s ease;
  box-shadow: 2px 0 8px rgba(0, 0, 0, 0.3);
  position: relative;
  z-index: 100;
}

.sidebar.collapsed {
  width: 70px;
}

.sidebar-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 20px 16px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  min-height: 70px;
}

.sidebar-title {
  font-size: 18px;
  font-weight: 600;
  margin: 0;
  white-space: nowrap;
  overflow: hidden;
  flex: 1;
  text-align: center;
}

.toggle-btn {
  background: rgba(255, 255, 255, 0.1);
  border: none;
  color: #fff;
  width: 32px;
  height: 32px;
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s ease;
  flex-shrink: 0;
}

.toggle-btn:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: scale(1.05);
}

.sidebar-nav {
  flex: 1;
  padding: 16px 8px;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.nav-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px 16px;
  background: transparent;
  border: none;
  color: rgba(255, 255, 255, 0.7);
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s ease;
  text-align: left;
  width: 100%;
  font-size: 14px;
  font-weight: 500;
}

.sidebar.collapsed .nav-item {
  justify-content: center;
  padding: 12px;
}

.nav-item:hover {
  background: rgba(255, 255, 255, 0.1);
  color: #fff;
  transform: translateX(4px);
}

.sidebar.collapsed .nav-item:hover {
  transform: translateX(0) scale(1.05);
}

.nav-item.active {
  background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
  color: #fff;
  box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
}

.nav-icon {
  flex-shrink: 0;
}

.nav-label {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.sidebar.collapsed .nav-label {
  display: none;
}

.sidebar-footer {
  padding: 16px;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  background: rgba(0, 0, 0, 0.2);
}

.copyright {
  text-align: center;
}

.copyright-text {
  font-size: 12px;
  color: rgba(255, 255, 255, 0.6);
  margin: 0 0 4px 0;
  font-weight: 500;
}

.copyright-subtext {
  font-size: 11px;
  color: rgba(255, 255, 255, 0.4);
  margin: 0;
}

.copyright-icon {
  text-align: center;
  font-size: 16px;
  color: rgba(255, 255, 255, 0.5);
  font-weight: 600;
}
</style>
