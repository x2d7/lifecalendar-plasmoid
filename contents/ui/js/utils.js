function dayOfYear(date) {
    if (!date) date = new Date();
    const start = new Date(date.getFullYear(), 0, 1);
    return Math.floor((date - start) / (1000 * 60 * 60 * 24)) + 1;
}

function daysInYear(year) {
    if (!year) year = new Date().getFullYear();
    return ((year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0)) ? 366 : 365;
}

function dayOfWeek(dayNumber, year) {
    if (!year) year = new Date().getFullYear();
    const date = new Date(year, 0, dayNumber);
    return (date.getDay() + 6) % 7;
}

function weekOfYear(dayNumber, year) {
    if (!year) year = new Date().getFullYear();
    const date = new Date(year, 0, dayNumber);
    const jan1 = new Date(year, 0, 1);
    const jan1DayOfWeek = (jan1.getDay() + 6) % 7; // Monday = 0
    const daysSinceJan1 = Math.floor((date - jan1) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor((daysSinceJan1 + jan1DayOfWeek) / 7) + 1;
    return weekNumber;
}

function getDateFromDayOfYear(dayOfYear) {
    var date = new Date();
    date.setMonth(0);
    date.setDate(dayOfYear);
    
    return {
        day: date.getDate(),
        month: date.getMonth() + 1,
        year: date.getFullYear()
    };
}