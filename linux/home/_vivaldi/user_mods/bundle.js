function loadMod(name) {
    const css = document.createElement("link");
    css.rel = "stylesheet";
    css.href = `user_mods/${name}.css`;
    document.head.appendChild(css);

    const js = document.createElement("script");
    js.src = `user_mods/${name}.js`;
    document.body.appendChild(js);
}

// loadMod("tabs-right-aligned");
loadMod("addressbar-to-titlebar");
loadMod("url-on-thumbnails");
loadMod("alert-on-find");
