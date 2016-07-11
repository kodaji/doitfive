/**
 * navigator 를 통하지 않고 content 에서 content를 변경 하는 custom 이벤트 등록
 */
var my;
if(!my)         my = {};

// custom 정의값
// my.data.log              : 로그 출력 여부. true 이면 출력, false 이면 출력 하지 않음
// my.data.select2PageRows  : select2 사용시 한번 호출시 가져오는 row 의 최대 카운트
// my.data.ajaxSuccessCode  : 서버로 api 요청시 ajax 성공 했을때 리턴 코드
// my.data.staticHashURL    : smart admin 의 content 내용을 스스로 변경 시킬때 옵션 값
if(!my.data)    my.data = {log:true, select2PageRows: 30, ajaxSuccessCode: 'S000001',
    sessionTimeInterval: 0, sessionRestTime: 0};

// custom function
if(!my.fn)      my.fn = {};

// console.log override
if(!window.console) {
    window.console.log = function() {};
    window.console.warn = function() {};
    window.console.error = function() {};
}

// 숫자를 포맷에 맞게 변경 한다.
// var foo = 5000;
// console.log(foo.numberFormat(2)); // us format: 5,000.00
// console.log(foo.numberFormat(2, ',', '.')); // european format: 5.000,00
Number.prototype.numberFormat = function(decimals, dec_point, thousands_sep) {
    dec_point = typeof dec_point !== 'undefined' ? dec_point : '.';
    thousands_sep = typeof thousands_sep !== 'undefined' ? thousands_sep : ',';

    var parts = this.toFixed(decimals).split('.');
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, thousands_sep);

    return parts.join(dec_point);
};

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

// smart admin 의 content 내용을 ajax를 통해 스스로 변경 시킬 수 있는 이벤트 추가
// moveURL          : http://localhost/1/admin#/1/admin/app/add 형태로 이루어진 이동할 URL
// staticHashURL    : navigator 에 없는 URL로 이동 하면서 navigator 에 특정 메뉴를 high light 시키고 싶을때 특정 메뉴의 hash 뒤의 URL
$(document).on('changecontent', {
        arg1: ''
    }, function(event, moveURL, staticHashURL){
        if(staticHashURL)   my.data.staticHashURL = staticHashURL;
        else                my.data.staticHashURL = null;

        location.href = moveURL;
    });

// session timeout 이 되면 로그인 페이지로 튕겨버리기 위해서 ajax 요청에 대해서 공통으로 처리하는 로직을 사용
// session timeout 이 발생되면 서버에서는 status 를 901 로 내린다.
$(document).ajaxComplete(function(event, xhr, settings){
    if(xhr.status == 901) {
        $.bigBox({
            title: '사용자 인증 만료',
            content: '사용자 인증이 만료 되었습니다. 2초 후에 로그인 페이지로 자동 이동 합니다.',
            color: '#C46A69',
            icon: 'fa fa-warning shake animated',
            number: '1',
            timeout: 2000
        });

        setTimeout(function(){
            //window.location.href = 'http://'+location.host + location.pathname;
            window.location.replace('http://'+location.host + location.pathname);
        }, 2000);
    }
});

// select2 한글 번역
if($.fn.select2) {
    $.fn.select2.locales['ko'] = {
        "formatNoMatches": function(){return '결과가 없습니다.';},
        "formatAjaxError": function(){return '결과를 불러올 수 없습니다.';},
        "formatInputTooShort":function(a,b){var c=b-a.length;return c+' 글자 더 입력해주세요.';},
        "formatInputTooLong":function(a,b){var c=a.length-b;return c+' 글자 지워주세요.';},
        "formatSelectionTooBig":function(a){return '최대 '+a+'개까지만 선택 가능합니다.';},
        "formatLoadMore":function(){return"불러오는 중\u2026"},
        "formatSearching":function(){return"검색 중\u2026"}
    };
    $.extend($.fn.select2.defaults, $.fn.select2.locales['ko']);
}

// jquery UI datepicker를 한글화 시킨다.
$.datepicker.regional['ko'] = {
    closeText: '닫기',
    prevText: '<i class="fa fa-chevron-left"></i>',
    nextText: '<i class="fa fa-chevron-right"></i>',
    currentText: '오늘',
    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
    dayNames: ['일','월','화','수','목','금','토'],
    dayNamesShort: ['일','월','화','수','목','금','토'],
    dayNamesMin: ['일','월','화','수','목','금','토'],
    weekHeader: 'Wk',
    dateFormat: 'yy-mm-dd',
    firstDay: 0,
    isRTL: false,
    showMonthAfterYear: true,
    yearSuffix: ''};
$.datepicker.setDefaults($.datepicker.regional['ko']);

// 함수를 호출 하면 컨텐츠 페이지를 주어진 다른 페이지로 교체 한다.
// my.fn.pmove 함수 호출로 페이지 전환 이후 문제가 발생 하면 이 함수를 호출시 setTimeout 으로
// 약간의 딜레이를 주자.
//
// message box 출력 -> 앱 삭제 선택 -> 앱 삭제 ajax 호출 -> small message box 출력 -> 페이지 전환
// 이런식으로 자동으로 진행 하니, 이후 message box 다시 등장 할때 message box 가 화면에 나오지를 않는다.
// 페이지 전환을 위해 my.fn.pmove 호출시 setTimeout 으로 300 정도 딜레이를 주고 호출 하니
// 아무런 문제가 없다.
//
// a link 에서 클릭하면 바로 page change trigger 를 쉽게 호출 하기 위해서 만듬.
// move             : move 할 uri. uri 앞에 # 을 붙여 준다.
// nav              : move 하지만 nav 에서 페이지는 그대로 둘 url
my.fn.pmove = function(move, nav) {
    if(nav) $(document).trigger('changecontent', [move, nav]);
    else    $(document).trigger('changecontent', [move]);
};

// 로그를 출력 한다.
// msg      : 출력 할 로그 내용
// level    : 로그 레벨. log, warn, error 를 지원 한다.
my.fn.log = function(msg, level) {
    if(!console) return;

    if(_.isUndefined(level) || _.isNull(level) || _.isNaN(level)) level = 'log';
    else {
        if(!console[level]) level = 'log';
    }

    if(console[level]) console[level](msg);
};

// jQuery validator 에 custom 체크를 추가 한다.
// type     : regexp - regular express validator 추가
my.fn.addValidator = function(type) {
    if(type == 'regexp') {
        jQuery.validator.addMethod(
            'regexp',
            function (value, element, regexp) {
                //var check = false;
                return this.optional(element) || regexp.test(value);
                //return regexp.test(value);
            },
            'Please check your input'
        );
    } else if(type == 'maxbytelength') {
        jQuery.validator.addMethod(
            'maxbytelength',
            function (value, element, maxbytelength) {
                var check = false;
                if (value == null || $.trim(value) == '') check = true;
                else check = my.fn.byteLength(value) < maxbytelength;

                return this.optional(element) || check;
            },
            'Please check your input'
        );
    } else if(type == 'allowemptyemail') {
        jQuery.validator.addMethod(
            'allowemptyemail',
            function (value, element, bool) {
                var check = false;
                if (value == null || $.trim(value) == '') check = true;
                else {
                    check = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/i.test(value);
                }
                if (!bool) check = !check;

                //return this.optional(element) || check;
                return check;
            },
            'Please check your input'
        );
    } else if(type == 'safeword') {
        jQuery.validator.addMethod(
            'safeword',
            function (value, element, safeword) {
                var check = false;

                // empty string 이나 null 이면 실패
                if (value == null || $.trim(value) == '') check = false;
                // 1byte 문자가 아니면 실패
                else check = my.fn.byteLength(value) == value.length;
                // URLEncoding 해서 걸리는 문자가 존재하면 실패
                if (check && value != null && $.trim(value) != '')
                    check = encodeURIComponent(value).length == value.length;

                if (!safeword) check = !check;

                //return this.optional(element) || check;
                return check;
            },
            'Please check your input'
        );
    } else if(type == 'check_password') {
        jQuery.validator.addMethod(
            'check_password',
            function (value, element, check_password) {
                var $compare = $('input[name='+check_password+']');
                if($compare.length <= 0) return false;

                var origPassword = $.trim($compare.val());
                var checkPassword = $.trim(value);

                return origPassword == checkPassword;

                //if(origPassword != checkPassword) return false;
                //return true;
                //return this.optional(element) || check;
            },
            'Please check your input'
        );
    } else {
        console.warn('unknown validator type. type['+type+']');
    }
};

// jQuery Datatable 에서 local storage 로 이전에 사용한 검색값을 보여 주도록 한다.
// 따로 구현 하지 않으면 검색값은 보여 주지 않는 상태에서 이전 상태가 나타나게 된다.
// dtId     : datatable id
my.fn.setDatatableSearchValue = function(dtId) {
    if(!dtId) return;
    var $searchColumn = $('#'+dtId).find('.dt-column');
    if($searchColumn.length <= 0) return;

    // 검색 칼럼이 존재한다면 검색 칼럼에 기존 값을 넣어 준다.
    var savedData = localStorage.getItem('DataTables_' + dtId + '_' + window.location.pathname);
    if(savedData) {
        var jsonData = eval('(' + savedData + ')');

        $searchColumn.each(function(idx) {
            var $this = $(this), classes = ($this.attr('class')).split(' ');
            if(classes.length <= 0) return;

            var colNum = -1;
            _.each(classes, function(cls){
                if(cls.indexOf('dt-column-') < 0) return;
                colNum = cls.replace('dt-column-', '');
            });

            var searchData = $.trim(jsonData.columns[colNum].search.search);
            if(searchData) $this.val(searchData);
        });
    }
};

// 각각의 페이지에서 도움말을 보여 줄지 말지 결정 한다.
// 또한 도움말 닫기 버튼을 눌렀을때 이후에는 보여 주지 않도록 localStorage 에 저장 한다.
// helperId     : 도움말의 id
my.fn.initPageHelper = function(helperId) {
    if(!helperId) return;

    var $helper = $('#'+helperId);
    if($helper.length <= 0) {
        console.warn('not found id [' + helperId +']');
        return;
    }

    var savedData = localStorage.getItem('ckpush_page_helper'), jsonData = {};
    if(savedData) {
        jsonData = eval('(' + savedData + ')');
        if(_.has(jsonData, helperId)) {
            $helper.hide();
            return;
        }
    }

    // 만일 helper 영역이 닫혀 있지 않다면 bind 를 걸어서 추후 열리지 않도록 데이터를 저장 한다.
    $helper.bind('click', function(e){
        if(e.target.tagName.toUpperCase() == 'BUTTON') {
            jsonData[helperId] = 1;
            localStorage.setItem('ckpush_page_helper', JSON.stringify(jsonData));
        }
    });
};

// jquery datatable 의 localStorage 를 삭제 한다.
my.fn.removeDatatableStorage = function(tableId) {
    localStorage.removeItem('DataTables_'+tableId+'_'+window.location.pathname);
};

// ckpush 전용으로 사용하는 데이터를 저장 한다.
my.fn.saveLocalStorageForCk = function(key, value) {
    localStorage.setItem('CKPush_'+key, JSON.stringify(value));
};

// ckpush 전용으로 사용하는 데이터를 읽는다.
my.fn.loadLocalStorageForCk = function(key) {
    var value = localStorage.getItem('CKPush_'+key);
    if(value == null) return null;
    return eval('(' + value + ')');
};

// 컨텐츠 삭제등에서 사용하는 확인창을 띄운다. 사용법은 list_app.ftl 의 앱 삭제를 참고 하자.
// alertTitle       : 확인창의 제목
// alertContent     : 확인창에서 무엇을 확인 하는지 설명
// alertPlaceHolder : 확인창 사용자 입력란의 placeholder
// btnYesName       : 사용자 값 입력 후 작업을 계속 진행 할 버튼 이름
// checkValue       : 작업을 계속 진행 하기 전 확인 할 사용자 입력 값
// process          : 확인창에서 작업 진행을 선택 했을때 실행할 function
// failTitle        : 실패 했을때 toast 의 제목
// failContent      : 실패 했을때 toast 의 본문
my.fn.showUserConfirm = function(alertTitle, alertContent, alertPlaceHolder,
                                 btnYesName, checkValue, process, failTitle, failContent) {
    $.SmartMessageBox({
        title : alertTitle,
        content: alertContent,
        input: 'text',
        inputValue: '',
        placeholder: alertPlaceHolder,
        buttons: '['+btnYesName+'][취소]'
    }, function(_buttonPressed, _value) {
        if(_buttonPressed === btnYesName) {
            if(_value == checkValue) {
                (process)();
            } else {
                $.smallBox({
                    title: failTitle,
                    content : '<i class="fa fa-warning"></i> <i>'+failContent+'</i>',
                    color : "#C46A69",
                    timeout : 2000
                });
            }
        }
    });
};

my.fn.checkValidEmailAddress = function(email, emptyOk) {
    if(email == null || $.trim(email) == '') {
        if(emptyOk) return true;
        return false;
    }

    return /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/i.test(email);
};

// 문자열의 byte length 를 구한다.
// 다음과 같이 사용 하면 된다.
// my.fn.byteLength("안녕하세요");
my.fn.byteLength = function(s, b, i, c) {
    for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
    return b;
};

// 숫자가 아닌것을 모두 삭제하고 숫자로만 구성된 문자열(전화번호로 사용)을 구한다.
// s    : 숫자로만 구성된 것으로 변경할 문자열
my.fn.getPhoneNumber = function(s) {
    if(s == null || s == "") return "";
    return s.replace(/\D/g,"");
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

// 세션 만료 시간 표시를 위해서 주로 사용하며, 초단위 숫자를 시 분 초 스트링으로 변경 한다.
my.fn.showSessionTime = function(tms) {
    my.data.sessionRestTime = tms;

    if(my.data.sessionTimeInterval) {
        clearInterval(my.data.sessionTimeInterval);
        my.data.sessionTimeInterval = 0;
    }

    my.data.sessionTimeInterval = setInterval(my.fn.sessionRestTime, 1000);
};
my.fn.sessionRestTime = function() {
    var tms = my.data.sessionRestTime;

    var ret = '', sec = tms % 60, omin = Math.floor(tms / 60);
    var min = omin % 60, hour = Math.floor(omin / 60);

    if(hour > 0) ret += hour+'시 ';

    if(min > 0) ret += min+'분 ';
    else {
        if(ret != '') ret += '0분 ';
    }

    if(sec > 0) ret += sec+'초';
    else {
        if(ret != '') ret += '0초';
    }

    $('#my-session-end-time').text(ret);
    $('#my-session-end-time2').text('이후 인증 만료 됩니다.');
    my.data.sessionRestTime -= 1;
};

// 게시물 템플릿을 구성 할때 사용하는 전용 함수 이다.
// jquery nestable list 에 dynamic 하게 element를 추가 한다.
// http://dbushell.github.io/Nestable/
my.fn.addDocumentTemplateElement = function($list, name, type, desc, $container, elementKey, elementValue) {
    if(!$container) $container = $($list.children().get(0));
    var badgeBg = '';

    switch (type) {
        // array 인 경우는 나머지와 형태가 다르기 때문에 특별히 취급 한다.
        case 'array':
            $container.append(
                '<li class="dd-item dd3-item" data-'+name+'="'+type+'">' +

                // drag 을 사용한다.
                //'    <div class="dd-handle dd3-handle">Drag</div>' +
                //'    <div class="dd3-content">' +

                // drag 를 사용하지 않는다.
                '    <div class="dd3-content" style="padding-left: 10px;">' +

                '        <span class="label bg-color-blueDark">'+desc+'</span>&nbsp;&nbsp;<span>'+name+'</span>' +
                '        <div class="pull-right">' +
                '            <a class="btn btn-info btn-xs add-nestable-array-element" href="javascript:void(0);">항목 추가</a>' +
                '            <a class="btn btn-danger btn-xs delete-template-element" href="javascript:void(0);">삭제</a>' +
                '        </div>' +
                '    </div>' +
                '    <ol class="dd-list"></ol>' +
                '</li>'
            );
            return;

        // array 요소를 추가. array element의 파싱값은 input 값을 넣고 난 다음 최종 결과에서 변경 한다.
        case 'arrayelement':
            if(elementKey) elementKey = $.trim(elementKey);
            if(elementValue) elementValue = $.trim(elementValue);
            var elementData = elementKey+'|'+elementValue;

            if(!elementKey)     elementKey = '';
            if(!elementValue)   elementValue = '';

            $container.append(
                '<li class="dd-item dd3-item" data-arrayelement="'+elementData+'">' +

                // drag 을 사용한다.
                //'    <div class="dd-handle dd3-handle">Drag</div>' +
                //'    <div class="dd3-content">' +

                // drag 를 사용하지 않는다.
                '    <div class="dd3-content" style="padding-left: 10px;">' +

                '        <div class="row" style="height: 20px;">' +
                '            <div class="col-xs-5">' +
                '                <input type="text" class="form-control input-template-array-element-key input-template-array-element" value="'+elementKey+'" placeholder="항목값을 입력하세요." style="height: 22px;" />' +
                '            </div>' +
                '            <div class="col-xs-5">' +
                '                <input type="text" class="form-control input-template-array-element-desc input-template-array-element" value="'+elementValue+'" placeholder="항목 설명을 입력하세요." style="height: 22px;" />' +
                '            </div>' +
                '            <div class="col-xs-2">' +
                '                <div class="pull-right">' +
                '                    <a class="btn btn-danger btn-xs delete-template-element" href="javascript:void(0);">삭제</a>' +
                '                </div>' +
                '            </div>' +
                '        </div>' +
                '    </div>' +
                '</li>'
            );
            return;

        case 'date':
            badgeBg = 'bg-color-greenDark';
            break;

        case 'time':
            badgeBg = 'bg-color-green';
            break;

        case 'datetime':
            badgeBg = 'bg-color-greenLight';
            break;

        case 'text':
            badgeBg = 'bg-color-purple';
            break;

        case 'textarea':
            badgeBg = 'bg-color-orangeDark';
            break;
    }

    $container.append(
        '<li class="dd-item dd3-item" data-'+name+'="'+type+'">' +

        // drag 을 사용한다.
        //'    <div class="dd-handle dd3-handle">Drag</div>' +
        //'    <div class="dd3-content">' +

        // drag 를 사용하지 않는다.
        '    <div class="dd3-content" style="padding-left: 10px;">' +

        '        <span class="label '+badgeBg+'">'+desc+'</span>&nbsp;&nbsp;<span>'+name+'</span>' +
        '        <div class="pull-right">' +
        '            <a class="btn btn-danger btn-xs delete-template-element" href="javascript:void(0);">삭제</a>' +
        '        </div>' +
        '    </div>' +
        '</li>'
    );

    $list.nestable('reset');
};

my.fn.loadDocumentTemplateElement = function($list, data) {
    _.map(data, function(element, key){
        var desc = '';
        if(_.isArray(element)) {
            desc = '배열';
            my.fn.addDocumentTemplateElement($list, key, 'array', desc);
            var $arrayParent = $($($list.find('[data-'+key+'="array"]').get(0)).children('ol').get(0));

            _.each(element, function(arrelement){
                if(_.size(arrelement) != 1) return;
                var key = _.keys(arrelement)[0],
                    val = _.values(arrelement)[0];
                my.fn.addDocumentTemplateElement($list, null, 'arrayelement', null, $arrayParent, key, val);
            });
        } else {
            if(element == 'date') desc = '날짜';
            else if(element == 'text') desc = '문자열';
            else if(element == 'textarea') desc = '문자영역';

            my.fn.addDocumentTemplateElement($list, key, element, desc);
        }
    });
};

// 게시물 템플릿 구성을 변경 할때 사용되는 전용 함수 이다.
// my.fn.addDocumentTemplateElement 가 사용되면 이 함수는 무조건 같이 사용되어야 한다.
// 등록된 이벤트 처리가 완료되고 나면 cb 를 호출 한다.
// cb 는 다음 파라미터를 가진다.
//  - parameter1 : event 종류. 현재는 삭제에만 cb가 필요하기 때문에 'remove' 하나만 정의 되어 있다.
my.fn.setDocumentTemplateListListner = function(cb) {
    // array 항목 추가
    $(document).on('click', '.add-nestable-array-element', function(e){
        if(!e.target || e.target.tagName != 'A') {
            console.warn('invalid detected template array element add button');
            return;
        }

        // array 항목이 들어갈 위치를 찾는다.
        var $grandParent = $(e.target).parents('.dd3-content');
        if($grandParent.length <= 0) {
            console.warn('not found grand parent for appending template array element');
            return;
        }

        var $arrayParent = $grandParent.next();
        if($arrayParent.length <= 0) {
            console.warn('not found append target for appending template array element');
            return;
        }

        // nestable list에 포함된 array에 array 항목을 추가 한다.
        var $templateStruct = $($grandParent.parents('.dd').get(0));

        my.fn.addDocumentTemplateElement($templateStruct, null, 'arrayelement', null, $arrayParent);
    });

    // array 항목 input box 포커스 잃었을때 값 설정
    // focusout 이 없을 수 있으므로 keyup 도 같이 걸어 준다.
    $(document).on('focusout', '.input-template-array-element', function(e){
        if(!e.target || e.target.tagName != 'INPUT') {
            console.warn('invalid detected template array element input');
            return;
        }

        var $target = $(e.target),
            $element = $($target.parents('.dd-item').get(0)),
            //dataValue = $element.attr('data-arrayelement'),
            aKey = '', aDesc = '';

        if($target.hasClass('input-template-array-element-key')) {
            aKey = $.trim($target.val());
            aDesc = $($target.parent().next().children().get(0)).val();
        } else {
            aDesc = $.trim($target.val());
            aKey = $($target.parent().prev().children().get(0)).val();
        }

        $element.attr('data-arrayelement', aKey + '|' + aDesc);

        //var $templateStruct = $($element.parents('.dd').get(0));
        //$templateStruct.nestable('reset');

    });

    $(document).on('keyup', '.input-template-array-element', function(e){
        if(!e.target || e.target.tagName != 'INPUT') {
            console.warn('invalid detected template array element input');
            return;
        }

        var $target = $(e.target),
            $element = $($target.parents('.dd-item').get(0)),
            //dataValue = $element.attr('data-arrayelement'),
            aKey = '', aDesc = '';

        if($target.hasClass('input-template-array-element-key')) {
            aKey = $.trim($target.val());
            aDesc = $($target.parent().next().children().get(0)).val();
        } else {
            aDesc = $.trim($target.val());
            aKey = $($target.parent().prev().children().get(0)).val();
        }

        $element.attr('data-arrayelement', aKey + '|' + aDesc);

        //var $templateStruct = $($element.parents('.dd').get(0));
        //$templateStruct.nestable('reset');
    });

    // 템플릿 구성 요소를 삭제 한다.
    $(document).on('click', '.delete-template-element', function(e){
        e.preventDefault();
        e.stopPropagation();

        if(!e.target || e.target.tagName != 'A') {
            console.warn('invalid detected template array element delete button');
            return;
        }

        var $elements = $(e.target).parents('li');
        if($elements.length <= 0) {
            console.warn('not found target for deleting template element');
            return;
        }

        var $element = $($elements.get(0));
        $element.remove();

        // nestable list를 refresh 한다.
        var $templateStruct = $($element.parents('.dd').get(0));
        $templateStruct.nestable('reset');
        if(cb) (cb)('remove');
    });
};

// 게시물 템플릿 구성에 중복되는 요소 변수가 존재하는지 체크 한다.
// 중복되면 true, 중복 되지 않으면 false 를 리턴한다.
my.fn.checkDocumentTemplateDuplicateKey = function($list, key) {
    var keys = [];
    var templateData = $list.nestable('serialize');

    if(templateData.length <= 0) {
        console.warn('[1] empty nestable list. can\'t serialize nestable list');
        return false;
    }

    for(var i=0 ; i<templateData.length ; i++) {
        var element = templateData[i];
        for(var prop in element) {
            if(prop.toLowerCase() != 'children') keys.push(prop);
        }
    }

    if(keys.length <= 0) return false;
    return _.indexOf(keys, key) != -1;
};

// 게시물 템플릿 구성값을 구한다.
// 템플릿 구성이 담겨 있는 object 를 리턴한다.
my.fn.setDocumentTemplateJsonData = function($list) {
    var template = {};
    var templateData = $list.nestable('serialize');

    if(templateData.length <= 0) {
        console.warn('[2] empty nestable list. can\'t serialize nestable list');
        return template;
    }

    for(var i=0 ; i<templateData.length ; i++) {
        var element = templateData[i],
            _type = null,
            _name = null,
            _children = null;

        for(var prop in element) {
            if(prop.toLowerCase() == 'children') {
                _children = element[prop];
            } else {
                _name = prop;
                _type = element[prop];
            }
        }

        if(!_type) {
            console.warn('not found template element type. ignore this element.');
            continue;
        }

        switch (_type.toLowerCase()) {
            case 'array':
                if(!_children || _children.length <= 0) {
                    console.warn('array type detected. but, not found array element.');
                    continue;
                }
                template[_name] = [];
                for(var j=0 ; j<_children.length ; j++) {
                    var arrayElement = _children[j];
                    for(var prop in arrayElement) {
                        var subKeyDesc = $.trim(arrayElement[prop]);
                        if(!subKeyDesc) {
                            console.log('invalid key and description of array element. [' + subKeyDesc + ']');
                            continue;
                        }

                        var arrKeyDesc = subKeyDesc.split('|');
                        if(arrKeyDesc.length != 2) {
                            console.log('invalid key and description. [' + subKeyDesc + ']');
                            continue;
                        }

                        var subKey = $.trim(arrKeyDesc[0]), subDesc = $.trim(arrKeyDesc[1]);
                        if(!subKey || subKey == 'null' || subKey == 'undefined') {
                            console.log('invalid array element key. key is null or empty string. key [' + subKey + ']');
                            continue;
                        }

                        var pushElement = {};
                        pushElement[subKey] = subDesc;
                        template[_name].push(pushElement);
                        break;
                    }
                }

                if(template[_name].length <= 0) delete template[_name];
                break;

            case 'date':
            case 'time':
            case 'datetime':
            case 'text':
            case 'textarea':
                template[_name] = _type;
                break;

            default:
                console.warn('unknown template element type [' + _type + ']. ignore it');
                break;
        }
    }

    return template;
};

// 게시물의 템플릿을 선택하면 템플릿 입력영역을 바꿔 준다.
// $templateArea        : 템플릿이 들어갈 dom 영역
// formData             : template 형태 데이터
// templateSrl          : template 의 template_srl. 게시물 수정시 사용
// documentTemplateSrl  : 게시물 수정시 게시물이 사용하는 template_srl. 게시물 수정시 사용
// documentTemplate     : 게시물 수정시 게시물에 설정되어 있는 template 내용. 게시물 수정시 사용
my.fn.showTemplateForm = function($templateArea, formData, templateSrl,
        documentTemplateSrl, documentTemplate) {
    $templateArea.empty();

    if(!formData || _.size(formData) <= 0) {
        console.warn('no template data');
        return;
    }

    var isInit = false;
    if(!_.isUndefined(templateSrl) && !_.isUndefined(documentTemplateSrl) && !_.isUndefined(documentTemplate) &&
            templateSrl > 0 && documentTemplateSrl > 0 && _.isObject(documentTemplate)) {
        if(templateSrl == documentTemplateSrl) isInit = true;
    }

    _.map(formData, function(value, key){
        var element = '', datePicker = '', timePicker = '', dateTimePicker = '', keyValue = '';

                switch(value) {
            case 'text':
                if(isInit) {
                    keyValue = documentTemplate[key];
                    keyValue = my.fn.showHTMLTag(decodeURIComponent(keyValue));
                }
                element += '<div class="col-sm-6"><div class="form-group"><label>'+key+'</label>'+
                    '<input class="form-control" id="tpl-'+key+'" placeholder="'+key+'값을 입력하세요" value="'+keyValue+'" type="text" maxlength="256">'+
                    '</div></div>';
                break;

            case 'textarea':
                if(isInit) {
                    keyValue = documentTemplate[key];
                    keyValue = my.fn.showHTMLTag(decodeURIComponent(keyValue));
                }
                element += '<div class="col-sm-12"><div class="form-group"><label>'+key+'</label>'+
                           '<textarea id="tpl-'+key+'" class="form-control" placeholder="'+key+'값을 입력하세요" rows="3">'+keyValue+'</textarea>'+
                           '</div></div>';
                break;

            case 'date':
                if(isInit) {
                    keyValue = documentTemplate[key];
                    keyValue = (new Date(keyValue)).format('yyyy-MM-dd');
                }
                element += '<div class="col-sm-6"><div class="form-group"><label>'+key+'</label><div class="input-group">'+
                           '<input type="text" id="tpl-'+key+'" placeholder="'+key+'를 위한 날짜를 입력하세요" value="'+keyValue+'" class="form-control datepicker" data-dateformat="yy-mm-dd">'+
                           '<span class="input-group-addon"><i class="fa fa-calendar"></i></span></div></div></div>';
                datePicker = 'tpl-'+key;
                break;

            case 'time':
                if(isInit) {
                    keyValue = documentTemplate[key];
                    keyValue = decodeURIComponent(keyValue);
                }
                element += '<div class="col-sm-6"><div class="form-group"><label>'+key+'</label><div class="input-group">'+
                           '<input class="form-control" id="tpl-'+key+'" type="text" value="'+keyValue+'" placeholder="'+key+'를 위한 시간을 입력하세요" data-autoclose="true">'+
                           '<span class="input-group-addon"><i class="fa fa-clock-o"></i></span></div></div></div>';
                timePicker = 'tpl-'+key;
                break;

            case 'datetime':
                if(isInit) {
                    keyValue = documentTemplate[key];
                    keyValue = (new Date(keyValue)).format('yyyy-MM-dd HH:mm');
                }
                element += '<div class="col-sm-6"><div class="form-group"><label>'+key+'</label><div class="input-group">'+
                           '<input type="text" class="form-control" id="tpl-'+key+'" value="'+keyValue+'" placeholder="'+key+'를 위한 날짜/시간을 입력하세요" >'+
                           '<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span></div></div></div>';
                dateTimePicker = 'tpl-'+key;
                break;

            default:
                if(_.isArray(value)) {
                    if(isInit) {
                        keyValue = documentTemplate[key];
                    }
                    element += '<div class="col-sm-6"><div class="form-group"><label class="control-label">'+key+'</label>'+
                               '<div class="row smart-form"><label class="select"><select style="padding-left:10px;" id="tpl-'+key+'">';
                    for(var i=0 ; i<value.length ; i++) {
                        var obj = value[i];
                        _.map(obj, function(objValue, objKey){
                            if(keyValue == objKey)  element += '<option value="'+objKey+'" selected>'+objValue+'</option>';
                            else                    element += '<option value="'+objKey+'">'+objValue+'</option>';
                        });
                    }
                    element += '</select> <i></i></label></div></div></div>';
                }
                break;
        }

        if(element && element.length > 0) {
            $templateArea.append(element);

            // datepicker가 존재하면 datepicker를 활성화 시킨다.
            if(datePicker && datePicker != '') $('#'+datePicker).datepicker();

            // clockpicker가 존재하면 clockpicker를 활성화 시킨다.
            if(timePicker && timePicker != '') $('#'+timePicker).clockpicker({placement:'top', donetext:'Done'});

            // datetimepicker가 존재하면 datetimepicker를 활성화 시킨다.
            if(dateTimePicker && dateTimePicker != '') $('#'+dateTimePicker).datetimepicker({
                format: 'YYYY-MM-DD HH:mm',
                locale: 'ko'
            });
        }

    });
};

// 사용자가 입력한 템플릿 데이터를 구한다. 게시물 작성/수정에서 사용한다.
// 분석된 사용자 입력값은 output 으로 전달 된다.
my.fn.getTemplateUsingData = function(templateStruct, output) {
    if(!templateStruct) {
        console.warn('invalid template struct');
        return;
    }

    _.map(templateStruct, function(value, key){
        switch (value) {
            // encoding 해서 넣는다. 값이 없으면 empty string 으로 설정 된다.
            // 만일 time 이면 hh:mm 으로 저장된다.
            case 'time':
            case 'text':
            case 'textarea':
                output[key] = encodeURIComponent($('#tpl-'+key).val());
                break;

            // millisecond 로 넣는다. 값이 없으면 0 으로 설정 된다.
            case 'date':
                var str = $('#tpl-'+key).val();
                if(str && $.trim(str) != '') {
                    var arr = str.split('-');
                    if(arr.length != 3) {
                        console.warn('wrong date format. date [' + str + ']');
                        output[key] = 0;
                    } else {
                        var date = new Date(arr[0], arr[1]-1, arr[2]);
                        output[key] = date.getTime();
                    }
                } else {
                    output[key] = 0;
                }
                break;

            // millisecond 로 넣는다. 값이 없으면 0 으로 설정 된다.
            case 'datetime':
                var str = $('#tpl-'+key).val();
                if(str && $.trim(str) != '') {
                    var arrZero = str.split(' ');
                    if(arrZero.length != 2) {
                        console.warn('wrong datetime format. datetime [' + str + ']');
                        output[key] = 0;
                    } else {
                        var arrDate = (arrZero[0]).split('-'),
                            arrTime = (arrZero[1]).split(':');
                        if(arrDate.length != 3 || arrTime.length != 2) {
                            console.warn('wrong datetime format. datetime [' + str + ']');
                            output[key] = 0;
                        } else {
                            var datetime = new Date(arrDate[0], arrDate[1]-1, arrDate[2], arrTime[0], arrTime[1]);
                            output[key] = datetime.getTime();
                        }
                    }
                } else {
                    output[key] = 0;
                }
                break;

            default :
                if(_.isArray(value)) {
                    output[key] = encodeURIComponent($('#tpl-'+key).val());
                }
                break;
        }
    });
};



// 초간단 data table을 만든다. manage_board.ftl 에서 사용 하니 사용법 보고 파라미터 참고 하면 된다.
// tableData는 다음 항목을 가진다.
//  - tableId : 테이블의 dom id
//  - responsiveHelper : responsible object. 최초는 undefined로 주면 된다.
//  - useCheck : row 제일 처음에 checkbox 를 사용할지 여부
//  - itemClickAction : row 의 detail view link 를 클릭 했을때 동작할 임의의 action. 만일 null 이라면 default action 으로 동작한다.
//                      default action 은 화면에 detail link 로 보여 주는 것.
//  - breakpointDefinition : responsible 화면 크기값
//  - url : ajax url
//  - iDisplayLength : 리스트의 default row count
//  - aLengthMenu : row count array
//  - pagingType : pagination 의 형태. simple, simple_numbers, full, full_numbers 중 하나.
//  - defaultOrder : 테이블의 기본 order
//  - columns : 테이블에 보여지는 칼럼
my.fn.createVerySimleDataTable = function(tableData) {
    var obj = {
        sDom: "<'dt-toolbar'<'col-xs-12 col-sm-11'f><'font-sm txt-color-greenLight col-sm-1 col-xs-12 hidden-xs'r>>" +
        "t" +
        "<'dt-toolbar-footer'<'col-sm-4 col-xs-12'l><'col-xs-12 col-sm-8'p>>",
        autoWidth: true,
        preDrawCallback: function() {
            if (!tableData.responsiveHelper) {
                tableData.responsiveHelper = new ResponsiveDatatablesHelper($('#'+tableData.tableId),
                    tableData.breakpointDefinition);
            }
        },
        rowCallback: function(nRow) {
            tableData.responsiveHelper.createExpandIcon(nRow);
        },
        drawCallback: function(oSettings) {
            tableData.responsiveHelper.respond();
        },
        processing: true,
        serverSide: true,
        ajax: {
            url: tableData.url + $.now(),
            type: 'POST'
        },
        bStateSave: true,
        iDisplayStart: 0,
        iDisplayLength: 5,
        aLengthMenu: [5, 10, 25],
        pagingType: 'full',
        language: {
            paginate: {
                first: '<i class="fa fa-angle-double-left"></i>',
                last: '<i class="fa fa-angle-double-right"></i>',
                next: '<i class="fa fa-angle-right"></i>',
                previous : '<i class="fa fa-angle-left"></i>'
            },
            zeroRecords: '데이터 없음',
            emptyTable: '데이터 없음',
            info: '_START_ - _END_ (_TOTAL_/_MAX_)',
            infoFiltered : '',
            infoEmpty: '0 - 0 (0/0)',
            //processing: '로딩중',
            processing: '<i class="fa fa-spinner fa-spin"></i>',
            loadingRecords: '<i class="fa fa-spinner fa-spin"></i>'
        },
        aaSorting: tableData.defaultOrder,
        aoColumns: tableData.columns
    };

    if(tableData.iDisplayLength)    obj.iDisplayLength = tableData.iDisplayLength;
    if(tableData.aLengthMenu)       obj.aLengthMenu = tableData.aLengthMenu;
    if(tableData.pagingType)        obj.pagingType = tableData.pagingType;

    $('#'+tableData.tableId).DataTable(obj);

    if(tableData.useCheck) {
        // 컨텐츠 디테일 뷰 링크를 누르면 row 선택하지 않고 디테일 뷰 화면으로 이동 변경 된다
        //$('#' + tableData.tableId + ' tbody').off('click').on('click', '.datatable-row-detail-view', function (e) {
        $('#' + tableData.tableId + ' tbody').off('click').on('click', function (e) {
            var tagName = (e.target.tagName).toUpperCase();
            if(tagName != 'INPUT' || ($(e.target).attr('type')).toUpperCase() != 'CHECKBOX') {
                e.preventDefault();
                e.stopPropagation();
            }

            if(tagName == 'A') {
                if (tableData.itemClickAction) {
                    (tableData.itemClickAction)(e);
                } else {
                    var $this = $(this), move = $this.data('move'), nav = $this.data('nav');
                    if (move)    my.fn.pmove(move, nav);
                    else        console.log('not found moving url');
                }
            } else {
                var $this = $(e.target).parents('tr');
                var selected = $this.hasClass('selected');

                // row 선택을 토글 시키고, checkbox 를 on/off 시킨다.
                $this.toggleClass('selected');

                $this.find('.check-row-data').each(function () {
                    var $checkbox = $(this);
                    if (selected)   $checkbox.prop('checked', false);
                    else            $checkbox.prop('checked', true);
                });
            }
        });

        $('#' + tableData.tableId + ' thead th input[type=checkbox]').off('change').on('change', function (e) {
            e.preventDefault();
            e.stopPropagation();

            if ($(this).is(':checked')) {
                $('#' + tableData.tableId + ' tbody tr td label input.check-row-data').prop('checked', true);
                $('#' + tableData.tableId + ' tbody tr').addClass('selected');
            } else {
                $('#' + tableData.tableId + ' tbody tr td label input.check-row-data').prop('checked', false);
                $('#' + tableData.tableId + ' tbody tr').removeClass('selected');
            }
        });
    }
};

// 게시물에 등록된 첨부 파일을 게시물 추가/수정 화면에 추가 한다.
// 첨부파일 삭제는 해당 함수를 사용하는 곳에서 .delete-document-attach 를 캐치 해서 처리 하도록 한다.
// obj 은 다음 항목을 가진다.
//  - file_srl  : 파일 시리얼 넘버
//  - file_url  : 미리 보기 url
//  - orig_name : 파일의 원본 이름
//  - file_size : 파일 사이즈
//  - width     : 이미지 미리보기 너비
//  - height    : 이미지 미리보기 높이
my.fn.addDocumentAttachToDocument = function($container, obj, isImage, canEdit) {
    var element = '<li data-file-srl="'+obj.file_srl+'"><div class="well well-sm" style="text-overflow: ellipsis;overflow: hidden;white-space: nowrap;"><span>';

    if(isImage) element += '<img src="'+obj.file_url+'?w='+obj.width+'&h='+obj.height+'">';
    else        element += '<i class="fa fa-file"></i>';

    element += '</span><br><strong>'+obj.orig_name+'</strong><br>'+obj.file_size+'<br>';

    // TODO 일단 신규, 수정 동일하게 해 두자. 추후 수정하는 것을 변경 하도록 한다.
    //if(canEdit) element += '<a href="javascript:void(0);" class="delete-document-attach"> 삭제</a>  | <a href="javascript:void(0);"> 수정</a>';
    if(canEdit) element += '<a href="javascript:void(0);" class="delete-document-attach"> 삭제</a>  | <a href="'+obj.file_url+'" target="_blank"> 보기</a>';
    else        element += '<a href="javascript:void(0);" class="delete-document-attach"> 삭제</a>  | <a href="'+obj.file_url+'" target="_blank"> 보기</a>';

    element += '</div></li>';

    $container.append(element);
};
my.fn.addDocumentAttachToDocument_plymind = function($container, obj, isImage, canEdit) {
    var element = '<li data-file-srl="'+obj.file_srl+'"><div class="well well-sm" style="text-overflow: ellipsis;overflow: hidden;white-space: nowrap;"><span>';

    if(isImage) element += '<img src="'+obj.file_image_url+'?w='+obj.width+'&h='+obj.height+'">';
    else        element += '<i class="fa fa-file"></i>';

    //element += '</span><br><strong>'+obj.orig_name+'</strong><br>'+obj.file_size+'<br>';
    element += '</span><br><strong>'+obj.orig_name+'</strong><br>';

    // TODO 일단 신규, 수정 동일하게 해 두자. 추후 수정하는 것을 변경 하도록 한다.
    //if(canEdit) element += '<a href="javascript:void(0);" class="delete-document-attach"> 삭제</a>  | <a href="javascript:void(0);"> 수정</a>';
    if(canEdit) {
        element += '<a href="javascript:void(0);" class="delete-document-attach"> 삭제</a>  | <a href="'+obj.file_url+'" target="_blank"> 다운로드</a>';
    }
    else        {
        element += '<a href="'+obj.file_url+'" target="_blank"> 다운로드</a>';
    }


    element += '</div></li>';

    $container.append(element);
};

// html 태그를 그대로 보여 주기 위해서 <, >, &, dobule quoto 를 변경 한다.
my.fn.showHTMLTag = function(str) {
    return str.replace(/&/gi, '&amp;')
              .replace(/"/gi, '&quot;')
              .replace(/</gi, '&lt;')
              .replace(/>/gi, '&gt;');
};





/*
//var myevent = document.createEvent('Event');

//event.initEvent('dhkim', true, true);

document.addEventListener('dhkim', function(e){
    console.log('----->occur dhkim event');
    var container = $("#content");

    console.log(container);

    //loadURL('#/1/test/3', container);

//    window.location.href.replace

    location.href = 'http://localhost:8080/1/admin#/1/test/2';
    //window.location.href.replace = 'http://localhost:8080/1/admin#/1/test/3';

    $('#ddd').addClass('active');

    //console.log("window.location.search=["+window.location.search+"]");
    //console.log("window.location.hash=["+window.location.hash+"]");

    console.log(location.href);

// 이게 핵심이네....후...
//    $(window).on("hashchange", function() {
//        checkURL()

// checkURL 은 nav 의 active 때문에 custom 으로 만들어야 한다.


}, false);


*/



// 슈퍼바이저 게시물의 템플릿을 선택하면 템플릿 입력영역을 바꿔 준다.
// $templateArea        : 템플릿이 들어갈 dom 영역
// formData             : template 형태 데이터
// templateSrl          : template 의 template_srl. 게시물 수정시 사용
// documentTemplateSrl  : 게시물 수정시 게시물이 사용하는 template_srl. 게시물 수정시 사용
// documentTemplate     : 게시물 수정시 게시물에 설정되어 있는 template 내용. 게시물 수정시 사용
my.fn.showSupervisorTemplateForm = function($templateArea, formData, templateSrl,
                                  documentTemplateSrl, documentTemplate) {
    $templateArea.empty();

    if(!formData || _.size(formData) <= 0) {
        console.warn('no template data');
        return;
    }

    var isInit = false;
    if(!_.isUndefined(templateSrl) && !_.isUndefined(documentTemplateSrl) && !_.isUndefined(documentTemplate) &&
        templateSrl > 0 && documentTemplateSrl > 0 && _.isObject(documentTemplate)) {
        if(templateSrl == documentTemplateSrl) isInit = true;
    }

    _.map(formData, function(value, key){
        var element = '', datePicker = '', timePicker = '', dateTimePicker = '', keyValue = '', keyTitle = '';

        switch(key) {
            case 'work':
                keyTitle = '활동영역(자격증번호)';
                break;
            case 'office':
                keyTitle = '근무처(직위)';
                break;
            case 'send':
                keyTitle = '전송 시간';
                break;
        }
        switch(value) {
            case 'text':
                if(isInit) {
                    keyValue = documentTemplate[key];
                    keyValue = my.fn.showHTMLTag(decodeURIComponent(keyValue));
                }
                element += '<div class="col-sm-6"><div class="form-group"><label>'+keyTitle+'</label>'+
                    '<input class="form-control" id="tpl-'+key+'" placeholder="'+keyTitle+'값을 입력하세요" value="'+keyValue+'" type="text" maxlength="256">'+
                    '</div></div>';
                break;

            case 'textarea':
                if(isInit) {
                    keyValue = documentTemplate[key];
                    keyValue = my.fn.showHTMLTag(decodeURIComponent(keyValue));
                }
                element += '<div class="col-sm-12"><div class="form-group"><label>'+key+'</label>'+
                    '<textarea id="tpl-'+key+'" class="form-control" placeholder="'+key+'값을 입력하세요" rows="3">'+keyValue+'</textarea>'+
                    '</div></div>';
                break;

            case 'date':
                if(isInit) {
                    keyValue = documentTemplate[key];
                    keyValue = (new Date(keyValue)).format('yyyy-MM-dd');
                }
                element += '<div class="col-sm-6"><div class="form-group"><label>'+key+'</label><div class="input-group">'+
                    '<input type="text" id="tpl-'+key+'" placeholder="'+key+'를 위한 날짜를 입력하세요" value="'+keyValue+'" class="form-control datepicker" data-dateformat="yy-mm-dd">'+
                    '<span class="input-group-addon"><i class="fa fa-calendar"></i></span></div></div></div>';
                datePicker = 'tpl-'+key;
                break;

            case 'time':
                if(isInit) {
                    keyValue = documentTemplate[key];
                    keyValue = decodeURIComponent(keyValue);
                }
                element += '<div class="col-sm-6"><div class="form-group"><label>'+key+'</label><div class="input-group">'+
                    '<input class="form-control" id="tpl-'+key+'" type="text" value="'+keyValue+'" placeholder="'+key+'를 위한 시간을 입력하세요" data-autoclose="true">'+
                    '<span class="input-group-addon"><i class="fa fa-clock-o"></i></span></div></div></div>';
                timePicker = 'tpl-'+key;
                break;

            case 'datetime':
                if(isInit) {
                    keyValue = documentTemplate[key];
                    keyValue = (new Date(keyValue)).format('yyyy-MM-dd HH');
                }
                element += '<div class="col-sm-6"><div class="form-group"><label>'+keyTitle+'</label><div class="input-group">'+
                    '<input type="text" class="form-control" id="tpl-'+key+'" value="'+keyValue+'" placeholder="'+keyTitle+'를 위한 날짜/시간을 입력하세요" >'+
                    '<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span></div></div></div>';
                dateTimePicker = 'tpl-'+key;
                break;

            default:
                if(_.isArray(value)) {
                    if(isInit) {
                        keyValue = documentTemplate[key];
                    }
                    element += '<div class="col-sm-6"><div class="form-group"><label class="control-label">'+key+'</label>'+
                        '<div class="row smart-form"><label class="select"><select style="padding-left:10px;" id="tpl-'+key+'">';
                    for(var i=0 ; i<value.length ; i++) {
                        var obj = value[i];
                        _.map(obj, function(objValue, objKey){
                            if(keyValue == objKey)  element += '<option value="'+objKey+'" selected>'+objValue+'</option>';
                            else                    element += '<option value="'+objKey+'">'+objValue+'</option>';
                        });
                    }
                    element += '</select> <i></i></label></div></div></div>';
                }
                break;
        }

        if(element && element.length > 0) {
            $templateArea.append(element);

            // datepicker가 존재하면 datepicker를 활성화 시킨다.
            if(datePicker && datePicker != '') $('#'+datePicker).datepicker();

            // clockpicker가 존재하면 clockpicker를 활성화 시킨다.
            if(timePicker && timePicker != '') $('#'+timePicker).clockpicker({placement:'top', donetext:'Done'});

            // datetimepicker가 존재하면 datetimepicker를 활성화 시킨다.
            if(dateTimePicker && dateTimePicker != '') $('#'+dateTimePicker).datetimepicker({
                format: 'YYYY-MM-DD HH',
                locale: 'ko'
            });
        }

    });
};



// 플리마인드용
// 사용자가 입력한 템플릿 데이터를 구한다. 게시물 작성/수정에서 사용한다.
// 분석된 사용자 입력값은 output 으로 전달 된다.
my.fn.getPlymindTemplateUsingData = function(templateStruct, output) {
    if(!templateStruct) {
        console.warn('invalid template struct');
        return;
    }

    _.map(templateStruct, function(value, key){
        switch (value) {
            // encoding 해서 넣는다. 값이 없으면 empty string 으로 설정 된다.
            // 만일 time 이면 hh:mm 으로 저장된다.
            case 'time':
            case 'text':
            case 'textarea':
                output[key] = encodeURIComponent($('#tpl-'+key).val());
                break;

            // millisecond 로 넣는다. 값이 없으면 0 으로 설정 된다.
            case 'date':
                var str = $('#tpl-'+key).val();
                if(str && $.trim(str) != '') {
                    var arr = str.split('-');
                    if(arr.length != 3) {
                        console.warn('wrong date format. date [' + str + ']');
                        output[key] = 0;
                    } else {
                        var date = new Date(arr[0], arr[1]-1, arr[2]);
                        output[key] = date.getTime();
                    }
                } else {
                    output[key] = 0;
                }
                break;

            // millisecond 로 넣는다. 값이 없으면 0 으로 설정 된다.
            case 'datetime':
                var str = $('#tpl-'+key).val();
                if(str && $.trim(str) != '') {
                    var arrZero = str.split(' ');
                    if(arrZero.length != 2) {
                        console.warn('wrong datetime format. datetime [' + str + ']');
                        output[key] = 0;
                    } else {
                        var arrDate = (arrZero[0]).split('-'),
                            arrTime = (arrZero[1]).split(':');
                        if(arrDate.length != 3 || arrTime.length != 1) {
                            console.warn('wrong datetime format. datetime [' + str + ']');
                            output[key] = 0;
                        } else {
                            //var datetime = new Date(arrDate[0], arrDate[1]-1, arrDate[2], arrTime[0], arrTime[1]);
                            var datetime = new Date(arrDate[0], arrDate[1]-1, arrDate[2], arrTime[0]);
                            output[key] = datetime.getTime();

                            //console.log(datetime.getYear()+"년 "+datetime.getMonth()+"월 "+datetime.getDay()+"일 " + datetime.getHours() + "시 " + datetime.getMinutes()+"분 " + datetime.getSeconds()+"초 " )
                            console.log("arrZero = " + arrZero[0] + " / " +arrZero[1]);

                            console.log("arrDate length = " + arrDate.length);

                            console.log("arrTime length = " + arrTime.length);

                            console.log("시간 = "+arrDate[0]+" / " + arrDate[1]-1 +" / " +  arrDate[2] +" / " +  arrTime[0] +" / " +  arrTime[1]);

                            console.log(output);


                        }
                    }
                } else {
                    output[key] = 0;
                }
                break;

            default :
                if(_.isArray(value)) {
                    output[key] = encodeURIComponent($('#tpl-'+key).val());
                }
                break;
        }
    });
};



