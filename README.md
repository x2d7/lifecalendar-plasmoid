# Life Calendar Plasmoid

A year-progress calendar widget for KDE Plasma. Visualizes passed and remaining days of the year as a grid of squares.

| | |
|---|---|
| ![](screenshots/3.png) | ![](screenshots/1.png) |
| ![](screenshots/2.png) | ![](screenshots/4.png) |

## Installation
```sh
git clone https://github.com/x2d7/lifecalendar-plasmoid.git
mv lifecalendar-plasmoid ~/.local/share/plasma/plasmoids/
```

Then add the widget via **Right-click on Desktop → Add Widgets**.

## Layout Modes

- **Horizontal** — days flow left to right
- **Vertical** — days flow top to bottom  
- **Vertical Heatmap** — week columns, 7 days each (GitHub-style)

## Configuration

### Layout
| Option | Description |
|---|---|
| `orientation` | Layout mode: `horizontal`, `vertical`, `vertical-heatmap` |
| `maxSquare` | Maximum cell size in pixels |

### Appearance
| Option | Description |
|---|---|
| `gap` | Spacing between cells |
| `backgroundRadius` | Widget background corner radius |
| `cellRadiusFactor` | Cell corner radius factor |
| `cellBorderWidth` | Cell border width |

### Colors
| Option | Description |
|---|---|
| `useCustomColors` | Enable custom color scheme (off = follows Plasma theme) |
| `filledColor` | Color for passed days |
| `emptyColor` | Color for remaining days |
| `todayBorderColor` | Border color for today |
| `backgroundColor` | Widget background color |

### Updates
| Option | Description |
|---|---|
| `updateInterval` | Refresh rate: hourly, daily, weekly, monthly |
