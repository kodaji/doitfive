/**
 * smart admin 의 기본 값들을 재정의 한다.
 */
function checkURL() {
    var a = location.href.split("#").splice(1).join("#");
    if(!a)
        try {
            var b = window.document.URL;
            b && b.indexOf("#", 0) > 0 && b.indexOf("#", 0) < b.length + 1 && (a = b.substring(b.indexOf("#", 0) + 1));
        } catch (c) {}
    if(container = $("#content"), a) {
        var ass = a;
        if(my.data.staticHashURL) {
            ass = (my.data.staticHashURL).slice(0);
            my.data.staticHashURL = null;
        }
        $("nav li.active").removeClass("active"), $('nav li:has(a[href="' + ass + '"])').addClass("active");
        var d = $('nav a[href="' + a + '"]').attr("title");
        document.title = d || document.title, debugState && root.console.log("Page title: %c " + document.title, debugStyle_green), loadURL(a + location.search, container);
    } else {
        var e = $('nav > ul > li:first-child > a[href!="#"]');
        window.location.hash = e.attr("href"), e = null
    }
}