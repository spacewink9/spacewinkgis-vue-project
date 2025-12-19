/**
 * 底图控制
 * @copyright Spacewink Technologies spacewinkgis.cn
 * @author 火星渣渣灰 2022-01-10
 */
import * as mars3d from "mars3d"

const Cesium = spacewinkgis.Cesium
let map: spacewinkgis.Map // Map related

// Initialize
export function onMounted(mapInstance: spacewinkgis.Map): void {
  map = mapInstance // 记录map
}

// 释放当前业务
export function onUnmounted(): void {
  map = null
}

export function changeBaseMaps(id: string) {
  map.basemap = id
}

export function changeTerrain(value: boolean) {
  map.hasTerrain = value
}

export function getLayers() {
  return {
    baseMaps: map.getBasemaps(true),
    hasTerrain: map.hasTerrain
  }
}
