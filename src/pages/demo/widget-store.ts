import { defineAsyncComponent, markRaw } from "vue"
import { WidgetState } from "@/common/store/widget"
import { StoreOptions } from "vuex"

const store: StoreOptions<WidgetState> = {
  state: {
    widgets: [
      {
        component: markRaw(defineAsyncComponent(() => import("@/widgets/demo/menu/index.vue"))),
        name: "menu",
        autoDisable: false,
        disableOther: false
      },
      {
        component: markRaw(defineAsyncComponent(() => import("@/widgets/demo/sample-pannel/index.vue"))),
        name: "sample-pannel"
      },
      {
        component: markRaw(defineAsyncComponent(() => import("@/widgets/demo/sample-dialog/index.vue"))),
        name: "sample-dialog"
      },
      {
        component: markRaw(defineAsyncComponent(() => import("@/widgets/demo/ui/index.vue"))),
        name: "ui"
      },
      {
        name: "my-widget",
        component: markRaw(defineAsyncComponent(() => import("@/widgets/demo/my-dialog/index.vue")))
      },
      {
        component: markRaw(defineAsyncComponent(() => import("@/widgets/demo/test/index.vue"))),
        name: "test"
      },
      {
        component: markRaw(defineAsyncComponent(() => import("@/widgets/demo/power-pannel/index.vue"))),
        name: "power-pannel"
      },
      {
        component: markRaw(defineAsyncComponent(() => import("@/widgets/demo/my-dialog/index.vue"))),
        name: "my-dialog"
      }
    ],
    openAtStart: ["menu"]
  }
}

export default store
