import * as mars3d from "mars3d"

let map: spacewinkgis.Map // Map related

/**
 * 构造bloom效果对象
 */
let bloomEffect: spacewinkgis.effect.Bloom

// 事件对象，用于抛出事件给vue
export const eventTarget = new spacewinkgis.BaseClass()

/**
 * 初始化地图业务，生命周期钩子函数（必须）
 * 框架在地图初始化完成后自动调用该函数
 * @param {spacewinkgis.Map} mapInstance 地图对象
 * @returns {void} 无
 */
export function onMounted(mapInstance: spacewinkgis.Map): void {
  map = mapInstance // 记录首次创建的map

  // Constructor
  bloomEffect = new spacewinkgis.effect.Bloom({})
  map.addEffect(bloomEffect)
}

/**
 * 释放当前地图业务的生命周期函数
 * @returns {void} 无
 */
export function onUnmounted() {
  map.graphicLayer.clear()
  map.removeEffect(bloomEffect, true)
  bloomEffect = null
  map = null
}

// 绘制矩形（演示map.js与index.vue的交互）
export function drawExtent(): void {
  map.graphicLayer.clear()
  // 绘制矩形
  map.graphicLayer.startDraw({
    type: "rectangle",
    style: {
      fill: true,
      color: "rgba(255,255,0,0.2)",
      outline: true,
      outlineWidth: 2,
      outlineColor: "rgba(255,255,0,1)"
    },
    success: function (graphic: any) {
      const rectangle = spacewinkgis.PolyUtil.formatRectangle(graphic._rectangle_draw)
      eventTarget.fire("drawExtent", { extent: JSON.stringify(rectangle) }) // 抛出事件，可以vue中去监听事件
    }
  })
}

// Map related
export function enableMapMouseController(value: boolean) {
  map.setSceneOptions({
    cameraController: {
      enableZoom: value,
      enableTranslate: value,
      enableRotate: value,
      enableTilt: value
    }
  })
}

// 调整亮度 （演示滑动条）
export function updateBrightness(val: number) {
  bloomEffect.brightness = val
}

// 调整对比度 （演示滑动条）
export function updateContrast(val: number) {
  bloomEffect.contrast = val
}

// 创建图层
export function createLayer(layer: any) {
  return spacewinkgis.LayerUtil.create(layer)
}

// 添加图层
export function addLayer(layer: spacewinkgis.layer.BaseLayer) {
  map.addLayer(layer)
}

// 移除图层
export function removeLayer(layer: any) {
  map.removeLayer(layer)
}
