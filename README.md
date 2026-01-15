# Life Calendar Plasmoid

A simple year-progress visual calendar for KDE Plasma. Shows passed days of the year as squares in a grid.

---

## Disclaimer

Note that the plasmoid may experience significant lag when dragging (It's my first plasmoid SORRY! Contribute if you can!)

---

## Features / Modes

- **Horizontal / Vertical** layouts  
- **Vertical-heatmap** layout (week columns, 7 days per column)

<div style="display: flex; flex-wrap: wrap; gap: 0; overflow-x: auto;">
  <img src="./screenshots/3.png" width="400" style="display: block; flex: 0 0 auto;">
  <img src="./screenshots/1.png" width="400" style="display: block; flex: 0 0 auto;">
  <img src="./screenshots/2.png" width="800" style="display: block; flex: 0 0 auto; margin-top: 0;">
</div>







---

## Installation

1. Clone the repository:  
   ```bash
   git clone https://github.com/x2d7/lifecalendar-plasmoid.git
   ```
2. Copy to Plasma widgets folder:  
   ```bash
   cp -r lifecalendar-plasmoid ~/.local/share/plasma/plasmoids/
   ```
3. Add the plasmoid to your desktop from the **Add Widgets** menu.  

---

## Configuration

- Adjust `orientation` (horizontal, vertical, vertical-heatmap)  
- Adjust `maxSquare` for cell size  
- Colors follow your Plasma theme  

---
