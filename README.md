# qui community themes

A collection of themes for [qui](https://github.com/autobrr/qui), made by the community.

> [!NOTE]
> Sideloading custom themes is a qui premium feature. It needs the same premium-access license as the built-in premium themes.

## Themes

Screenshots show qui's dashboard with incognito mode on.

| Theme | Light | Dark |
| --- | --- | --- |
| [Catppuccin Latte](themes/catppuccin_latte.css) | <img src="screenshots/catppuccin_latte_light.png" width="400" alt="Catppuccin Latte light"> | <img src="screenshots/catppuccin_latte_dark.png" width="400" alt="Catppuccin Latte dark"> |
| [CS Office](themes/cs_office.css) | <img src="screenshots/cs_office_light.png" width="400" alt="CS Office light"> | <img src="screenshots/cs_office_dark.png" width="400" alt="CS Office dark"> |
| [Darcula](themes/darcula.css) | <img src="screenshots/darcula_light.png" width="400" alt="Darcula light"> | <img src="screenshots/darcula_dark.png" width="400" alt="Darcula dark"> |
| [Dracula](themes/dracula.css) | <img src="screenshots/dracula_light.png" width="400" alt="Dracula light"> | <img src="screenshots/dracula_dark.png" width="400" alt="Dracula dark"> |
| [Ethereal](themes/ethereal.css) | <img src="screenshots/ethereal_light.png" width="400" alt="Ethereal light"> | <img src="screenshots/ethereal_dark.png" width="400" alt="Ethereal dark"> |
| [Everforest](themes/everforest.css) | <img src="screenshots/everforest_light.png" width="400" alt="Everforest light"> | <img src="screenshots/everforest_dark.png" width="400" alt="Everforest dark"> |
| [Flexoki Light](themes/flexoki_light.css) | <img src="screenshots/flexoki_light_light.png" width="400" alt="Flexoki Light light"> | <img src="screenshots/flexoki_light_dark.png" width="400" alt="Flexoki Light dark"> |
| [Gruvbox](themes/gruvbox.css) | <img src="screenshots/gruvbox_light.png" width="400" alt="Gruvbox light"> | <img src="screenshots/gruvbox_dark.png" width="400" alt="Gruvbox dark"> |
| [Hackerman](themes/hackerman.css) | <img src="screenshots/hackerman_light.png" width="400" alt="Hackerman light"> | <img src="screenshots/hackerman_dark.png" width="400" alt="Hackerman dark"> |
| [Kanagawa](themes/kanagawa.css) | <img src="screenshots/kanagawa_light.png" width="400" alt="Kanagawa light"> | <img src="screenshots/kanagawa_dark.png" width="400" alt="Kanagawa dark"> |
| [Last Horizon](themes/last_horizon.css) | <img src="screenshots/last_horizon_light.png" width="400" alt="Last Horizon light"> | <img src="screenshots/last_horizon_dark.png" width="400" alt="Last Horizon dark"> |
| [Lumon](themes/lumon.css) | <img src="screenshots/lumon_light.png" width="400" alt="Lumon light"> | <img src="screenshots/lumon_dark.png" width="400" alt="Lumon dark"> |
| [Lupine](themes/lupine.css) | <img src="screenshots/lupine_light.png" width="400" alt="Lupine light"> | <img src="screenshots/lupine_dark.png" width="400" alt="Lupine dark"> |
| [Matte Black](themes/matte_black.css) | <img src="screenshots/matte_black_light.png" width="400" alt="Matte Black light"> | <img src="screenshots/matte_black_dark.png" width="400" alt="Matte Black dark"> |
| [Miasma](themes/miasma.css) | <img src="screenshots/miasma_light.png" width="400" alt="Miasma light"> | <img src="screenshots/miasma_dark.png" width="400" alt="Miasma dark"> |
| [Monokai](themes/monokai.css) | <img src="screenshots/monokai_light.png" width="400" alt="Monokai light"> | <img src="screenshots/monokai_dark.png" width="400" alt="Monokai dark"> |
| [One Dark](themes/one_dark.css) | <img src="screenshots/one_dark_light.png" width="400" alt="One Dark light"> | <img src="screenshots/one_dark_dark.png" width="400" alt="One Dark dark"> |
| [Osaka Jade](themes/osaka_jade.css) | <img src="screenshots/osaka_jade_light.png" width="400" alt="Osaka Jade light"> | <img src="screenshots/osaka_jade_dark.png" width="400" alt="Osaka Jade dark"> |
| [Retro 82](themes/retro_82.css) | <img src="screenshots/retro_82_light.png" width="400" alt="Retro 82 light"> | <img src="screenshots/retro_82_dark.png" width="400" alt="Retro 82 dark"> |
| [Ristretto](themes/ristretto.css) | <img src="screenshots/ristretto_light.png" width="400" alt="Ristretto light"> | <img src="screenshots/ristretto_dark.png" width="400" alt="Ristretto dark"> |
| [Rosé Pine](themes/rose_pine.css) | <img src="screenshots/rose_pine_light.png" width="400" alt="Rosé Pine light"> | <img src="screenshots/rose_pine_dark.png" width="400" alt="Rosé Pine dark"> |
| [Solitude](themes/solitude.css) | <img src="screenshots/solitude_light.png" width="400" alt="Solitude light"> | <img src="screenshots/solitude_dark.png" width="400" alt="Solitude dark"> |
| [Vantablack](themes/vantablack.css) | <img src="screenshots/vantablack_light.png" width="400" alt="Vantablack light"> | <img src="screenshots/vantablack_dark.png" width="400" alt="Vantablack dark"> |
| [White](themes/white.css) | <img src="screenshots/white_light.png" width="400" alt="White light"> | <img src="screenshots/white_dark.png" width="400" alt="White dark"> |

## Using a theme

1. Copy the theme's `.css` file from [`themes/`](./themes) into your qui custom themes directory:
   - **Docker:** `/config/themes`
   - **Linux:** `~/.config/qui/themes`
   - **Windows:** `%APPDATA%\qui\themes`
2. Open **Settings → Themes** in qui and click **Refresh**. The theme appears in the **Custom Themes** section.

See the [custom themes documentation](https://getqui.com/docs/features/custom-themes) for details, including how to change the themes directory.

On Omarchy? [omarchy-qui](https://github.com/s0up4200/omarchy-qui) switches qui to the matching theme whenever your desktop theme changes.

## Contributing a theme

1. Copy [`themes/_template.css`](./themes/_template.css) to `themes/your_theme_name.css` (snake_case).
2. Set `@name` and `@description` in the header comment and adjust the values. The [authoring guide](https://getqui.com/docs/features/custom-themes) lists every available token.
3. Add `screenshots/your_theme_name_light.png` and `screenshots/your_theme_name_dark.png`: the qui dashboard with incognito mode on, in light and dark mode. Add a row for the theme to the gallery table above. CI fails without them.
4. Open a pull request.

Format requirements:

- One self-contained `.css` file per theme, directly in `themes/`, at most 1 MiB.
- Must contain a `:root { }` block (light mode) and a `.dark { }` block (dark mode), each with at least one `--variable`. Omitted tokens fall back to qui's defaults.
- No `@theme inline { }` block. qui maps the tokens itself. Custom themes do not support variations (multi-swatch themes).

## License

[MIT](./LICENSE). If your theme is a port of an existing theme, credit the original and its license in the file's header comment, e.g. `@description: Port of Dracula (draculatheme.com, MIT)`.
