<script setup>
import { ref } from 'vue'
import Sidebar from './components/Sidebar.vue'

const websiteUrl = ref('https://qzwb.asia/')

const handleNavigate = (url) => {
  websiteUrl.value = url
}
</script>

<template>
  <div class="app-container">
    <Sidebar @navigate="handleNavigate" />
    <div class="content-area">
      <iframe 
        :src="websiteUrl" 
        class="website-frame"
        frameborder="0"
        allowfullscreen
      ></iframe>
    </div>
  </div>
</template>

<style scoped>
.app-container {
  width: 100vw;
  height: 100vh;
  margin: 0;
  padding: 0;
  overflow: hidden;
  display: flex;
}

.content-area {
  flex: 1;
  height: 100vh;
  overflow: hidden;
}

.website-frame {
  width: 100%;
  height: 100%;
  border: none;
}
</style>
