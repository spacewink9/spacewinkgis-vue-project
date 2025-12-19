#!/bin/bash
# Fix SpacewinkGIS dependencies - revert to mars3d packages

echo "🔧 Fixing dependencies..."

# Replace spacewinkgis packages back to mars3d for installation
sed -i 's/"spacewinkgis"/"mars3d"/g' package.json
sed -i 's/"spacewinkgis-/"mars3d-/g' package.json

echo "✅ Dependencies fixed!"
cat package.json | grep -E "(mars3d|spacewink)" | head -20
