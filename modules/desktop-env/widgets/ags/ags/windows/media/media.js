const mpris = await Service.import("mpris")

function Media(monitor = 0) {
    return Widget.Window({
        name: `media-${monitor}`,
        monitor,
        anchor: [ "bottom" ],
		visible: false,
        child: Widget.Box({
			vexpand: false,
			vertical: true,
			class_name: "media-player-container",
			children: mpris.bind("players").as(MediaPlayerWidget)
		})
    })
}

function MediaPlayerWidget(players) {
	if (players.length == 0) {
		return []
	}
	const player = players[0]
	return [ 
		Thumbnail(player),
		Title(player),
		Author(player),
		Control(player)
	]
}

function Thumbnail(player) {
	 return Widget.Icon({
		class_name: "media-player-thumbnail-image",
		icon: player.bind("track-cover-url")
			.as(path => path.replace('file:\/\/', ''))
	})
}

function Title(player) {
	return Widget.Label({
		class_name: "media-player-title",
		maxWidthChars: 30,
		truncate: "end",
		label: player.bind("track-title")
	})
}

function Author(player) {
	return Widget.Label({
		class_name: "media-player-author",
		label: player.bind("track-artists")
			.as(artists => artists.join(", ")) })
}

function Control(player) {
	return Widget.CenterBox({
		class_name: "media-player-control-container",
		start_widget: null,
		center_widget: Widget.Box({
			children: [
				Widget.Button({
					vpack: "center",
					class_name: "media-player-control-navigation",
					on_primary_click: (_, event) => { player.previous() },
					child: Widget.Icon("media-skip-backward")
				}),
				Widget.Button({
					vpack: "center",
					class_name: "media-player-control-play-pause",
					on_primary_click: (_, event) => { player.playPause() },
					child: Widget.Icon({
						icon: player.bind("play-back-status").as(PlayPauseIcon)
					})
				}),
				Widget.Button({
					vpack: "center",
					class_name: "media-player-control-navigation",
					on_primary_click: (_, event) => { player.next() },
					child: Widget.Icon("media-skip-forward")
				})
			]
		}),
		end_widget: null 
	})
}

function PlayPauseIcon(status) {
	switch(status) {
		case "Playing":
			return "media-playback-pause"
			break;
		case "Paused":
			return "media-playback-start"
			break;
		case "Stopped":
			return "media-playback-start"
			break;
	}
}

export { Media }
