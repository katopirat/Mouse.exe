# MOUSE OS — grafika OS pro Godot 4

Otestováno v **Godot 4.4.1**: theme, font a demo scéna se načtou bez chyb. Kliky virtuálního kurzoru
do OS fungují na skutečná tlačítka, checkboxy i křížek okna.

## Rychlý start
1. Zkopíruj složku `mouse_os/` do kořene projektu, tedy na **`res://mouse_os/`**. Theme odkazuje na tuhle cestu.
2. Project Settings:
   - `Rendering > Textures > Canvas Textures > Default Texture Filter = Nearest`
   - `Rendering > 2D > Snap 2D Transforms to Pixel = On`
3. Na kořenový Control OS nastav `theme = mouse_os_theme.tres`. Pak se Buttony, CheckBoxy, okna,
   menu, LineEdit, ProgressBar a posuvníky obarví samy.
4. Hotový příklad je v `demo/mouse_os_demo.tscn`. Nebo otevři celý přiložený projekt v Godotu, demo se spustí po F5.

## Obrazovka a virtuální kurzor
OS je navržený pro obrazovku **208×128** (horní 118 px je plocha, dole 10 px hlavní panel).
- OS dej do `SubViewport` o velikosti 208×128 a jeho `ViewportTexture` zobraz v díře monitoru.
- Virtuální kurzor posílej do SubViewportu přes `scripts/os_input.gd`:
```gdscript
OSInput.move(os_viewport, cursor_pos)                              # hover
OSInput.button(os_viewport, cursor_pos, true)                      # levé tlačítko dolů
OSInput.button(os_viewport, cursor_pos, false)                     # a nahoru = klik
OSInput.button(os_viewport, cursor_pos, true, MOUSE_BUTTON_RIGHT)  # pravý klik
```
Normální signály `pressed`, `toggled`, hover i drag pak fungují jako se skutečnou myší.

## Theme: varianty (`theme_type_variation`)
| typ uzlu | varianty |
|---|---|
| Button | *(výchozí béžové)*, `ButtonPrimary` (oranžové), `ButtonGreen`, `ButtonRed` |
| PanelContainer | `WindowBlue`, `WindowRed` (reklamy), `WindowGreen` (burza), `WindowOrange`, `WindowGray` (neaktivní) |
| PanelContainer | `PanelSunken`, `PanelSunkenWhite`, `PanelSunkenDark` (graf), `PanelDashed` (captcha), `Taskbar`, `Toast` |
| Label | *(výchozí tmavý)*, `LabelTitle` a `LabelWhite` (bílé), `LabelDesktop` (bílé se stínem), `LabelMuted`, `LabelError` |
| ProgressBar | *(zelený)*, `ProgressBarOrange` |

Bez variant je nastylované: `Panel`, `PopupMenu` (kontextové menu), `CheckBox` (i radio), `LineEdit`,
`VScrollBar`, `HScrollBar` a tooltip.

## Stavba okna
Okno má v textuře lištu i stín, takže stačí tahle struktura:
```
PanelContainer  (theme_type_variation = WindowBlue)
└ VBoxContainer  (separation 2)
  ├ MarginContainer  (margin left 2, top 1, right 1)
  │ └ HBoxContainer
  │   ├ Label "TITLE.EXE"  (LabelTitle, size_flags_horizontal = Expand)
  │   ├ TextureButton  (ui/win_min_*)
  │   └ TextureButton  (ui/win_close_*)
  └ MarginContainer  (margin left/right 3, bottom 2)
	└ …obsah okna…
```

## 9-slice okraje (pro NinePatchRect nebo vlastní StyleBoxTexture)
| textura | L | T | R | B | poznámka |
|---|---|---|---|---|---|
| `ui/window_*.png` | 2 | 11 | 4 | 4 | obsahuje lištu a 2px stín vpravo dole |
| `ui/button_*_*.png` | 2 | 2 | 2 | 2 | stavy normal / hover / pressed / disabled |
| `ui/panel_raised.png`, `panel_sunken*.png` | 2 | 2 | 2 | 2 | |
| `ui/taskbar.png` | 0 | 1 | 0 | 0 | |
| `ui/toast.png` | 2 | 1 | 1 | 1 | |
| `ui/tooltip.png` | 1 | 1 | 1 | 1 | |
| `ui/panel_dashed.png` | 1 | 1 | 1 | 1 | Axis Stretch = **Tile** |
| `ui/progress_fill*.png` | 3 | 3 | 3 | 3 | výplň je zapuštěná o 2 px |

Ostatní textury se nenatahují: tlačítka okna 7×7, checkbox a radio 11×11, šipky posuvníku 9×9, START 30×9.

## Font
- `font/mouse_os_font.fnt`: bitmapový font, velikost **7**, výška řádku 7. Theme ho používá jako výchozí
  a je ostrý bez dalšího nastavování.
- `font/MouseOS.ttf`: stejný font jako TTF. Používej velikosti 7, 14 nebo 21 (násobky 7). Import je nastavený bez
  vyhlazování (Antialiasing None, Hinting None).
- Umí A–Z, 0–9 a běžnou interpunkci. Malá písmena se zobrazí jako velká.

## Kurzory (hotspot = bod kliknutí)
| soubor | velikost | hotspot |
|---|---|---|
| `cursor_arrow.png` | 12×16 | 0, 0 |
| `cursor_hand.png` | 11×13 | 3, 0 |
| `cursor_busy.png` | 11×14 | 5, 7 |
| `cursor_ibeam.png` | 7×10 | 3, 5 |
| `cursor_drag.png` | 12×14 | 0, 0 |

## Ikony 12×12
key, lock, gatelock, folder, file, exe, drive, dino, trash, trash_full, computer, notepad, mail, coin,
info, warning, error, question.

## Obrazovka
- `screen/wallpaper_208x118.png`: tapeta s logem. `wallpaper_tile_16.png` je dlaždice pro libovolnou velikost
  (TextureRect, Stretch Mode = Tile).
- `screen/crt_overlay_208x128.png`: scanlines a vinětace. Dej ji jako poslední TextureRect nahoru s `mouse_filter = Ignore`.
- `screen/chart_grid_tile_20x12.png`: mřížka grafu pro burzu (Tile).

## Paleta
```
plocha      #1F6B6E / #1B6164      text          #221F1C
okno        #D6D0C2  světlo #FBF9F3  stín #8F8778  obrys #2A2622
lišta       #4A90D0 -> #1D3B7A      výběr         #2F5FB0
oranžová    #EC8A2C  (#FFC07A / #A8581A)   zelená #3FA35A   červená #D9453F
```
