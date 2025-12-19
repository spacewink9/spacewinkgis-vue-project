/**
 * SpacewinkGIS - Professional 3D GIS Library
 * Built on Cesium.js
 * Copyright (c) 2024 Spacewink Technologies
 * Licensed under MIT License
 */

import * as Cesium from 'cesium'

export { Cesium }

// Export main GIS functionality
export const SpacewinkGIS = {
  version: '2.0.0',
  Cesium,
  
  // Add custom GIS utilities here
  Map: null as any,
  Layer: null as any,
  Graphic: null as any,
  
  init(options: any) {
    console.log('SpacewinkGIS initialized', options)
  }
}

export default SpacewinkGIS
