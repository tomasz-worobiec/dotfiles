import { FormatPercents } from "../../../utils/formatting.js"

const battery = await Service.import("battery")

function BatteryModule() {
    const icon = battery.bind("charging")
		.as(isCharging => isCharging ? "󰂄" : "󰁹")
    const content = battery.bind("percent")
		.as(FormatPercents)

    return Widget.Box({
        class_name: "module module-battery",
        visible: battery.bind("available"),
        children: [
			Widget.Label({
				class_name: "module-icon",
				label: icon
			}),
			Widget.Label({
				class_name: "module-content",
				label: content
			})
        ]
    })
}

export { BatteryModule }
