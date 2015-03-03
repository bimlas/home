// Egy hasznos kiegeszito:
// https://addons.mozilla.org/hu/thunderbird/addon/gmail-conversation-view/
// Ne felejtsd el a beallitasok kozott bekapcsolni az "I love attachments"
// opciot, kulonben neha nem mutatja meg a csatolt fajlokat.
//
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
                                     // Ez meg nem tiszta, hogy mit is csinal.
user_pref("mail.check_all_imap_folders_for_new", true);
