<template>
  <div class="spacewinkgis-popup-content-wrapper spacewinkgis-query-pupup">
    <span class="spacewinkgis-popup-close-button spacewinkgis-popup-color closeButton" @click="closePopup"> × </span>

    <div class="spacewinkgis-popup-content spacewinkgis-popup-background">
      <div class="spacewinkgis-template-title">
        <!-- <a :href="'https://www.amap.com/detail/' + props.id" target="_black">{{ props.name }}</a> -->
        {{ props.name }}
      </div>
      <div class="spacewinkgis-template-content">
        <div v-if="props.tel"><label>电话:</label> {{ props.tel }}</div>
        <div v-if="props.address"><label>地址:</label> {{ props.address }}</div>
        <div v-if="props.type"><label>类别:</label> {{ props.type }}</div>
      </div>
    </div>
    <div class="spacewinkgis-template-tri"></div>
  </div>
</template>

<script lang="ts" setup>
import * as mapWork from "./map"
const props = defineProps<{
  id: string
  name: string
  tel?: string
  address?: string
  type?: string
}>()

const closePopup = () => {
  mapWork.graphicLayer.closePopup()
}
</script>

<style lang="less">
.spacewinkgis-query-pupup {
  box-shadow: none;
  padding: 1px;
  background: var(--mars-base-border);
  border-radius: 4px;

  .spacewinkgis-popup-close-button {
    position: absolute;
    top: 10px;
    right: 10px;
  }

  .spacewinkgis-template-title {
    background-color: #464c5a;
    border-bottom: 1px solid #464c5a;
  }

  .spacewinkgis-popup-content {
    margin: 0px;
    border-radius: 4px;
  }

  .spacewinkgis-template-content {
    background-color: rgba(35, 39, 47, 0.7);
  }

  .spacewinkgis-template-tri {
    margin: auto;
    width: 0px;
    height: 0px;
    border: 10px solid rgba(39, 44, 54, 0.8);
    border-bottom: none;
    border-left-color: transparent;
    border-right-color: transparent;
  }
}
</style>
