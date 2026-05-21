// enable userChrome.css / userContent.css loading
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// force the built-in *default* webextension theme so its CSS doesn't fight
// our userChrome.css. compact-dark / system themes set --lwt-* and toolbar
// colors with higher specificity, blocking the pywal palette from showing.
user_pref("extensions.activeThemeID", "default-theme@mozilla.org");

// force dark mode for embedded chrome and content
user_pref("ui.systemUsesDarkTheme", 1);
user_pref("layout.css.prefers-color-scheme.content-override", 0);

// follow system theme for message HTML where possible
user_pref("mail.dark-reader.enabled", true);
user_pref("mail.dark-reader.show-toggle", true);

// keep tabs on top compact-ish; harmless if user changes via UI later
user_pref("mail.tabs.drawInTitlebar", true);
