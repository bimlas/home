# Mozilla User Preferences

// user.js: sajat firefox beallitasok
// ========= BimbaLaszlo (.github.io|gmail.com) ========== 2015.07.27 08:14 ==

/* Win7-en a kovetkezo konyvtarba kell bemasolni:
 *  C:\Users\USER\AppData\Roaming\Mozilla\Firefox\Profiles\PROFIL\user.js
 *
 * Linux:
 *  ~/.mozilla/firefox/PROFIL/user.js
 *
 * Hogy valoban csak ezek a beallitasok legyenek ervenyben, a Firefox inditasa
 * elott torold az ugyanitt talalhato 'prefs.js' fajlt.
 */

/*                                 KIEGESZITOK                            {{{1
 * ===========================================================================
 *
 * s3.google translator - translate.google.com a kepernyo aljan
 *  https://addons.mozilla.org/en-us/firefox/addon/s3google-translator/?src=ss
 *
 * chatzilla - irc kliens
 *  https://addons.mozilla.org/hu/firefox/addon/chatzilla/
 *
 * edit cookies - no comment
 *  https://addons.mozilla.org/hu/firefox/addon/edit-cookies/
 *
 * tamper data - kuldott adatok (pl. POST) modositasa
 *  https://addons.mozilla.org/hu/firefox/addon/tamper-data/
 *
 * downthemall - kepek/weboldalak tomeges letoltese
 *  https://addons.mozilla.org/hu/firefox/addon/downthemall/
 *
 * vlc youtube shortcut - video kozvetlenul a vlc-ben (jobbgombos menu)
 * FIGYELEM: mintha kicsit lassitana a firefox-on
 *  https://addons.mozilla.org/hu/firefox/addon/vlc-youtube-shortcut/
 *
 * firebug - hiaba a beepitett hibakereso - ez ezerszer jobb
 *  https://addons.mozilla.org/hu/firefox/addon/firebug/
 *
 * web developer - hasznos lehetosegeket kinal (pl. osszes checkbox pipalasa)
 *  https://addons.mozilla.org/hu/firefox/addon/web-developer/?src=search
 */

/*                                 ABOUT LAPOK                            {{{1
 * ===========================================================================
 *
 * about:about      az osszes lap listaja
 *       config     beallitasok listaja
 *       cache      cache tartalma
 *       telemetry  a telemetria ezeket az adatokat kuldi el
 *                                                                        }}}1
 *
 * Webfejlesztesnel hasznos:
 * user_pref( "network.http.use-cache", false );
 */

/* Kezdooldal. */
user_pref( "browser.startup.homepage", "https://www.google.hu/" );

/* Mindig kerdezzen ra, hogy hova toltse le a cuccokat. */
user_pref( "browser.download.useDownloadDir", false );

/* Menuelemek animalasanak kikapcsolasa. */
user_pref( "browser.tabs.animate", false );
user_pref( "ui.submenuDelay",      0     );

/* Cimsavban szimpla klatty kijelol mindent. */
user_pref( "browser.urlbar.clickSelectsAll", true );

/* "Kozepso gombbal klatty es gorget" kikapcsolasa. */
user_pref( "general.autoScroll", false );

/* Finom gorgetes kikapcsolasa. */
user_pref( "general.smoothScroll", false );

/* Nyilakkal valo navigalas. */
// user_pref( "accessibility.browsewithcaret", true );

/* Ne jegyezze meg a jelszavakat. */
user_pref( "signon.rememberSignons", false );

/* Ne kovessenek. */
user_pref( "privacy.trackingprotection.enabled", true )

/* Bezaraskor torolje... */
user_pref( "privacy.clearOnShutdown.cache",         true );
user_pref( "privacy.clearOnShutdown.cookies",       true );
user_pref( "privacy.clearOnShutdown.passwords",     true );
user_pref( "privacy.clearOnShutdown.sessions",      true );
user_pref( "privacy.sanitize.sanitizeOnShutdown",   true );

/* ... ezeket viszon ne. */
user_pref( "privacy.clearOnShutdown.downloads",     false );
user_pref( "privacy.clearOnShutdown.formdata",      false );
user_pref( "privacy.clearOnShutdown.history",       false );
user_pref( "privacy.clearOnShutdown.offlineApps",   false );
user_pref( "privacy.clearOnShutdown.siteSettings",  false );

/*                                TWEAK                                 {{{1
 * =========================================================================
 */

// A lemez helyett a memoriaban legyen a cache, a merete legyen X kbyte, vagy
// -1 eseten magatol hatarozza meg.
user_pref( "browser.cache.disk.enable",      false );
user_pref( "browser.cache.memory.enable",    true );
user_pref( "browser.cache.memory.capacity",  1000000 );

// Toltes kozben a user interakciojat reszesitse elonyben az oldal
// betoltesehez kepest.
user_pref( "content.interrupt.parsing",                           true );

// user_pref( "network.http.max-persistent-connections-per-server",  16   );
// user_pref( "network.http.max-persistent-connections-per-proxy",   32   );
// user_pref( "network.http.pipelining",                             true );
// user_pref( "network.http.pipelining.ssl",                         true );
