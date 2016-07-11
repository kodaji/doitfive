/**
 * 현재 파일을 import 하기 전에 다음의 것들을 미리 import 시켜 두어야 한다.
 * 1. jquery
 * 2. underscore
 * 3. socket.io.js
 * 4. my.js
 * 5. ras-config.js
 * 6. ras-model.js
 * 7. smart admin
 */
// 1. CKPush RAS disconnect
$(document).on(my.ras.config.evt_ras_disconnect, function(){
    if(my.ras.config.debug_log) console.log('disconnect to ckpush ras');

    //$('#ras-connection-status')
    //    .removeClass('fa-spinner')
    //    .removeClass('fa-spin')
    //    .removeClass('fa-signal')
    //    .addClass('fa-ban');

    // 연결 종료는 인증 실패에서 보여 준다.
    //$.smallBox({
    //    title : '시스템',
    //    content : '<i class="fa fa-warning"></i> <i>CKPush RAS 연결 실패 하였습니다. 관리자에게 문의 하세요.</i>',
    //    color : '#C46A69'
    //});
});


// 2. CKPush RAS retry connect
$(document).on(my.ras.config.evt_ras_connect_retry, function(){
    if(my.ras.config.debug_log) console.log('retry connection to ckpush ras');

    $('#ras-connection-status')
        .removeClass('fa-ban')
        .addClass('fa-spinner')
        .addClass('fa-spin');
});


// 3. CKPush RAS 에 접근
$(document).on(my.ras.config.evt_auth_start, function(){
    if(my.ras.config.debug_log) console.log('try authorization to ckpush ras');
});


// 4. CKPush RAS에 연결 실패하면 실패 알림창을 보여 준다.
$(document).on(my.ras.config.evt_auth_fail, function(){
    $('#ras-connection-status')
        .removeClass('fa-spinner')
        .removeClass('fa-spin')
        .addClass('fa-ban');

    $.smallBox({
        title : '시스템',
        content : '<i class="fa fa-warning"></i> <i>CKPush RAS 인증 실패 하였습니다. 관리자에게 문의 하세요.</i>',
        color : '#C46A69'
    });
});


// 5. CKPush RAS에 애플리케이션이 연결 완료 되면 성공 알림창을 보여 준다.
$(document).on(my.ras.config.evt_auth_success, function(){
    $('#ras-connection-status')
        .removeClass('fa-spinner')
        .removeClass('fa-spin');

    // notification 창으로 처리 하지 않고 아이콘을 변경 한다.
    //$.smallBox({
    //    title : '시스템',
    //    content : '<i class="fa fa-check"></i> <i>CKPush RAS 연결 되었습니다.</i>',
    //    color : '#296191',
    //    timeout: 2000
    //});
});


// 6. object 초기화
// 사용되는 모든 object 데이터를 초기화 한다.
// _ckras.model.getByUITag 를 이용하여 특정 데이터를 그룹별로 가져 올 수 있음.
$(document).on(my.ras.config.evt_object_init, function(){
    // 1. system usage 그래프 출력
    var $parent = $('.rasui-system-usage-graph');
    if($parent.length > 0) {
        var systemUsageData = _ckras.model.getByUITag(my.ras.config.uitag_system_status);

        if (systemUsageData.length > 0) {
            var cpuPct = 0, memoryPct = 0, memoryUsage = 0, serverLoad = 0, loadPct = 0, maxLoad = 10;

            for (var i = 0; i < systemUsageData.length; i++) {
                try { cpuPct = parseFloat(systemUsageData[i].cpu); }
                catch(err) {
                    if(my.ras.config.debug_log) console.log('invalid system usage cpu. not number. cpu [' + systemUsageData[i].cpu + ']');
                }
                cpuPct = Math.round(cpuPct);

                try { memoryPct = parseFloat(systemUsageData[i].mem_usage); }
                catch(err) {
                    if(my.ras.config.debug_log) console.log('invalid system usage memory usage. not number. memory usage [' + systemUsageData[i].mem_usage + ']');
                }
                memoryPct = Math.round(systemUsageData[i].mem_usage);
                memoryUsage = my.fn.toNumber(systemUsageData[i].mem_used) / 1000;

                try { serverLoad = parseFloat(systemUsageData[i].loadavg); }
                catch(err) {
                    if(my.ras.config.debug_log) console.log('invalid system usage load. not number. load [' + systemUsageData[i].loadavg + ']');
                }
                loadPct = serverLoad / maxLoad * 100;

                _ckras.ui.drawLiveProgress({
                    parentDomClass: 'rasui-system-usage-graph',
                    id: systemUsageData[i]._ui_id,
                    text: '실시간 서버 상태',
                    progress: [
                        {left: 'CPU', right: cpuPct+'%', percentage: cpuPct},
                        {left: 'Memory', right: memoryPct + '% ('+memoryUsage.numberFormat(0, '.', ',')+'M)', percentage: memoryPct},
                        {left: 'Load', right: Math.round(loadPct)+'% ('+serverLoad+')', percentage: loadPct},
                    ]
                });
            }
        }
    }
    // end of 1. system usage 그래프 출력

    // 2. push message 전송 그래프 출력
    $parent = $('.rasui-push-message-status-graph');
    if($parent.length > 0) {
        var pushMessageStatusData = _ckras.model.getByUITag(my.ras.config.uitag_push_message);

        if(pushMessageStatusData.length > 0) {
            var currTotal = 0, allTotal = 0, realTotal = 0, succTotal = 0, failTotal = 0,
                realFailTotal = 0, recvTotal = 0, confirmTotal = 0,
                allPct = 0, succPct = 0, failPct = 0, confirmPct = 0, sendDate = '';

            pushMessageStatusData.sort(function(a, b){
                return my.fn.toNumber(b.c_date) - my.fn.toNumber(a.c_date);
            });

            for (var i = 0; i < pushMessageStatusData.length; i++) {
                succTotal = my.fn.toNumber(pushMessageStatusData[i].success_count);
                realTotal = my.fn.toNumber(pushMessageStatusData[i].total_real_count);
                failTotal = my.fn.toNumber(pushMessageStatusData[i].fail_count);
                realFailTotal = my.fn.toNumber(pushMessageStatusData[i].fail_real_count);
                currTotal = succTotal + failTotal;
                allTotal = my.fn.toNumber(pushMessageStatusData[i].total_count);
                recvTotal = my.fn.toNumber(pushMessageStatusData[i].received_count);
                confirmTotal = my.fn.toNumber(pushMessageStatusData[i].confirm_count);
                sendDate = new Date(my.fn.toNumber(pushMessageStatusData[i].c_date) * 1000).format('yyyy-MM-dd HH:mm:ss');

                allPct = Math.round(currTotal / allTotal * 100);
                succPct = Math.round(succTotal / realTotal * 100);
                failPct = 100 - succPct;
                confirmPct = Math.round(confirmTotal / realTotal * 100);

                _ckras.ui.draw4PieChart({
                    parentDomClass: 'rasui-push-message-status-graph',
                    id: pushMessageStatusData[i].tid,
                    text: ['- <strong>메시지</strong> : ' + pushMessageStatusData[i].push_title,
                        '- <strong>전송량</strong> : ' + currTotal + ' / ' + allTotal,
                        '- <strong>발송일</strong> : ' + sendDate],
                    chart: [
                        {name: '전체', percentage: allPct, color: '#57889c'},
                        {name: '성공', percentage: succPct, color: '#356e35'},
                        {name: '실패', percentage: failPct, color: '#a90329'},
                        {name: '확인', percentage: confirmPct, color: '#71843f'}
                    ],
                    canClose: (pushMessageStatusData[i].status && pushMessageStatusData[i].status == 'end' ? true : false)
                });
            }
        }
    }
    // end of 2. push message 전송 그래프 출력

});


// 7. object 추가/변경
// 추가된 data model value 는 _ckras.model.get(key) 로 구하면 된다.
// key  : 추가된 data model key
$(document).on(my.ras.config.evt_object_changed, function(evt, key){
    var data = _ckras.model.get(key);

    if(!data || !data._ui_tag) {
        if(my.ras.config.debug_log) console.log('invalid data. not found _ui_tag. data[' + JSON.stringify(data) + ']');
        return;
    }

    // event type 에 따른 처리
    switch(data._ui_tag) {
        // system usage 그래프를 변경 시킨다.
        case my.ras.config.uitag_system_status:
            var cpuPct = 0, memoryPct = 0, memoryUsage = 0, serverLoad = 0, loadPct = 0, maxLoad = 10;

            try { cpuPct = parseFloat(data.cpu); }
            catch(err) {
                if(my.ras.config.debug_log) console.log('invalid system usage cpu. not number. cpu [' + data.cpu + ']');
            }
            cpuPct = Math.round(cpuPct);

            try { memoryPct = parseFloat(data.mem_usage); }
            catch(err) {
                if(my.ras.config.debug_log) console.log('invalid system usage memory usage. not number. memory usage [' + data.mem_usage + ']');
            }
            memoryPct = Math.round(data.mem_usage);
            memoryUsage = my.fn.toNumber(data.mem_used) / 1000;

            try { serverLoad = parseFloat(data.loadavg); }
            catch(err) {
                if(my.ras.config.debug_log) console.log('invalid system usage load. not number. load [' + data.loadavg + ']');
            }
            loadPct = serverLoad / maxLoad * 100;

            _ckras.ui.drawLiveProgress({
                parentDomClass: 'rasui-system-usage-graph',
                id: data._ui_id,
                text: '실시간 서버 상태',
                progress: [
                    {left: 'CPU', right: cpuPct+'%', percentage: cpuPct},
                    {left: 'Memory', right: memoryPct + '% ('+memoryUsage.numberFormat(0, '.', ',')+'M)', percentage: memoryPct},
                    {left: 'Load', right: Math.round(loadPct)+'% ('+serverLoad+')', percentage: loadPct},
                ]
            });
            break;

        // push message 상태 그래프를 변경 시킨다.
        case my.ras.config.uitag_push_message:
            var succTotal = my.fn.toNumber(data.success_count),
                realTotal = my.fn.toNumber(data.total_real_count),
                currTotal = succTotal + my.fn.toNumber(data.fail_count),
                allTotal = my.fn.toNumber(data.total_count),
                failTotal = my.fn.toNumber(data.fail_count),
                realFailTotal = my.fn.toNumber(data.fail_real_count),
                recvTotal = my.fn.toNumber(data.received_count),
                confirmTotal = my.fn.toNumber(data.confirm_count),
                sendDate = new Date(my.fn.toNumber(data.c_date) * 1000).format('yyyy-MM-dd HH:mm:ss');

            var allPct = Math.round(currTotal / allTotal * 100),
                succPct = Math.round(succTotal / realTotal * 100),
                failPct = 100 - succPct,
                confirmPct = Math.round(confirmTotal / realTotal * 100);

            _ckras.ui.draw4PieChart({
                appendFirst: true,
                parentDomClass: 'rasui-push-message-status-graph',
                id: data.tid,
                text: ['- <strong>메시지</strong> : ' + data.push_title,
                       '- <strong>전송량</strong> : ' + currTotal + ' / ' + allTotal,
                       '- <strong>발송일</strong> : ' + sendDate],
                chart: [
                    {name: '전체', percentage: allPct, color: '#57889c'},
                    {name: '성공', percentage: succPct, color: '#356e35'},
                    {name: '실패', percentage: failPct, color: '#a90329'},
                    {name: '확인', percentage: confirmPct, color: '#71843f'}
                ],
                canClose: (data.status && data.status == 'end' ? true : false)
            });

            // 혹시 데이터 테이블이 존재하면 변경
            var $tableRow = $('#dt-row-push-message-'+data.tid);
            if($tableRow.length > 0) {
                var $column = $tableRow.children();
                if ($column.length >= 3) $($column.get(2)).text(allTotal.numberFormat(0, '.', ',') + '개');
                if ($column.length >= 4) $($column.get(3)).text(realTotal.numberFormat(0, '.', ',') + '개');
                if ($column.length >= 5) $($column.get(4)).text(succTotal.numberFormat(0, '.', ',') + '개');
                if ($column.length >= 6) $($column.get(5)).text(failTotal.numberFormat(0, '.', ',') + '개');
                if ($column.length >= 7) $($column.get(6)).text(realFailTotal.numberFormat(0, '.', ',') + '개');
                if ($column.length >= 8) $($column.get(7)).text(recvTotal.numberFormat(0, '.', ',') + '개');
                if ($column.length >= 9) $($column.get(8)).text(confirmTotal.numberFormat(0, '.', ',') + '개');
            }
            break;
    }

});


// 8. object 삭제
// key      : 삭제한 data model key
// value    : 삭제된 data model value
$(document).on(my.ras.config.evt_object_removed, function(evt, key, data){
    if(!data._ui_tag) return;

    switch(data._ui_tag) {
        // system usage 그래프를 삭제 한다.
        case my.ras.config.uitag_system_status:
            // NOTE 이건 삭제 되지 않는 것임. 삭제 되는 로직 만드는 장소만 넣어 두고 삭제 하지 않는다.
            break;

        // push message 상태 그래프를 삭제 한다.
        case my.ras.config.uitag_push_message:
            _ckras.ui.remove4PieChart(data.tid);
            break;
    }
});


// 9. 명령어 결과 ?? 뭔지 모름 ???
$(document).on('r-ras-console', function(evt){
    if(my.ras.config.debug_log) console.log('r-ras-console occur');
});


