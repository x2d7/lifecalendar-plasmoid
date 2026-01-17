function getFilledColor(theme, customColor, useCustom) {
    if (useCustom && customColor) {
        return customColor;
    }
    return (theme && theme.highlightColor) ? theme.highlightColor : "#3daee9";
}

function getEmptyColor(theme, customColor, useCustom) {
    if (useCustom && customColor) {
        return customColor;
    }
    return (theme && theme.midColor) ? theme.midColor : "#bfbfbf";
}

function getTodayBorder(theme, customColor, useCustom) {
    if (useCustom && customColor) {
        return customColor;
    }
    return (theme && theme.highlightColor) ? theme.highlightColor : "#3daee9";
}

function getBackground(theme, customColor, useCustom) {
    if (useCustom && customColor) {
        return customColor;
    }
    return (theme && theme.backgroundColor) ? theme.backgroundColor : "transparent";
}

function getTextColor(theme) {
    return (theme && theme.textColor) ? theme.textColor : "#ffffff";
}
