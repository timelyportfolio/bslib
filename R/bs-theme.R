#' Create a Bootstrap theme
#'
#' @description
#'
#' Creates a Bootstrap theme object, where you can:
#'
#' * Choose a (major) Bootstrap `version`.
#' * Choose a [Bootswatch theme](https://bootswatch.com) (optional).
#' * Customize main colors and fonts via explicitly named arguments (e.g.,
#'   `bg`, `fg`, `primary`, etc).
#' * Customize other, lower-level, Bootstrap Sass variable defaults via `...`.
#'
#' To learn more about how to implement custom themes, as well as how to use
#' them inside Shiny and R Markdown, [see
#' here](https://rstudio.github.io/bslib/articles/theming.html).
#'
#' @section Colors:
#'
#'  Colors may be provided in any format that [htmltools::parseCssColors()] can
#'  understand. To control the vast majority of the ('grayscale') color
#'  defaults, specify both the `fg` (foreground) and `bg` (background) colors.
#'  The `primary` and `secondary` theme colors are also useful for accenting the
#'  main grayscale colors in things like hyperlinks, tabset panels, and buttons.
#'
#' @section Fonts:
#'
#'  Use `base_font`, `code_font`, and `heading_font` to control the main
#'  typefaces. These arguments set new defaults for the relevant `font-family`
#'  CSS properties, but don't necessarily import the relevant font files. To
#'  both set CSS properties _and_ import font files, consider using the various
#'  [font_face()] helpers.
#'
#'  Each `*_font` argument may be a single font or a `font_collection()`.
#'  A font can be created with [font_google()], [font_link()], or [font_face()],
#'  or it can be a character vector of font names in the following format:
#'    * A single unquoted name (e.g., `"Source Sans Pro"`).
#'    * A single quoted name (e.g., `"'Source Sans Pro'"`).
#'    * A comma-separated list of names w/ individual names quoted as necessary.
#'      (e.g. `c("Open Sans", "'Source Sans Pro'", "'Helvetica Neue', Helvetica, sans-serif")`)
#'
#'  `font_google()` sets `local = TRUE` by default, which ensures that the font
#'  files are downloaded from [Google Fonts](https://fonts.google.com/) when
#'  your document or app is rendered. This guarantees that the client has access
#'  to the font family, making it relatively safe to specify just one font
#'  family:
#'
#'  ```r
#'  bs_theme(base_font = font_google("Pacifico", local = TRUE))
#'  ```
#'
#'  That said, we recommend you specify multiple "fallback" font families,
#'  especially when relying on remote and/or system fonts being available.
#'  Fallback fonts are useful not only for handling missing fonts, but also
#'  ensure that your users don't experience a Flash of Invisible Text (FOIT)
#'  which can be quite noticeable with remote web fonts on a slow internet
#'  connection.
#'
#'  ```r
#'  bs_theme(base_font = font_collection(font_google("Pacifico", local = FALSE), "Roboto", "sans-serif"))
#'  ````
#'
#' @references
#'   * [Get Started: Theming](https://rstudio.github.io/bslib/articles/theming/index.html)
#'     introduces theming with bslib in Shiny apps and R Markdown documents.
#'   * [Theming: Bootstrap 5 variables](https://rstudio.github.io/bslib/articles/bs5-variables/index.html)
#'     provides a searchable reference of all theming variables available in
#'     Bootstrap 5.
#'   * [Theming: Custom components](https://rstudio.github.io/bslib/articles/custom-components/index.html)
#'     gives a tutorial on creating a dynamically themable custom component.
#'   * bslib's theming capabilities are powered by
#'     [the {sass} package](https://rstudio.github.io/sass/).
#'   * [Bootstrap's utility classes](https://rstudio.github.io/bslib/articles/utility-classes/index.html)
#'     can be helpful when you want to change the appearance of an element
#'     without writing CSS or customizing your `bs_theme()`.
#'
#' @family Bootstrap theme functions
#'
#' @param version The major version of Bootstrap to use (see [versions()]
#'   for possible values). Defaults to the currently recommended version
#'   for new projects (currently Bootstrap 5).
#' @param preset The name of a theme preset, either a built-in theme provided by
#'   bslib or a Bootswatch theme (see [builtin_themes()] and
#'   [bootswatch_themes()] for possible values). This argument takes precedence
#'   over the `bootswatch` argument and only one `preset` or `bootswatch` can be
#'   provided. When no `bootswatch` theme is specified, and `version` is 5 or
#'   higher, `preset` defaults to `"shiny"`. To remove the `"shiny"` preset,
#'   provide a value of `"bootstrap"` (this value will also work in
#'   `bs_theme_update()` to remove a `preset` or `bootswatch` theme).
#' @param brand Specifies how to apply branding to your theme using
#'   [brand.yml](https://posit-dev.github.io/brand-yml/), a simple YAML file that
#'   defines key brand elements like colors, fonts, and logos. Valid options:
#'
#'   - `NULL` (default): Automatically looks for a `_brand.yml` file in the
#'     current directory or in `_brand/` or `brand/` in the current directory.
#'     If not found, it searches parent project directories for a `_brand.yml`
#'     file (also possibly in `_brand/` or `brand/`). If a `_brand.yml` file is
#'     found, it is applied to the Bootstrap theme.
#'   - `TRUE` (default): Automatically looks for a `_brand.yml` file in the
#'     current or app directory as described above. If a `_brand.yml` file
#'     *is not found*, `bs_theme()` will throw an error.
#'   - `FALSE`: Disables any brand.yml usage, even if a `_brand.yml` file is
#'     present.
#'   - A file path that directly points to a specific brand.yml file (with any
#'     file name) that you want to use.
#'   - Use a list to directly provide brand settings directly in R, following
#'     the brand.yml structure.
#'
#'   Learn more about creating and using brand.yml files at the
#'   [brand.yml homepage](https://posit-dev.github.io/brand-yml/) or run
#'   `shiny::runExample("brand.yml", package = "bslib")` to try brand.yml in a
#'   demo app.
#' @param bootswatch The name of a bootswatch theme (see [bootswatch_themes()]
#'   for possible values). When provided to `bs_theme_update()`, any previous
#'   Bootswatch theme is first removed before the new one is applied (use
#'   `bootswatch = "bootstrap"` to effectively remove the Bootswatch theme).
#' @param ... arguments passed along to [bs_add_variables()].
#' @param bg A color string for the background.
#' @param fg A color string for the foreground.
#' @param primary A color to be used for hyperlinks, to indicate primary/default
#'   actions, and to show active selection state in some Bootstrap components.
#'   Generally a bold, saturated color that contrasts with the theme's base
#'   colors.
#' @param secondary A color for components and messages that don't need to stand
#'   out. (Not supported in Bootstrap 3.)
#' @param success A color for messages that indicate an operation has succeeded.
#'   Typically green.
#' @param info A color for messages that are informative but not critical.
#'   Typically a shade of blue-green.
#' @param warning A color for warning messages. Typically yellow.
#' @param danger A color for errors. Typically red.
#' @param base_font The default typeface.
#' @param code_font The typeface to be used for code. Be sure this is monospace!
#' @param heading_font The typeface to be used for heading elements.
#' @param font_scale A scalar multiplier to apply to the base font size. For
#'   example, a value of `1.5` scales font sizes to 150% and a value of `0.8`
#'   scales to 80%. Must be a positive number.
#'
#' @return Returns a [sass::sass_bundle()] (list-like) object.
#'
#' @examplesIf rlang::is_interactive()
#'
#' theme <- bs_theme(
#'   # Controls the default grayscale palette
#'   bg = "#202123", fg = "#B8BCC2",
#'   # Controls the accent (e.g., hyperlink, button, etc) colors
#'   primary = "#EA80FC", secondary = "#48DAC6",
#'   base_font = c("Grandstander", "sans-serif"),
#'   code_font = c("Courier", "monospace"),
#'   heading_font = "'Helvetica Neue', Helvetica, sans-serif",
#'   # Can also add lower-level customization
#'   "input-border-color" = "#EA80FC"
#' )
#'
#' bs_theme_preview(theme)
#'
#' # Lower-level bs_add_*() functions allow you to work more
#' # directly with the underlying Sass code
#' theme <- bs_add_variables(theme, "my-class-color" = "red")
#' theme <- bs_add_rules(theme, ".my-class { color: $my-class-color }")
#'
#' @export
bs_theme <- function(
  version = version_default(),
  preset = NULL,
  ...,
  brand = NULL,
  bg = NULL,
  fg = NULL,
  primary = NULL,
  secondary = NULL,
  success = NULL,
  info = NULL,
  warning = NULL,
  danger = NULL,
  base_font = NULL,
  code_font = NULL,
  heading_font = NULL,
  font_scale = NULL,
  bootswatch = NULL
) {
  is_version_from_user <- !missing(version)

  brand <- brand_resolve(brand)

  preset <-
    if (!is.null(brand)) {
      brand_resolve_preset(
        brand = brand,
        preset = preset,
        version = if (is_version_from_user) version
      )
    } else {
      if (is.null(preset) && is.null(bootswatch) && version >= 5) {
        preset <- "shiny"
      }
      resolve_bs_preset(preset, bootswatch, version = version)
    }

  version <- preset$version %||% version %||% version_default()

  bundle <- bs_bundle(
    bs_theme_init(version),
    bootstrap_bundle(version),
    bs_preset_bundle(preset),
    bs_brand_bundle(brand, version = version)
  )

  if (!is.null(preset$type)) {
    bundle <- add_class(bundle, THEME_PRESET_CLASS)
  }

  bundle <- bs_theme_update(
    bundle,
    ...,
    bg = bg,
    fg = fg,
    primary = primary,
    secondary = secondary,
    success = success,
    info = info,
    warning = warning,
    danger = danger,
    base_font = base_font,
    code_font = code_font,
    heading_font = heading_font,
    font_scale = font_scale
  )

  if (!is.null(brand)) {
    bundle <- add_class(bundle, "bs_theme_brand")
    attr(bundle, "brand") <- brand
  }

  bundle
}

#' @rdname bs_theme
#' @param theme A [bs_theme()] object.
#' @export
bs_theme_update <- function(
  theme,
  ...,
  preset = NULL,
  bg = NULL,
  fg = NULL,
  primary = NULL,
  secondary = NULL,
  success = NULL,
  info = NULL,
  warning = NULL,
  danger = NULL,
  base_font = NULL,
  code_font = NULL,
  heading_font = NULL,
  font_scale = NULL,
  bootswatch = NULL
) {
  assert_bs_theme(theme)

  preset <- resolve_bs_preset(
    preset,
    bootswatch,
    version = theme_version(theme)
  )

  if (!is.null(preset)) {
    theme_has_preset <- inherits(theme, THEME_PRESET_CLASS)

    if (theme_has_preset) {
      # remove the old preset
      theme <- bs_remove(theme, theme_preset_info(theme)$type)
      class(theme) <- setdiff(class(theme), THEME_PRESET_CLASS)
    }

    # Add in the new preset unless vanilla bootstrap was requested
    if (!identical(preset$name, "bootstrap")) {
      theme <- add_class(theme, THEME_PRESET_CLASS)
      theme <- bs_bundle(theme, bs_preset_bundle(preset))
    }
  }

  # See R/bs-theme-update.R for the implementation of these
  theme <- bs_base_colors(theme, bg = bg, fg = fg)
  theme <- bs_accent_colors(
    theme,
    primary = primary,
    secondary = secondary,
    success = success,
    info = info,
    warning = warning,
    danger = danger
  )
  theme <- bs_fonts(
    theme,
    base = base_font,
    code = code_font,
    heading = heading_font
  )
  if (!is.null(font_scale)) {
    stopifnot(is.numeric(font_scale) && length(font_scale) == 1)
    theme <- bs_add_variables(
      theme,
      "font-size-base" = paste(
        font_scale,
        "*",
        bs_get_variables(theme, "font-size-base")
      )
    )
  }
  bs_add_variables(theme, ...)
}

#' @rdname bs_global_theme
#' @export
bs_global_theme_update <- function(
  ...,
  preset = NULL,
  bg = NULL,
  fg = NULL,
  primary = NULL,
  secondary = NULL,
  success = NULL,
  info = NULL,
  warning = NULL,
  danger = NULL,
  base_font = NULL,
  code_font = NULL,
  heading_font = NULL,
  bootswatch = NULL
) {
  theme <- assert_global_theme("bs_theme_global_update()")
  bs_global_set(
    bs_theme_update(
      theme,
      ...,
      preset = preset,
      bootswatch = bootswatch,
      bg = bg,
      fg = fg,
      primary = primary,
      secondary = secondary,
      success = success,
      info = info,
      warning = warning,
      danger = danger,
      base_font = base_font,
      code_font = code_font,
      heading_font = heading_font
    )
  )
}

#' @rdname bs_theme
#' @param x an object.
#' @export
is_bs_theme <- function(x) {
  inherits(x, "bs_theme")
}

# Start an empty bundle with special classes that
# theme_version() & theme_bootswatch() search for
bs_theme_init <- function(version) {
  init_layer <- sass_layer(
    defaults = list(
      "bootstrap-version" = version,
      "bslib-preset-name" = "null !default",
      "bslib-preset-type" = "null !default"
    ),
    rules = c(
      ":root {",
      "--bslib-bootstrap-version: #{$bootstrap-version};",
      "--bslib-preset-name: #{$bslib-preset-name};",
      "--bslib-preset-type: #{$bslib-preset-type};",
      "}"
    )
  )

  add_class(init_layer, c(paste0("bs_version_", version), "bs_theme"))
}

assert_bs_theme <- function(theme) {
  if (!is_bs_theme(theme)) {
    stop("`theme` must be a `bs_theme()` object")
  }
  invisible(theme)
}

# -----------------------------------------------------------------
# Core Bootstrap bundle
# -----------------------------------------------------------------

bootstrap_bundle <- function(version) {
  pandoc_tables <- list(
    # Pandoc uses align attribute to align content but BS4 styles take precedence...
    # we may want to consider adopting this more generally in "strict" BS4 mode as well
    ".table th[align=left] { text-align: left; }",
    ".table th[align=right] { text-align: right; }",
    ".table th[align=center] { text-align: center; }"
  )

  main_bundle <- switch_version(
    version,
    five = sass_bundle(
      # Don't name this "core" bundle so it can't easily be removed
      sass_layer(
        functions = bs5_sass_files("functions"),
        defaults = list(
          bs5_sass_files("variables"),
          bs5_sass_files("variables-dark")
        ),
        mixins = list(bs5_sass_files("maps"), bs5_sass_files("mixins")),
        rules = list(bs5_sass_files("mixins/banner"), "@include bsBanner('')")
      ),
      # Returns a _named_ list of bundles (i.e., these should be easily removed)
      !!!rule_bundles(
        # Names here should match https://github.com/twbs/bs5/blob/master/scss/bootstrap.scss
        bs5_sass_files(
          c(
            "utilities",
            "root",
            "reboot",
            "type",
            "images",
            "containers",
            "grid",
            "tables",
            "forms",
            "buttons",
            "transitions",
            "dropdown",
            "button-group",
            "nav",
            "navbar",
            "card",
            "accordion",
            "breadcrumb",
            "pagination",
            "badge",
            "alert",
            "progress",
            "list-group",
            "close",
            "toasts",
            "modal",
            "tooltip",
            "popover",
            "carousel",
            "spinners",
            "offcanvas",
            "placeholders",
            "helpers",
            "utilities/api"
          )
        )
      ),
      # Additions to BS5 that are always included (i.e., not a part of compatibility)
      sass_layer(rules = pandoc_tables),
      bs3compat = bs3compat_bundle(),
      # Enable CSS Grid powered Bootstrap grid
      sass_layer(
        defaults = list("enable-cssgrid" = "true !default")
      )
    ),
    four = sass_bundle(
      sass_layer(
        functions = bs4_sass_files(c("deprecated", "functions")),
        defaults = bs4_sass_files("variables"),
        mixins = bs4_sass_files("mixins")
      ),
      # Returns a _named_ list of bundles (i.e., these should be easily removed)
      !!!rule_bundles(
        # Names here should match https://github.com/twbs/bs4/blob/master/scss/bootstrap.scss
        bs4_sass_files(
          c(
            "root",
            "reboot",
            "type",
            "images",
            "code",
            "grid",
            "tables",
            "forms",
            "buttons",
            "transitions",
            "dropdown",
            "button-group",
            "input-group",
            "custom-forms",
            "nav",
            "navbar",
            "card",
            "breadcrumb",
            "pagination",
            "badge",
            "jumbotron",
            "alert",
            "progress",
            "media",
            "list-group",
            "close",
            "toasts",
            "modal",
            "tooltip",
            "popover",
            "carousel",
            "spinners",
            "utilities",
            "print"
          )
        )
      ),
      # Additions to BS4 that are always included (i.e., not a part of compatibility)
      sass_layer(rules = pandoc_tables),
      bs3compat = bs3compat_bundle()
    ),
    three = sass_bundle(
      sass_layer(
        defaults = bs3_sass_files("variables"),
        mixins = bs3_sass_files("mixins")
      ),
      # Should match https://github.com/twbs/bootstrap-sass/blob/master/assets/stylesheets/_bootstrap.scss
      !!!rule_bundles(
        bs3_sass_files(
          c(
            "normalize",
            "print",
            "glyphicons",
            "scaffolding",
            "type",
            "code",
            "grid",
            "tables",
            "forms",
            "buttons",
            "component-animations",
            "dropdowns",
            "button-groups",
            "input-groups",
            "navs",
            "navbar",
            "breadcrumbs",
            "pagination",
            "pager",
            "labels",
            "badges",
            "jumbotron",
            "thumbnails",
            "alerts",
            "progress-bars",
            "media",
            "list-group",
            "panels",
            "responsive-embed",
            "wells",
            "close",
            "modals",
            "tooltip",
            "popovers",
            "carousel",
            "utilities",
            "responsive-utilities"
          )
        )
      ),
      accessibility = bs3_accessibility_bundle(),
      glyphicon_font_files = sass_layer(
        defaults = list("icon-font-path" = "'glyphicon-fonts/'"),
        file_attachments = c(
          "glyphicon-fonts" = path_lib("bs3", "assets", "fonts", "bootstrap")
        )
      )
    )
  )

  sass_bundle(
    main_bundle,
    bslib_bundle()
  )
}

bootstrap_javascript_map <- function(version) {
  switch_version(
    version,
    five = path_lib("bs5", "dist", "js", "bootstrap.bundle.min.js.map"),
    four = path_lib("bs4", "dist", "js", "bootstrap.bundle.min.js.map")
  )
}
bootstrap_javascript <- function(version) {
  switch_version(
    version,
    five = path_lib("bs5", "dist", "js", "bootstrap.bundle.min.js"),
    four = path_lib("bs4", "dist", "js", "bootstrap.bundle.min.js"),
    three = path_lib("bs3", "assets", "javascripts", "bootstrap.min.js")
  )
}

# -----------------------------------------------------------------
# bslib specific Sass that gets bundled with Bootstrap
# -----------------------------------------------------------------

bslib_bundle <- function() {
  sass_layer(
    functions = sass_file(path_inst("bslib-scss", "functions.scss")),
    rules = sass_file(path_inst("bslib-scss", "bslib.scss"))
  )
}

# -----------------------------------------------------------------
# BS3 compatibility bundle
# -----------------------------------------------------------------

bs3compat_bundle <- function() {
  sass_layer(
    defaults = sass_file(
      system_file("bs3compat", "_defaults.scss", package = "bslib")
    ),
    mixins = sass_file(
      system_file("bs3compat", "_declarations.scss", package = "bslib")
    ),
    rules = sass_file(
      system_file("bs3compat", "_rules.scss", package = "bslib")
    ),
    # Gyliphicon font files
    file_attachments = c(
      fonts = path_lib("bs3", "assets", "fonts")
    ),
    html_deps = htmltools::htmlDependency(
      "bs3compat",
      packageVersion("bslib"),
      package = "bslib",
      src = "bs3compat/js",
      script = c("transition.js", "tabs.js", "bs3compat.js")
    )
  )
}

# -----------------------------------------------------------------
# BS3 accessibility bundle
# -----------------------------------------------------------------

bs3_accessibility_bundle <- function() {
  sass_layer(
    rules = sass_file(
      system_file(
        "lib",
        "bs-a11y-p",
        "src",
        "sass",
        "bootstrap-accessibility.scss",
        package = "bslib"
      )
    ),
    html_deps = htmltools::htmlDependency(
      "bootstrap-accessibility",
      version_accessibility,
      package = "bslib",
      src = "lib/bs-a11y-p",
      script = "plugins/js/bootstrap-accessibility.min.js",
      all_files = FALSE
    )
  )
}
