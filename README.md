# qui community themes

A collection of themes for [qui](https://github.com/autobrr/qui), made by the community.

> [!NOTE]
> Sideloading custom themes is a qui premium feature — it requires the same
> premium-access license that unlocks the built-in premium themes.

## Using a theme

1. Copy the theme's `.css` file from [`themes/`](./themes) into your qui custom themes directory:
   - **Docker:** `/config/themes`
   - **Linux:** `~/.config/qui/themes`
   - **Windows:** `%APPDATA%\qui\themes`
2. Open **Settings → Themes** in qui and hit **Refresh** — the theme appears in the **Custom Themes** section.

See the [custom themes documentation](https://getqui.com/docs/features/custom-themes) for the full details, including how to change the themes directory.

## Contributing a theme

1. Copy [`themes/_template.css`](./themes/_template.css) to `themes/your_theme_name.css` (snake_case).
2. Set `@name` and `@description` in the header comment and adjust the values. The [authoring guide](https://getqui.com/docs/features/custom-themes) lists every available token.
3. Open a pull request with light and dark mode screenshots.

Format requirements (CI checks these):

- One self-contained `.css` file per theme, directly in `themes/`, at most 1 MiB.
- Must contain a `:root { }` block (light mode) **and** a `.dark { }` block (dark mode), each with at least one `--variable`. Omitted tokens fall back to qui's defaults.
- No `@theme inline { }` block — qui maps tokens internally. Variations (multi-swatch themes) are not supported for custom themes.

## License

[MIT](./LICENSE). If your theme is a port of an existing theme, credit the original and its license in the file's header comment, e.g. `@description: Port of Dracula (draculatheme.com, MIT)`.
