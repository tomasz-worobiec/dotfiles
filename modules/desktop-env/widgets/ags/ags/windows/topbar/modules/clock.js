const date = Variable("", {
    poll: [1000, 'date "+%H:%M"'],
})

function ClockModule() {
    return Widget.Label({
        class_name: "clock",
        label: date.bind(),
    })
}

export { ClockModule }
