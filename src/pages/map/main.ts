import "font-awesome/css/font-awesome.css"

// SpacewinkGIS library - SpacewinkGIS is loaded via script tag in index.html
import "@/components/spacewink-work/expand/index"

import { createApp } from "vue"
import Application from "./App.vue"
import { injectState, key } from "@/common/store/widget"
import store from "./widget-store"
import SpacewinkUIInstall from "@/components/spacewink-ui"
import "@/components/spacewink-ui/common"

const app = createApp(Application)

SpacewinkUIInstall(app)

app.use(injectState(store), key)

app.mount("#app")

// Hide loading screen after mount
setTimeout(() => {
  const loadingScreen = document.getElementById('loading-screen')
  if (loadingScreen) {
    loadingScreen.classList.add('fade-out')
    setTimeout(() => {
      loadingScreen.style.display = 'none'
    }, 500)
  }
}, 1500)
