// Sync Thunderbird via Dropbox:
// http://lifehacker.com/5805828/how-to-sync-your-desktop-email-client-outlook-or-thunderbird-across-multiple-computers
//
// Hogy a Gmail-t is hasznalhasd:
// https://www.google.com/settings/security/lesssecureapps
// Ne felejtsd el engedelyezni az IMAP-ot!

// Usenet (Google csoportok):
//  news.gmane.org

// UTF8 hasznalata a levelekben.
user_pref("mailnews.reply_in_default_charset", true);
user_pref("mailnews.send_default_charset", "UTF-8");
user_pref("mailnews.view_default_charset", "UTF-8");
// Ne idezze az eredeti uzenetet valaszolaskor.
user_pref("mail.identity.id1.auto_quote", false);
// Alairas.
user_pref("mail.identity.id1.htmlSigFormat", true);
user_pref("mail.identity.id1.htmlSigText", "http://BimbaLaszlo.github.io/");
// Minden imap konyvtar frissitese.
user_pref("mail.server.default.check_all_folders_for_new", true);
// Percenkent frissitsen.
user_pref("mail.server.server1.check_time", 1);
// Datum szerint novekvo sorrendben rendezze alapbol a thread-eket.
// user_pref("mailnews.default_news_sort_order", 1)
// user_pref("mailnews.default_news_sort_type", 22)
// user_pref("mailnews.default_sort_order", 1)
// user_pref("mailnews.default_sort_type", 22)

// __ GMAIL-SZERU MUKODESHEZ ____________
//
// * menu / nezet / rendezes / temacsoport szerint

// * beallitasok / postafiok beallitasai / masolatok es mappak /
//   uzenetkuldeskor automatikusan masolat elhelyezese / az uzenetre adott
//   valaszok elhelyezese az uzenettel megegyezo mappaban
//
//   Ez azert jo, mert igy a beerkezo es elkuldott levelek is egy konyvtarban
//   lesznek, viszont csak ez utan lesz igy - a korabbi levelek meg kulon
//   maradnak.
user_pref("mail.identity.id1.fcc_reply_follows_parent", true);

// * szinkronizalas es tarhely / uzenetek szinkronizalasa / uzenetek
//   megtartasa ne legyen bekapcsolva
user_pref("mail.server.server1.offline_download", false);

// __ HASZNOS KIEGESZITOK _______________
//
//  * https://addons.mozilla.org/hu/thunderbird/addon/google-contacts/
//    A bellitasokban pipald be a "load contacts at startup" gombot.
user_pref("gmcont.auth_at_startup", true);

//  * https://addons.mozilla.org/en-us/firefox/addon/s3google-translator/?src=ss
//    Jobb klikk -> translate
//
//  * https://addons.mozilla.org/hu/thunderbird/addon/mail-merge/
//    Korlevelek kuldesehez.
//
//    FIGYELEM! A spam-szures domain-hez kotott es nem e-mail-hez (tehat ha
//    spam-nek tekint a Gmail, akkor nem csak a hirvelel@example.com-ot veszi
//    annak, hanem az example.com minden cimet).
