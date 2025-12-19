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
