import { FormatPercents } from "../../../utils/formatting.js"

const audio = await Service.import("audio")

function VolumeModule() {
    const icon = audio.speaker.bind("is-muted")
		.as(isMuted => isMuted ? "󰝟" : "󰕾")
    const content = audio.speaker.bind("volume")
		.as(value => FormatPercents(value * 100))

    return Widget.Box({
        class_name: "module module-volume",
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

export { VolumeModule }
