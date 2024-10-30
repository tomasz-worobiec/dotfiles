
function SystemMenu(monitor) {
    return Widget.Window({
        name: `system-menu-${monitor}`,
        monitor,
        anchor: [ "bottom", "top", "right" ],
		visible: false,
		class_name: "system-menu",
        child: Widget.Box({
			vertical: true,
			class_name: "system-menu-container",
			children: [
				PowerModule()
			]
		})
    })
}

function PowerModule() {
	return Widget.Box({
		class_name: "system-menu-power-module-container",
		spacing: 28,
		children: [
			LogoutButton(),
			LockScreenButton(),
			RebootButton(),
			ShutdownButton()
		]
	})
}

function LogoutButton() {
	return PowerModuleButton("system-log-out", null)
}

function LockScreenButton() {
	return PowerModuleButton("system-lock-screen", null)
}

function RebootButton() {
	return PowerModuleButton("system-reboot", null)
}

function ShutdownButton() {
	return PowerModuleButton("go-up", null)
}

function PowerModuleButton(icon, callback) {
	return Widget.Button({
		class_name: "system-menu-power-module-button",
		hpack: "center",
		on_primary_click: (_, __) => { callback() },
		child: Widget.Icon({
			class_name: "system-menu-power-module-button-icon",
			icon: icon
		})
	})
}

export { SystemMenu }
