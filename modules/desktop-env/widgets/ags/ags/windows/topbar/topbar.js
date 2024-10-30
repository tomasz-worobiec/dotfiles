import { ClockModule } from "./modules/clock.js"
import { WorkspacesModule } from "./modules/workspaces.js"
import { MediaModule } from "./modules/media.js"
import { SysTrayModule } from "./modules/systray.js"
import { VolumeModule } from "./modules/audio.js"
import { BatteryModule } from "./modules/battery.js"
import { SysButtonModule } from "./modules/sysbutton.js"

function Topbar(monitor = 0) {
    return Widget.Window({
        name: `topbar-${monitor}`,
        class_name: "topbar",
        monitor,
        anchor: ["top", "left", "right"],
        exclusivity: "exclusive",
        child: Widget.CenterBox({
			class_name: "container",
            start_widget: Left(),
            center_widget: Center(),
            end_widget: Right(),
        }),
    })
}

function Left() {
    return Widget.Box({
        spacing: 8,
        children: [
            ClockModule(),
            WorkspacesModule(),
        ],
    })
}

function Center() {
	return MediaModule()
}

function Right() {
    return Widget.Box({
        hpack: "end",
        spacing: 8,
        children: [
            SysTrayModule(),
            VolumeModule(),
            BatteryModule(),
			SysButtonModule()
        ],
    })
}

/* === COMMON === */


export { Topbar }
