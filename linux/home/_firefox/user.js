# Mozilla User Preferences

// user.js: sajat firefox beallitasok
// =================== BimbaLaszlo (.github.io|gmail.com) ====================

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
 * vimfx - Vim iranyitas
 *  https://addons.mozilla.org/hu/firefox/addon/vimfx/
 */

user_pref("extensions.VimFx.hint_chars", "asdfghjkluiopqwer");
user_pref("extensions.VimFx.migration.0.applied", true);
user_pref("extensions.VimFx.migration.1.applied", true);
user_pref("extensions.VimFx.migration.2.applied", true);
user_pref("extensions.VimFx.migration.3.applied", true);
user_pref("extensions.VimFx.mode.find.exit", "<escape>    <enter>    <c-k>");
user_pref("extensions.VimFx.mode.hints.exit", "<escape>    <c-k>");
user_pref("extensions.VimFx.mode.normal.enter_mode_ignore", "<c-z>");
user_pref("extensions.VimFx.mode.normal.esc", "<force><escape>    <force><c-k>");
user_pref("extensions.VimFx.mode.normal.find", "");
user_pref("extensions.VimFx.mode.normal.find_highlight_all", "/");
user_pref("extensions.VimFx.mode.normal.find_links_only", "");
user_pref("extensions.VimFx.mode.normal.focus_location_bar", "<space>ff");
user_pref("extensions.VimFx.mode.normal.focus_search_bar", "");
user_pref("extensions.VimFx.mode.normal.focus_text_input", "");
user_pref("extensions.VimFx.mode.normal.follow", "s");
user_pref("extensions.VimFx.mode.normal.follow_copy", "ys");
user_pref("extensions.VimFx.mode.normal.follow_focus", "");
user_pref("extensions.VimFx.mode.normal.follow_in_focused_tab", "gs");
user_pref("extensions.VimFx.mode.normal.follow_in_tab", "");
user_pref("extensions.VimFx.mode.normal.follow_in_window", "");
user_pref("extensions.VimFx.mode.normal.follow_multiple", "");
user_pref("extensions.VimFx.mode.normal.follow_next", "");
user_pref("extensions.VimFx.mode.normal.follow_previous", "");
user_pref("extensions.VimFx.mode.normal.go_home", "");
user_pref("extensions.VimFx.mode.normal.go_to_root", "");
user_pref("extensions.VimFx.mode.normal.go_up_path", "");
user_pref("extensions.VimFx.mode.normal.paste_and_go", "");
user_pref("extensions.VimFx.mode.normal.paste_and_go_in_tab", "");
user_pref("extensions.VimFx.mode.normal.quote", "<c-v>");
user_pref("extensions.VimFx.mode.normal.reload", "");
user_pref("extensions.VimFx.mode.normal.reload_all", "");
user_pref("extensions.VimFx.mode.normal.reload_all_force", "");
user_pref("extensions.VimFx.mode.normal.reload_force", "<c-r>");
user_pref("extensions.VimFx.mode.normal.scroll_half_page_down", "<c-d>");
user_pref("extensions.VimFx.mode.normal.scroll_half_page_up", "<c-u>");
user_pref("extensions.VimFx.mode.normal.scroll_page_down", "");
user_pref("extensions.VimFx.mode.normal.scroll_page_up", "");
user_pref("extensions.VimFx.mode.normal.scroll_to_mark", "'");
user_pref("extensions.VimFx.mode.normal.stop", "");
user_pref("extensions.VimFx.mode.normal.stop_all", "");
user_pref("extensions.VimFx.mode.normal.tab_close", "<c-w><c-q>");
user_pref("extensions.VimFx.mode.normal.tab_close_other", "");
user_pref("extensions.VimFx.mode.normal.tab_close_to_end", "");
user_pref("extensions.VimFx.mode.normal.tab_duplicate", "");
user_pref("extensions.VimFx.mode.normal.tab_move_backward", "");
user_pref("extensions.VimFx.mode.normal.tab_move_forward", "");
user_pref("extensions.VimFx.mode.normal.tab_move_to_window", "");
user_pref("extensions.VimFx.mode.normal.tab_new", "<space>ft");
user_pref("extensions.VimFx.mode.normal.tab_restore", "u");
user_pref("extensions.VimFx.mode.normal.tab_select_first", "");
user_pref("extensions.VimFx.mode.normal.tab_select_first_non_pinned", "");
user_pref("extensions.VimFx.mode.normal.tab_select_last", "");
user_pref("extensions.VimFx.mode.normal.tab_select_next", "<c-e>    gt");
user_pref("extensions.VimFx.mode.normal.tab_select_previous", "<c-y>    gT");
user_pref("extensions.VimFx.mode.normal.tab_toggle_pinned", "");
user_pref("extensions.VimFx.mode.normal.window_new", "<c-w><c-s>");
user_pref("extensions.VimFx.mode.normal.window_new_private", "");

/* s3.google translator - translate.google.com a kepernyo aljan
 *  https://addons.mozilla.org/en-us/firefox/addon/s3google-translator/
 */

user_pref("extensions.s3gt.autotranslate",                          "stop");
user_pref("extensions.s3gt.basic_functions_in_panel",               false);
user_pref("extensions.s3gt.context_menu_show_icon",                 false);
user_pref("extensions.s3gt.context_menu_translate_auto",            false);
user_pref("extensions.s3gt.context_menu_translate_forget",          false);
user_pref("extensions.s3gt.context_menu_translate_page",            false);
user_pref("extensions.s3gt.is_first_run",                           false);
user_pref("extensions.s3gt.last_lang_from",                         "auto");
user_pref("extensions.s3gt.last_lang_to",                           "hu");
user_pref("extensions.s3gt.list_disabled_lang_to",                  "af,sq,ar,hy,az,eu,be,bn,bs,bg,ca,ceb,ny,zh-CN,zh-TW,ht,hr,cs,da,nl,eo,et,tl,fi,fr,gl,ka,de,el,gu,ha,iw,hi,hmn,is,ig,id,ga,it,ja,jw,kn,kk,km,ko,lo,la,lv,lt,mk,mg,ms,ml,mt,mi,mr,mn,my,ne,no,fa,pl,pt,pa,ro,ru,sr,st,si,sk,sl,so,es,su,sw,sv,tg,ta,te,th,tr,uk,ur,uz,vi,cy,yi,yo,zu");
user_pref("extensions.s3gt.reverse_lang_value",                     "en");
user_pref("extensions.s3gt.show_button_in_toolbar",                 "disabled");
user_pref("extensions.s3gt.show_tooltip_animation",                 "disabled");
user_pref("extensions.s3gt.translate_selection_fly_translate_plus", false);
user_pref("extensions.s3gt.translate_subtitles_youtube",            false);
user_pref("extensions.s3gt.view_reverse_translate_tooltip",         true);
user_pref("extensions.s3gt.view_source_translate_box",              true);
user_pref("extensions.s3gt.view_source_translate_tooltip",          true);
user_pref("extensions.s3gt.view_reverse_translate_tooltip",         false);

/* sztakidict - sztaki szotar a kijelolt szovegen jobbgomb utan
 *  https://addons.mozilla.org/hu/firefox/addon/sztakidict/
 *
 * tile view - az ablak felosztasa tobb reszre (szinkronizalni is lehet a
 * gorgetesuket)
 *  https://addons.mozilla.org/en-US/firefox/addon/tile-view/
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
 * user_pref("network.http.use-cache", false);
 */

/* Kezdooldal. */
user_pref("browser.startup.homepage", "https://www.google.hu/");

/* Mindig kerdezzen ra, hogy hova toltse le a cuccokat. */
user_pref("browser.download.useDownloadDir", false);

/* Menuelemek animalasanak kikapcsolasa. */
user_pref("browser.tabs.animate", false);
user_pref("ui.submenuDelay",      0    );

/* Cimsavban szimpla klatty kijelol mindent. */
user_pref("browser.urlbar.clickSelectsAll", true);

/* "Kozepso gombbal klatty es gorget" kikapcsolasa. */
user_pref("general.autoScroll", false);

/* Finom gorgetes kikapcsolasa. */
user_pref("general.smoothScroll", false);

/* Nyilakkal valo navigalas. */
// user_pref("accessibility.browsewithcaret", true);

/* Ne jegyezze meg a jelszavakat. */
user_pref("signon.rememberSignons", false);

/* Bezaraskor torolje... */
user_pref("privacy.clearOnShutdown.cache",        true);
user_pref("privacy.clearOnShutdown.cookies",      true);
user_pref("privacy.clearOnShutdown.passwords",    true);
user_pref("privacy.clearOnShutdown.sessions",     true);
user_pref("privacy.sanitize.sanitizeOnShutdown",  true);

/* ... ezeket viszon ne. */
user_pref("privacy.clearOnShutdown.downloads",    false);
user_pref("privacy.clearOnShutdown.formdata",     false);
user_pref("privacy.clearOnShutdown.history",      false);
user_pref("privacy.clearOnShutdown.offlineApps",  false);
user_pref("privacy.clearOnShutdown.siteSettings", false);

/*                                TWEAK                                 {{{1
 * =========================================================================
 */

// A lemez helyett a memoriaban legyen a cache, a merete legyen X kbyte, vagy
// -1 eseten magatol hatarozza meg.
user_pref("browser.cache.disk.enable",      false);
user_pref("browser.cache.memory.enable",    true);
user_pref("browser.cache.memory.capacity",  1000000);

// Toltes kozben a user interakciojat reszesitse elonyben az oldal
// betoltesehez kepest.
user_pref("content.interrupt.parsing",                           true);

// user_pref("network.http.max-persistent-connections-per-server",  16  );
// user_pref("network.http.max-persistent-connections-per-proxy",   32  );
// user_pref("network.http.pipelining",                             true);
// user_pref("network.http.pipelining.ssl",                         true);
