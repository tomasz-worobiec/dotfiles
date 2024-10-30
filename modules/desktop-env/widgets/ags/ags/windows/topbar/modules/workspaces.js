const hyprland = await Service.import("hyprland")

function WorkspacesModule() {
    const activeWorkspaceId = hyprland.active.workspace.bind("id")
    const workspaces = hyprland
		.bind("workspaces")
		.as(workspaces => TransformWorkspacesToWidgets(workspaces, activeWorkspaceId))

    return Widget.Box({
        class_name: "workspaces",
		spacing: 2,
        children: workspaces,
    })
}

function TransformWorkspacesToWidgets(workspaces, activeWorkspaceId) {
	return workspaces.map(({id}) =>
		CreateWorkspaceButton(id, activeWorkspaceId))
}

function CreateWorkspaceButton(workspaceId, activeWorkspaceId) {
	const workspace_class = activeWorkspaceId
		.as(activeId => (workspaceId == activeId) ? "active" : "inactive")
	return Widget.Button({
		on_clicked: 
			() => hyprland.messageAsync(`dispatch workspace ${workspaceId}`),
		child: 
			Widget.Label(`${workspaceId}`),
		class_name:
			workspace_class,
	})
}

export { WorkspacesModule }
