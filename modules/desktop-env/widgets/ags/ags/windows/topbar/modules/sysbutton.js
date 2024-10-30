function SysButtonModule() {
	return Widget.Button({
		class_name: "system-button",
        on_primary_click: () => { App.toggleWindow("system-menu-0") },
		child: Widget.Label("󱄅"),
	})
}

export { SysButtonModule }
