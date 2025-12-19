import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src')
    }
  },
  server: {
    port: 3000,
    host: '0.0.0.0',
    fs: {
      strict: false,
      allow: ['..']
    }
  },
  optimizeDeps: {
    include: [
      'vue',
      'vue-router',
      'vuex',
      'ant-design-vue',
      'echarts',
      'echarts-gl',
      '@turf/turf',
      'axios',
      'dayjs',
      'lodash'
    ],
    exclude: []
  },
  build: {
    target: 'es2015',
    chunkSizeWarningLimit: 2000,
    rollupOptions: {
      output: {
        manualChunks: {
          'vue-vendor': ['vue', 'vue-router', 'vuex'],
          'ui-vendor': ['ant-design-vue'],
          'charts': ['echarts', 'echarts-gl'],
          'utils': ['@turf/turf', 'axios', 'dayjs', 'lodash']
        }
      }
    }
  },
  define: {
    __VUE_OPTIONS_API__: true,
    __VUE_PROD_DEVTOOLS__: false
  }
})
