(function observeTopNodeWhenExists() {
    const DEBUG = true;

    const topNode = document.querySelector('#main');
    if (topNode === null) {
        setTimeout(observeTopNodeWhenExists, 300);
        return;
    } else {
        const titlebar = document.querySelector('.tab-strip');
        const addressbar = document.querySelector('.addressfield');
        // Place it before the tabs
        titlebar.insertAdjacentElement('afterbegin', addressbar);
        // Place after the tabs
        // titlebar.appendChild(addressbar);
    }
})();
