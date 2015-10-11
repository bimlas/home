# http://ahal.ca/blog/2011/bulk-installing-fx-addons/
# Copy to the Firefox profile, then execute in it - it works on Windows
# (PowerShell) and Linux too.

pip2 install mozprofile

# Pentadactyl: Vim in Firefox
#   https://addons.mozilla.org/en-us/firefox/addon/pentadactyl/
mozprofile --profile . --addon "https://github.com/bimbalaszlo/home/releases/download/pentadactyl/pentadactyl-1.2pre.xpi"

# Tile Vew: split window (sync scroll included)
#   https://addons.mozilla.org/en-US/firefox/addon/tile-view/
mozprofile --profile . --addon "https://addons.mozilla.org/firefox/downloads/latest/311619/addon-311619-latest.xpi"

# S3.Google Translator: translate selected text with translate.google.com
#   https://addons.mozilla.org/en-us/firefox/addon/s3google-translator/
mozprofile --profile . --addon "https://addons.mozilla.org/firefox/downloads/latest/285546/addon-285546-latest.xpi"

# SztakiDict: translate selected text with szotar.sztaki.hu
#   https://addons.mozilla.org/hu/firefox/addon/sztakidict/
mozprofile --profile . --addon "https://addons.mozilla.org/firefox/downloads/file/114590/sztakidict-0.7-tb+fx.xpi"

# Reddit Enhanced Suite (RES): better Reddit.com experience
#   https://addons.mozilla.org/En-us/firefox/addon/reddit-enhancement-suite/
mozprofile --profile . --addon "https://addons.mozilla.org/firefox/downloads/latest/387429/addon-387429-latest.xpi"