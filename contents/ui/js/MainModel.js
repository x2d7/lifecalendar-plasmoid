.pragma library

var Utils = Qt.include("utils.js");

function daysInYear() {
    return Utils.daysInYear();
}

function dayOfYear() {
    return Utils.dayOfYear();
}

function dayOfWeek(dayNumber) {
    return Utils.dayOfWeek(dayNumber);
}

function weekOfYear(dayNumber) {
    return Utils.weekOfYear(dayNumber);
}

function getDateFromDayOfYear(dayOfYear) {
    return Utils.getDateFromDayOfYear(dayOfYear);
}
