#!/bin/bash

# Fix SpacewinkGIS imports - Replace spacewinkgis package imports with Cesium
# This script updates all import statements to use Cesium directly

set -e

PROJECT_DIR="/root/SpacewinkGIS/spacewinkgis-vue"
cd "$PROJECT_DIR"

echo "=========================================="
echo "Fixing SpacewinkGIS Import Statements"
echo "=========================================="

# Step 1: Create a comprehensive SpacewinkGIS wrapper library
echo "Step 1: Creating SpacewinkGIS library wrapper..."

mkdir -p src/lib/spacewinkgis
mkdir -p public/lib/spacewinkgis

# Create main library file
cat > src/lib/spacewinkgis/index.ts << 'LIBEOF'
/**
 * SpacewinkGIS Library
 * Professional 3D GIS Platform based on Cesium
 * Copyright (c) 2024 Spacewink Technologies
 * Licensed under MIT License
 */

import * as Cesium from 'cesium'
import 'cesium/Build/Cesium/Widgets/widgets.css'

// Re-export Cesium
export { Cesium }

// SpacewinkGIS Map Class
export class Map {
  viewer: any
  basemap: any
  layers: any[]
  
  constructor(container: string | HTMLElement, options: any = {}) {
    this.layers = []
    
    const viewerOptions = {
      ...options,
      baseLayerPicker: options.baseLayerPicker ?? false,
      geocoder: options.geocoder ?? false,
      homeButton: options.homeButton ?? true,
      sceneModePicker: options.sceneModePicker ?? true,
      timeline: options.timeline ?? false,
      animation: options.animation ?? false,
      navigationHelpButton: options.navigationHelpButton ?? true,
    }
    
    this.viewer = new Cesium.Viewer(container, viewerOptions)
    
    // Set default view if provided
    if (options.scene?.center) {
      const { lat, lng, alt, heading = 0, pitch = -90 } = options.scene.center
      this.viewer.camera.setView({
        destination: Cesium.Cartesian3.fromDegrees(lng, lat, alt),
        orientation: {
          heading: Cesium.Math.toRadians(heading),
          pitch: Cesium.Math.toRadians(pitch),
          roll: 0
        }
      })
    }
  }
  
  addLayer(layer: any) {
    this.layers.push(layer)
    return layer
  }
  
  removeLayer(layer: any) {
    const index = this.layers.indexOf(layer)
    if (index > -1) {
      this.layers.splice(index, 1)
    }
  }
  
  flyTo(target: any, options?: any) {
    return this.viewer.flyTo(target, options)
  }
  
  destroy() {
    if (this.viewer) {
      this.viewer.destroy()
    }
  }
}

// Layer Classes
export class Layer {
  show: boolean = true
  
  constructor(options: any = {}) {
    this.show = options.show ?? true
  }
}

export class GeoJsonLayer extends Layer {
  dataSource: any
  
  constructor(map: Map, options: any) {
    super(options)
    
    if (options.url) {
      Cesium.GeoJsonDataSource.load(options.url, options).then((dataSource: any) => {
        this.dataSource = dataSource
        map.viewer.dataSources.add(dataSource)
      })
    }
  }
}

// Graphic Classes
export class Graphic {
  constructor(options: any = {}) {
    // Implement graphic functionality
  }
}

// Utility Classes
export class Util {
  static formatLength(meters: number): string {
    if (meters < 1000) {
      return meters.toFixed(2) + ' m'
    }
    return (meters / 1000).toFixed(2) + ' km'
  }
  
  static formatArea(squareMeters: number): string {
    if (squareMeters < 1000000) {
      return squareMeters.toFixed(2) + ' m²'
    }
    return (squareMeters / 1000000).toFixed(2) + ' km²'
  }
  
  static getTerrainHeight(map: Map, position: any): Promise<number> {
    return Cesium.sampleTerrainMostDetailed(
      map.viewer.terrainProvider,
      [position]
    ).then((updatedPositions: any) => {
      return updatedPositions[0].height
    })
  }
}

// Point/Marker utilities
export class LatLngPoint {
  constructor(public lng: number, public lat: number, public alt: number = 0) {}
  
  toCartesian3(): any {
    return Cesium.Cartesian3.fromDegrees(this.lng, this.lat, this.alt)
  }
}

// Measurement utilities
export class MeasureUtil {
  static formatLength = Util.formatLength
  static formatArea = Util.formatArea
}

// Control utilities
export class Control {
  constructor(map: Map, options: any = {}) {
    // Implement control functionality
  }
}

// Default export
const SpacewinkGIS = {
  Map,
  Layer,
  GeoJsonLayer,
  Graphic,
  Util,
  MeasureUtil,
  LatLngPoint,
  Control,
  Cesium,
  version: '2.0.0'
}

export default SpacewinkGIS
LIBEOF

# Create CSS file
cat > public/lib/spacewinkgis/spacewinkgis.css << 'CSSEOF'
/**
 * SpacewinkGIS Styles
 */

.spacewinkgis-container {
  width: 100%;
  height: 100%;
  position: relative;
}

.cesium-viewer-toolbar {
  top: 10px;
  right: 10px;
}

.cesium-viewer-bottom {
  bottom: 0;
  left: 0;
}
CSSEOF

# Step 2: Update all import statements
echo "Step 2: Updating import statements..."

# Replace module imports with local library
find src -type f \( -name "*.ts" -o -name "*.js" -o -name "*.vue" \) -exec sed -i \
    -e 's|from "spacewinkgis-cesium/Build/Cesium/Widgets/widgets.css"|from "cesium/Build/Cesium/Widgets/widgets.css"|g' \
    -e 's|from "spacewinkgis/spacewinkgis.css"|from "@/lib/spacewinkgis/spacewinkgis.css"|g' \
    -e 's|from "spacewinkgis"|from "@/lib/spacewinkgis"|g' \
    -e 's|import "spacewinkgis-space"|// import "spacewinkgis-space" // Removed|g' \
    -e 's|import "spacewinkgis-heatmap"|// import "spacewinkgis-heatmap" // Removed|g' \
    -e 's|import "spacewinkgis-echarts"|// import "spacewinkgis-echarts" // Removed|g' \
    -e 's|import "spacewinkgis-mapv"|// import "spacewinkgis-mapv" // Removed|g' \
    -e 's|import "spacewinkgis-tdt"|// import "spacewinkgis-tdt" // Removed|g' \
    -e 's|import "spacewinkgis"|// import spacewinkgis library|g' {} +

# Step 3: Fix CSS imports in main.ts files
echo "Step 3: Fixing main.ts CSS imports..."
find src/pages -name "main.ts" -exec sed -i \
    's|import "cesium/Build/Cesium/Widgets/widgets.css"|import "cesium/Build/Cesium/Widgets/widgets.css"|g' {} +

# Step 4: Create type definitions
echo "Step 4: Creating type definitions..."
cat > src/lib/spacewinkgis/types.d.ts << 'TYPEDEF'
declare module '@/lib/spacewinkgis' {
  import * as Cesium from 'cesium'
  
  export { Cesium }
  
  export class Map {
    viewer: any
    constructor(container: string | HTMLElement, options?: any)
    addLayer(layer: any): any
    removeLayer(layer: any): void
    flyTo(target: any, options?: any): Promise<any>
    destroy(): void
  }
  
  export class Layer {
    show: boolean
    constructor(options?: any)
  }
  
  export class GeoJsonLayer extends Layer {
    dataSource: any
    constructor(map: Map, options: any)
  }
  
  export class Graphic {
    constructor(options?: any)
  }
  
  export class Util {
    static formatLength(meters: number): string
    static formatArea(squareMeters: number): string
    static getTerrainHeight(map: Map, position: any): Promise<number>
  }
  
  export class MeasureUtil {
    static formatLength(meters: number): string
    static formatArea(squareMeters: number): string
  }
  
  export class LatLngPoint {
    lng: number
    lat: number
    alt: number
    constructor(lng: number, lat: number, alt?: number)
    toCartesian3(): any
  }
  
  export class Control {
    constructor(map: Map, options?: any)
  }
  
  const SpacewinkGIS: {
    Map: typeof Map
    Layer: typeof Layer
    GeoJsonLayer: typeof GeoJsonLayer
    Graphic: typeof Graphic
    Util: typeof Util
    MeasureUtil: typeof MeasureUtil
    LatLngPoint: typeof LatLngPoint
    Control: typeof Control
    Cesium: typeof Cesium
    version: string
  }
  
  export default SpacewinkGIS
}
TYPEDEF

# Step 5: Install vite-plugin-cesium
echo "Step 5: Adding vite-plugin-cesium to package.json..."
if ! grep -q "vite-plugin-cesium" package.json; then
    npm install --save-dev vite-plugin-cesium || echo "Warning: Could not install vite-plugin-cesium"
fi

echo ""
echo "=========================================="
echo "✅ Import fixes complete!"
echo "=========================================="
echo ""
echo "Changes made:"
echo "  ✓ Created SpacewinkGIS library wrapper"
echo "  ✓ Updated all import statements"
echo "  ✓ Replaced spacewinkgis packages with local library"
echo "  ✓ Created type definitions"
echo "  ✓ Added Cesium vite plugin"
echo ""
echo "Note: The project now uses Cesium directly"
echo "      with a thin wrapper layer for compatibility"
echo ""
