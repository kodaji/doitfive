var my;
if(!my)         my = {};
if(!my.fn)      my.fn = {};

Number.prototype.numberFormat = function(decimals, dec_point, thousands_sep) {
    dec_point = typeof dec_point !== 'undefined' ? dec_point : '.';
    thousands_sep = typeof thousands_sep !== 'undefined' ? thousands_sep : ',';

    var parts = this.toFixed(decimals).split('.');
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, thousands_sep);

    return parts.join(dec_point);
};

// 숫자나 문자 타입이 혼재되는 값일때 숫자 형태로 고정해야 한다면 문자를 숫자로 변경 한다.
// n    : 정수형으로 변경할 값
my.fn.toNumber = function(n) {
    if(!_.isNumber(n)) {
        try { n = parseInt(n); }
        catch(err) {
            console.log(n + ' is not numeric');
            n = 0;
        }
    }

    return n;
};