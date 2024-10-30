const mpris = await Service.import("mpris")

function MediaModule() {
	return Widget.Box({
		children: mpris.bind("players").as(CreateMediaWidget)
	})
}

function CreateMediaWidget(players) {
	console.log(players)
	players = FilterPlayers(players)
	if (players.length == 0) {
		return null
	}

	const player = players[0]
    const artists = player.bind("track-artists")
    const title = player.bind("track-title")
	const content = Utils.merge([artists, title], GetMediaContent)

	const widget = Widget.Revealer({
		reveal_child: player.bind("can-play"),
		transition_duration: 0,
		child: Widget.Button({
			class_name: "module media-module",
			on_primary_click: () => {App.toggleWindow("media-0")},
			child: Widget.Label({
				maxWidthChars: 30,
				truncate: "end",
				class_name: "media-module-label",
				label: content
			})
		})
	})

	return [ widget ]
}

function GetMediaContent(artists, title) {
	return `${artists.join(', ')} - ${title}`
}

function FilterPlayers(players) {
	return players.filter(IsPlayerActive)
}

function IsPlayerActive(player) {
	return player.can_play
}

export { MediaModule }
