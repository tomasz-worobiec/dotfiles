import { Topbar } from "./windows/topbar/topbar.js"
import { Media } from "./windows/media/media.js"
import { SystemMenu } from "./windows/system_menu/system_menu.js"

App.config({
    style: "./style.scss",
    windows: [
        Topbar(0),
		Media(0),
		SystemMenu(0)
    ],
})

export { }
