import "cesium/Build/Cesium/Widgets/widgets.css"
import "font-awesome/css/font-awesome.css"

// SpacewinkGIS library
import "@/components/spacewink-work/expand/index"

import { createApp } from "vue"
import Application from "./App.vue"
import { injectState, key } from "@/common/store/widget"
import { store as testStore, key as testKey } from "@/common/store/test"
import store from "./widget-store"
import SpacewinkUI from "@/components/spacewink-ui"
import { router } from "./routes"
import "@/components/spacewink-ui/common"

const app = createApp(Application)

app.use(SpacewinkUI)

app.use(router)

app.use(injectState(store), key)
app.use(testStore, testKey)

app.mount("#app")


