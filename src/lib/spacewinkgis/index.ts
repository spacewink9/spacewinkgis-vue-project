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
