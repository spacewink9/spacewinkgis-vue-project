<template>
  <main-view @mapLoaded="mapLoaded" :url="sceneUrl" />
</template>

<script setup lang="ts">
import { computed } from "vue"
import MainView from "@/components/spacewink-work/main-view.vue"
import { getQueryString } from "@/utils/mars-util"

const sceneUrl = computed(() => getQueryString("url"))
function mapLoaded(map: any) {
  // Map construction completed
}
</script>

<style></style>
