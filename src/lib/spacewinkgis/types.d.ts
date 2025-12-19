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
