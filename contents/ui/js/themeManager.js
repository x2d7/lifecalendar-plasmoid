function getFilledColor(theme) {
    return (theme && theme.highlightColor) ? theme.highlightColor : "#3daee9";
}

function getEmptyColor(theme) {
    return (theme && theme.midColor) ? theme.midColor : "#bfbfbf";
}

function getTodayBorder(theme) {
    return (theme && theme.highlightColor) ? theme.highlightColor : "#3daee9";
}

function getBackground(theme) {
    return (theme && theme.backgroundColor) ? theme.backgroundColor : "transparent";
}

function getTextColor(theme) {
    return (theme && theme.textColor) ? theme.textColor : "#ffffff";
}
