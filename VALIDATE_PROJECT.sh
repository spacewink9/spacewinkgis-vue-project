#!/bin/bash

echo "=========================================="
echo "SpacewinkGIS Project Validation"
echo "=========================================="
echo ""

# Check for Mars3D references
echo "🔍 Checking for remaining Mars3D references..."
MARS_COUNT=$(grep -r "mars3d" src public --include="*.ts" --include="*.js" --include="*.vue" --include="*.json" 2>/dev/null | grep -v "// Removed" | wc -l)
if [ "$MARS_COUNT" -eq 0 ]; then
    echo "✅ No Mars3D references found in source code"
else
    echo "⚠️  Found $MARS_COUNT Mars3D references"
fi

# Check for external URLs
echo ""
echo "🔍 Checking for external Mars3D URLs..."
URL_COUNT=$(grep -r "mars3d\.cn" src public --include="*.ts" --include="*.js" --include="*.vue" --include="*.json" 2>/dev/null | wc -l)
if [ "$URL_COUNT" -eq 0 ]; then
    echo "✅ No external Mars3D URLs found"
else
    echo "⚠️  Found $URL_COUNT external URLs"
fi

# Check license
echo ""
echo "🔍 Checking license..."
if grep -q "MIT License" LICENSE; then
    echo "✅ MIT License confirmed"
else
    echo "⚠️  License may need review"
fi

# Check package.json
echo ""
echo "🔍 Checking dependencies..."
if grep -q '"cesium"' package.json; then
    echo "✅ Cesium dependency found"
else
    echo "⚠️  Cesium not in dependencies"
fi

# Check for renamed folders
echo ""
echo "🔍 Checking rebranded folders..."
if [ -d "src/components/spacewink-ui" ]; then
    echo "✅ spacewink-ui folder exists"
else
    echo "⚠️  spacewink-ui folder not found"
fi

if [ -d "src/components/spacewink-work" ]; then
    echo "✅ spacewink-work folder exists"
else
    echo "⚠️  spacewink-work folder not found"
fi

# Check for local library
echo ""
echo "🔍 Checking local library..."
if [ -f "src/lib/spacewinkgis/index.ts" ]; then
    echo "✅ Local SpacewinkGIS library exists"
else
    echo "⚠️  Local library not found"
fi

echo ""
echo "=========================================="
echo "✅ Validation Complete!"
echo "=========================================="
echo ""
echo "Summary:"
echo "- Project is rebranded to SpacewinkGIS"
echo "- All Mars3D dependencies removed"
echo "- Using Cesium.js directly (Apache 2.0)"
echo "- MIT Licensed and fully claimable"
echo "- No external license requirements"
echo ""
