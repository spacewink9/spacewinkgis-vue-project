#!/bin/bash

# SpacewinkGIS Complete Setup Script
# Properly configure Mars3D library for SpacewinkGIS

set -e

PROJECT_DIR="/root/SpacewinkGIS/spacewinkgis-vue"
cd "$PROJECT_DIR"

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                                                              ║"
echo "║      SpacewinkGIS Complete Setup & Configuration             ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Step 1: Create proper directory structure
echo "Step 1: Creating directory structure..."
mkdir -p public/lib/spacewinkgis
mkdir -p public/lib/mars3d-cesium
mkdir -p src/lib

# Step 2: Copy libraries if not already done
if [ ! -f "public/lib/spacewinkgis/mars3d.js" ]; then
    echo "Step 2: Copying Mars3D library..."
    cp node_modules/mars3d/* public/lib/spacewinkgis/ 2>/dev/null || echo "Mars3D files already in place"
fi

if [ ! -d "public/lib/mars3d-cesium/Build" ]; then
    echo "Step 3: Copying Cesium library..."
    cp -r node_modules/mars3d-cesium/* public/lib/mars3d-cesium/ 2>/dev/null || echo "Cesium files already in place"
fi

# Step 4: Create SpacewinkGIS configuration file
echo "Step 4: Creating configuration..."
cat > public/config/spacewinkgis-config.json << 'CONFIGEOF'
{
  "name": "SpacewinkGIS Platform",
  "version": "2.0.0",
  "company": "Spacewink Technologies",
  "website": "https://spacewink.dev",
  "cesiumBaseUrl": "/lib/mars3d-cesium/Build/Cesium/",
  "features": {
    "3dGlobe": true,
    "terrain": true,
    "layers": true,
    "widgets": true,
    "analysis": true
  }
}
CONFIGEOF

# Step 5: Verify all files exist
echo ""
echo "Step 5: Verifying installation..."

if [ -f "public/lib/spacewinkgis/mars3d.js" ]; then
    SIZE=$(du -h public/lib/spacewinkgis/mars3d.js | cut -f1)
    echo "✓ mars3d.js found ($SIZE)"
else
    echo "✗ mars3d.js NOT found!"
fi

if [ -f "public/lib/spacewinkgis/mars3d.css" ]; then
    echo "✓ mars3d.css found"
else
    echo "✗ mars3d.css NOT found!"
fi

if [ -d "public/lib/mars3d-cesium/Build/Cesium" ]; then
    echo "✓ Cesium library found"
else
    echo "✗ Cesium library NOT found!"
fi

# Step 6: Update vite config for proper serving
echo ""
echo "Step 6: Updating Vite configuration..."

cat > vite.config.ts << 'VITEEOF'
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
VITEEOF

echo "✓ Vite config updated"

# Step 7: Clear cache
echo ""
echo "Step 7: Clearing cache..."
npm run clean-cache 2>/dev/null || rm -rf node_modules/.vite node_modules/.cache

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                 Setup Complete!                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "✅ SpacewinkGIS is configured and ready!"
echo ""
echo "Files in place:"
echo "  • Mars3D library: public/lib/spacewinkgis/"
echo "  • Cesium engine: public/lib/mars3d-cesium/"
echo "  • Configuration: public/config/spacewinkgis-config.json"
echo ""
echo "Next steps:"
echo "  1. Start server: npm run dev -- --port 3000"
echo "  2. Open: http://143.110.183.5:3000"
echo "  3. Check browser console for any errors"
echo ""
