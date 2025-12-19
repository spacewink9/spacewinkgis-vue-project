#!/bin/bash
echo "🔧 Fixing all spacewinkgis references in src..."

# Fix in .ts files
find src -name "*.ts" -type f -exec sed -i "s/spacewinkgis/mars3d/g" {} +

# Fix in .vue files  
find src -name "*.vue" -type f -exec sed -i "s/spacewinkgis/mars3d/g" {} +

# Fix in .js files
find src -name "*.js" -type f -exec sed -i "s/spacewinkgis/mars3d/g" {} +

echo "✅ Fixed all imports!"
grep -r "spacewinkgis" src/ | wc -l && echo "remaining spacewinkgis occurrences"
