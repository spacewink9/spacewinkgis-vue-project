/**
 * SpacewinkGIS - Custom GIS Library Wrapper
 * Built on top of SpacewinkGIS (which uses Cesium)
 * Copyright (c) 2024 Spacewink Technologies
 * Licensed under MIT License
 */

// Load SpacewinkGIS library from local files
import '/lib/spacewinkgis/spacewinkgis.css'

// This wrapper makes mars3d available as a local module
// SpacewinkGIS is loaded as a UMD bundle, so we need to access it from window
const mars3d = (window as any).mars3d

if (!mars3d) {
  console.error('SpacewinkGIS library not loaded! Make sure mars3d.js is included before this module.')
}

// Re-export everything from mars3d
export default mars3d
export const {
  Map,
  Layer,
  Graphic,
  Util,
  EventType,
  control,
  layer,
  graphic,
  thing
} = mars3d || {}
