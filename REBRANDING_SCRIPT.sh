#!/bin/bash
echo "🌍 Starting SpacewinkGIS Rebranding..."

# Replace text in files
find . -type f \( -name "*.js" -o -name "*.vue" -o -name "*.ts" -o -name "*.html" -o -name "*.json" -o -name "*.md" \) \
  -not -path "*/node_modules/*" -not -path "*/.git/*" \
  -exec sed -i 's/Mars3D/SpacewinkGIS/g' {} + \
  -exec sed -i 's/mars3d/spacewinkgis/g' {} + \
  -exec sed -i 's/marsgis/spacewink/g' {} + \
  -exec sed -i 's/火星科技/Spacewink Technologies/g' {} + \
  -exec sed -i 's/http:\/\/mars3d\.cn/https:\/\/spacewink.dev/g' {} +

echo "✅ Rebranding complete!"
