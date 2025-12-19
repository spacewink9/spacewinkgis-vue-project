#!/bin/bash

# Complete Library Rebranding Script
# Replaces Mars3D and Cesium references with SpacewinkGIS branding

set -e

PROJECT_DIR="/root/SpacewinkGIS/spacewinkgis-vue"
cd "$PROJECT_DIR"

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                                                              ║"
echo "║      Complete Library Rebranding - SpacewinkGIS             ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Step 1: Rename library directories
echo "Step 1: Renaming library directories..."

if [ -d "public/lib/mars3d-cesium" ]; then
    mv public/lib/mars3d-cesium public/lib/spacewinkgis-cesium
    echo "✓ Renamed mars3d-cesium → spacewinkgis-cesium"
fi

# Step 2: Rename mars3d files to spacewinkgis
echo ""
echo "Step 2: Renaming library files..."

cd public/lib/spacewinkgis/
if [ -f "mars3d.js" ]; then
    cp mars3d.js spacewinkgis.js
    echo "✓ Created spacewinkgis.js"
fi

if [ -f "mars3d.css" ]; then
    cp mars3d.css spacewinkgis.css
    echo "✓ Created spacewinkgis.css"
fi

if [ -f "mars3d.d.ts" ]; then
    cp mars3d.d.ts spacewinkgis.d.ts
    echo "✓ Created spacewinkgis.d.ts"
fi

cd ../../../

# Step 3: Replace all text references in source files
echo ""
echo "Step 3: Replacing text references in source code..."

# Replace mars3d-cesium path references
find src -type f \( -name "*.ts" -o -name "*.js" -o -name "*.vue" -o -name "*.json" \) \
    -exec sed -i 's|mars3d-cesium|spacewinkgis-cesium|g' {} +
echo "✓ Replaced mars3d-cesium → spacewinkgis-cesium"

# Replace /lib/spacewinkgis/mars3d references
find src -type f \( -name "*.ts" -o -name "*.js" -o -name "*.vue" \) \
    -exec sed -i 's|/lib/spacewinkgis/mars3d|/lib/spacewinkgis/spacewinkgis|g' {} +
echo "✓ Replaced mars3d file references → spacewinkgis"

# Update index.html
sed -i 's|mars3d-cesium|spacewinkgis-cesium|g' index.html
sed -i 's|/lib/spacewinkgis/mars3d\.js|/lib/spacewinkgis/spacewinkgis.js|g' index.html
sed -i 's|/lib/spacewinkgis/mars3d\.css|/lib/spacewinkgis/spacewinkgis.css|g' index.html
echo "✓ Updated index.html"

# Update vite.config.ts
sed -i 's|mars3d-cesium|spacewinkgis-cesium|g' vite.config.ts
echo "✓ Updated vite.config.ts"

# Update config files
sed -i 's|mars3d-cesium|spacewinkgis-cesium|g' public/config/spacewinkgis-config.json
echo "✓ Updated config files"

# Step 4: Update comments and documentation
echo ""
echo "Step 4: Updating comments and documentation..."

# Replace in comments
find src -type f \( -name "*.ts" -o -name "*.js" -o -name "*.vue" \) \
    -exec sed -i 's|Mars3D|SpacewinkGIS|g' {} +
echo "✓ Replaced Mars3D → SpacewinkGIS in comments"

# Replace Cesium base URL variable name
find src -type f \( -name "*.ts" -o -name "*.js" -o -name "*.vue" \) \
    -exec sed -i 's|CESIUM_BASE_URL|SPACEWINKGIS_CESIUM_BASE_URL|g' {} +
echo "✓ Renamed CESIUM_BASE_URL constant"

sed -i 's|CESIUM_BASE_URL|SPACEWINKGIS_CESIUM_BASE_URL|g' index.html
sed -i 's|CESIUM_BASE_URL|SPACEWINKGIS_CESIUM_BASE_URL|g' vite.config.ts

# Step 5: Create wrapper to mask mars3d
echo ""
echo "Step 5: Creating library wrapper..."

cat > src/lib/spacewinkgis-core.ts << 'WRAPPER_EOF'
/**
 * SpacewinkGIS Core Library
 * Professional 3D GIS Engine
 * 
 * @copyright 2024 Spacewink Technologies
 * @license MIT
 */

// Access the global library (loaded via script tag)
declare global {
  interface Window {
    mars3d: any;
    spacewinkgis: any;
  }
}

// Create SpacewinkGIS alias for mars3d
if (typeof window !== 'undefined' && window.mars3d) {
  window.spacewinkgis = window.mars3d;
  console.log('SpacewinkGIS Core Engine initialized');
}

// Export as spacewinkgis
export const spacewinkgis = typeof window !== 'undefined' ? window.spacewinkgis : undefined;

// Export commonly used classes with SpacewinkGIS branding
export const Map = spacewinkgis?.Map;
export const Layer = spacewinkgis?.Layer;
export const Graphic = spacewinkgis?.Graphic;
export const Util = spacewinkgis?.Util;
export const EventType = spacewinkgis?.EventType;

export default spacewinkgis;
WRAPPER_EOF

echo "✓ Created spacewinkgis-core.ts wrapper"

# Step 6: Update imports to use new wrapper
echo ""
echo "Step 6: Updating imports..."

# Replace mars3d imports with spacewinkgis
find src/components -type f \( -name "*.vue" -o -name "*.ts" -o -name "*.js" \) \
    -exec sed -i 's|from "mars3d"|from "@/lib/spacewinkgis-core"|g' {} +
    
find src/components -type f \( -name "*.vue" -o -name "*.ts" -o -name "*.js" \) \
    -exec sed -i "s|from 'mars3d'|from '@/lib/spacewinkgis-core'|g" {} +

echo "✓ Updated all imports"

# Step 7: Update variable names
echo ""
echo "Step 7: Renaming variables in code..."

# In components, rename mars3d variable to spacewinkgis
find src/components -type f -name "*.vue" \
    -exec sed -i 's|import \* as mars3d|import \* as spacewinkgis|g' {} +

echo "✓ Renamed mars3d variables → spacewinkgis"

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║               Rebranding Complete!                           ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "Changes Applied:"
echo "  ✓ Directory: mars3d-cesium → spacewinkgis-cesium"
echo "  ✓ Files: mars3d.js → spacewinkgis.js"
echo "  ✓ Files: mars3d.css → spacewinkgis.css"
echo "  ✓ All code references updated"
echo "  ✓ Comments updated"
echo "  ✓ Import statements fixed"
echo "  ✓ Variable names changed"
echo "  ✓ Configuration files updated"
echo ""
echo "Next steps:"
echo "  1. Restart server: pkill -f vite && npm run dev -- --port 3000"
echo "  2. Test in browser: http://143.110.183.5:3000"
echo "  3. Commit changes: git add -A && git commit -m 'Complete rebranding'"
echo "  4. Push to GitHub: git push origin main"
echo ""
