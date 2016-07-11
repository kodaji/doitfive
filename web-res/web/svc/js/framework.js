// Date 를 포맷에 맞게 출력 한다.
Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";

    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;

    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};
String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};

(function($){$(document).ready(function(){
    /*
    // 1. unix timestamp을 사람이 볼 수 있는 시간으로 변경 한다.
    $('.ckpush-svc-to-human-time').each(function(){
        var $this = $(this), text = $this.text(), now = Math.floor($.now() / 1000),
            subtract = now - text;
        var str = '';

        if(subtract < 60) { str = subtract + ' 초전'; }
        else if(subtract < 3600) { str = Math.floor(subtract / 60) + ' 분전'; }
        else if(subtract < 86400) { str = Math.floor(subtract / 3600) + ' 시간전'; }
        else {
            var date = new Date(text * 1000);
            str = date.format('yyyy년 MM월 dd일');
        }

        $this.text(str);
    });
    */

    // 2. scroll 페이지에서 최상단 이동
    $('.ckpush-svc-scroll-top').click(function(e){
        e.preventDefault();
        e.stopPropagation();

        var $content = $('#content');
        if($content.scrollTop() > 0)
            $('#content').stop(true, false).animate({scrollTop : 0}, 400);

        return false;
    });

    // 3. 페이지 새로 고침
    $('.ckpush-svc-page-refresh').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        window.location.reload(true);
    });


});}(jQuery));




















