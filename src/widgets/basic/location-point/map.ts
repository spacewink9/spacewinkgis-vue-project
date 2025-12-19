/**
 * 图上选点
 * @copyright Spacewink Technologies spacewinkgis.cn
 * @author 火星胡椒 2022-01-10
 */
import * as mars3d from "mars3d"
let map: spacewinkgis.Map // Map related

// 事件对象，用于抛出事件给vue
export const eventTarget = new spacewinkgis.BaseClass()

// Initialize
export function onMounted(mapInstance: spacewinkgis.Map): void {
  map = mapInstance // 记录map
}

// 释放当前业务
export function onUnmounted(): void {
  if (pointEntity) {
    pointEntity.remove()
    pointEntity = null
  }
  eventTarget.off()
  map = null
}

// 获取默认point点
export function defultPoint() {
  const point: spacewinkgis.LngLatPoint = map.getCenter()
  point.format()
  return {
    lng: point.lng,
    lat: point.lat,
    alt: point.alt
  }
}

// 坐标转化的三种方法
export function marsUtilFormtNum(item: number, num: number) {
  return spacewinkgis.Util.formatNum(item, num)
}

export function marsPointTrans(item: number) {
  return spacewinkgis.PointTrans.degree2dms(item)
}

export function marsProj4Trans(JD: number, WD: number, radio: string) {
  if (radio === "2") {
    return spacewinkgis.PointTrans.proj4Trans([JD, WD], spacewinkgis.CRS.EPSG4326, spacewinkgis.CRS.CGCS2000_GK_Zone_6)
  } else {
    return spacewinkgis.PointTrans.proj4Trans([JD, WD], spacewinkgis.CRS.EPSG4326, spacewinkgis.CRS.CGCS2000_GK_Zone_3)
  }
}

// 转换成十进制的方法
export function marsDms2degree(du: number, fen: number, miao: number) {
  return spacewinkgis.PointTrans.dms2degree(du, fen, miao)
}
export function marsZONEtoCRS(jd: number, wd: number, radio: string) {
  if (radio === "2") {
    return spacewinkgis.PointTrans.proj4Trans([jd, wd], spacewinkgis.CRS.CGCS2000_GK_Zone_6, spacewinkgis.CRS.EPSG4326)
  } else {
    return spacewinkgis.PointTrans.proj4Trans([jd, wd], spacewinkgis.CRS.CGCS2000_GK_Zone_3, spacewinkgis.CRS.EPSG4326)
  }
}

// Map related
export function bindMourseClick() {
  map.setCursor("crosshair")
  map.once(spacewinkgis.EventType.click, function (event: any) {
    map.setCursor("")
    const cartesian = event.cartesian
    const point = spacewinkgis.LngLatPoint.fromCartesian(cartesian)
    point.format() // 经度、纬度、高度
    eventTarget.fire("clickMap", { point })
    updateMarker(false, point.lng, point.lat, point.alt)
  })
}

let pointEntity: any
export function updateMarker(hasCenter: boolean, jd: number, wd: number, alt: number) {
  const position = [jd, wd, alt]

  if (pointEntity == null) {
    pointEntity = new spacewinkgis.graphic.PointEntity({
      position,
      style: {
        color: "#3388ff",
        pixelSize: 10,
        outlineColor: "#ffffff",
        outlineWidth: 2
      }
    })
    map.graphicLayer.addGraphic(pointEntity)
  } else {
    pointEntity.position = position
  }

  if (hasCenter) {
    pointEntity.flyTo({ radius: 1000 })
  }
}
