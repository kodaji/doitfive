var my;
if(!my) my = {};
if(!my.ras) my.ras = {};

if(!my.ras.ui) {
    my.ras.ui = (function() {
        var _instance, _logkey = '[ras-user-ui] ';

        var _init = function() {

            // 4 pie chart close button 에 이벤트를 바인드 시켜 둔다.
            $(document).on('click', function(evt){
                // NOTE IE11 에서는 evt.target.dataset 이 먹히는데 하위 버전은 모르겠음. 아마 10 까지는 될듯
                if(!evt.target || !evt.target.dataset || _.size(evt.target.dataset) <= 0 ||
                    !evt.target.dataset.rasui) return;

                switch (evt.target.dataset.rasui) {
                    case '4piechart-close':
                        if(!evt.target.dataset['4piechartid']) return;

                        var et = null;
                        if(_.has(my.ras.config, my.ras.config.uitag_push_message) &&
                            _.has(my.ras.config[my.ras.config.uitag_push_message], 'remove')) {
                            et = my.ras.config[my.ras.config.uitag_push_message].remove;
                        }

                        _ckras.model.removeByUITag(my.ras.config.uitag_push_message,
                            evt.target.dataset['4piechartid'], et);
                        break;
                }
            });


            // live progress 가 없을때 추가 한다.
            var _createLiveProgress = function(obj) {
                var graphId = 'live-progress-chart-'+obj.id;
                var $graph = $('#'+graphId);

                if($graph.length > 0) {
                    if(my.ras.config.debug_log) console.log(_logkey+'already exist live progress chart. id [' + obj.id + ']');
                    return;
                }

                var displayClose = 'none';
                if(obj.canClose) displayClose = 'block';

                var graph = '<div id="'+graphId+'" class="col-sm-4"><div class="well"><button id="live-progress-chart-close-'+(obj.id)+'" class="close" data-rasui="liveprogresschart-close" data-liveprogresschartid="'+(obj.id)+'" style="display:'+displayClose+';">×</button>';

                // 상단 제목
                if(obj.text) graph += '<div><strong id="live-progress-chart-title-'+(obj.id)+'">'+(obj.text)+'</strong></div>';

                graph += '<div class="row show-stats">';
                for(var i=0 ; i<obj.progress.length ; i++) {
                    if(!_.has(obj.progress[i], 'percentage')) {
                        if(my.ras.config.debug_log) console.log(_logkey+'ignore progress unit. not found percentage for progress bar. id [' + obj.id + ']');
                        continue;
                    }

                    graph += '<div class="col-xs-6 col-sm-6 col-md-12 col-lg-12">';

                    // progress 설명 추가
                    if(_.has(obj.progress[i], 'left') || _.has(obj.progress[i], 'right')) {
                        if(_.has(obj.progress[i], 'left') && _.has(obj.progress[i], 'right')) {
                            graph += '<span class="text"> <span id="live-progress-char-unit-left'+i+'-'+(obj.id)+'">'+(obj.progress[i].left)+'</span> <span id="live-progress-chart-unit-right'+i+'-'+(obj.id)+'" class="pull-right">'+(obj.progress[i].right)+'</span> </span>';
                        } else if(!_.has(obj.progress[i], 'left')) {
                            graph += '<span class="text"> <span id="live-progress-chart-unit-right'+i+'-'+(obj.id)+'" class="pull-right">'+(obj.progress[i].right)+'</span> </span>';
                        } else if(!_.has(obj.progress[i], 'right')) {
                            graph += '<span class="text"> <span id="live-progress-char-unit-left'+i+'-'+(obj.id)+'">'+(obj.progress[i].left)+'</span> </span>';
                        }
                    }

                    // progress 상태 추가
                    var progressColor = '#356e35';      // green
                    var iPct = 0;
                    try { iPct = parseInt(obj.progress[i].percentage); }
                    catch (err) {
                        if(my.ras.config.debug_log) console.log(_logkey+'progress value is not number format. set default value zero. percentage [' + obj.progress[i].percentage + ']');
                    }
                    if(iPct > 50 && iPct <= 80) progressColor = '#57889c';  // blue
                    else if(iPct > 80)          progressColor = '#a90329';  // red

                    graph += '<div class="progress"><div id="live-progress-char-unit-prog'+i+'-'+(obj.id)+'" class="progress-bar" style="width: '+iPct+'%; background-color:'+progressColor+';"></div></div></div>';
                }

                graph += '</div></div></div>';

                $('.'+obj.parentDomClass).append(graph);
            };


            // progress bar 가 들어 있는 ui component 를 그린다.
            // smart admin 환경 하에서 그려지는 것임. 다른데선 ?? 글쎄?? css 파일만 포함 시키면 되려나 ??
            // obj 은 다음을 포함하고 있어야 함
            // obj.ignoreModify         : 신규 생성인지 수정인지 모를 경우 사용. ignoreModify 가 true 일때는 신규 생성이 아니면 무시 된다.
            // obj.parentDomClass       : progress chart 가 들어갈 부모 dom 의 Class
            // obj.id                   : progress chart 의 아이디
            // obj.text                 : progress chart 위에 보여줄 문자열(제목). string 값임
            // obj.progress             : progress chart 그릴 progress data array. 다음을 포함한다.
            //    - left                : progress 상단 좌측에 들어갈 문자열(왼쪽으로 정렬)
            //    - right               : progress 상단 우측에 들어갈 문자열(오른쪽으로 정렬)
            //    - percentage          : progress 의 percentage
            // obj.canClose             : progress chart 를 없앨 수 있는지 여부. true 이면 없앨 수 있는 x 를 보여 주고 아니면 x 를 등장 시키지 않는다.
            //                            아래 4 가지 상태를 보고 앞에서 판단하여 true, false 값을 주는 것임
            //                            start - 서버 데이터 변경 시작
            //                            progress - 서버 데이터 변경 진행 중
            //                            end -  서버 데이터 변경 완료
            var drawLiveProgress = function(obj) {
                if(!obj) {
                    if(my.ras.config.debug_log) console.log(_logkey+'invalid live progress chart data.');
                    return;
                }
                if(!obj.id) {
                    if(my.ras.config.debug_log) console.log(_logkey+'invalid live progress chart id');
                    return;
                }

                var graphId = 'live-progress-chart-'+obj.id;
                var $graph = $('#'+graphId);

                if($graph.length <= 0) {
                    if(!obj.parentDomClass) {
                        if(my.ras.config.debug_log) console.log(_logkey+'invalid parent dom id for live progress chart append');
                        return;
                    }
                    if(!obj.progress) {
                        if(my.ras.config.debug_log) console.log(_logkey+'invalid live progress chart. not found progress data');
                        return;
                    }

                    return _createLiveProgress(obj);
                }

                if(obj.ignoreModify) return;

                // 4 pie chart 삭제 버튼 출력 여부
                if(obj.canClose) $('#live-progress-chart-close-'+(obj.id)).show();
                else             $('#live-progress-chart-close-'+(obj.id)).hide();

                // 상단 제목 변경
                if(obj.text && obj.text.length > 0) {
                    var $progressTitle = $('#live-progress-chart-title-'+obj.id);
                    if($progressTitle.length > 0 && $progressTitle.text() != obj.text)
                        $progressTitle.text(obj.text);
                }

                // progress 변경
                if(obj.progress && obj.progress.length > 0) {
                    for(var i=0 ; i<obj.progress.length ; i++) {
                        var $unit = $('#live-progress-char-unit-left'+i+'-'+obj.id);
                        if(obj.progress[i].left && $unit.length > 0 && $unit.text() != obj.progress[i].left)
                            $unit.text(obj.progress[i].left);

                        $unit = $('#live-progress-chart-unit-right'+i+'-'+obj.id);
                        if(obj.progress[i].right && $unit.length > 0 && $unit.text() != obj.progress[i].right)
                            $unit.text(obj.progress[i].right);

                        var iPct = 0;
                        try { iPct = parseInt(obj.progress[i].percentage); }
                        catch (err) {
                            if(my.ras.config.debug_log) console.log(_logkey+'progress value is not number format. set default value zero. percentage [' + obj.progress[i].percentage + ']');
                        }

                        $unit = $('#live-progress-char-unit-prog'+i+'-'+obj.id);
                        if($unit.length > 0) {
                            var progressColor = '#356e35';      // green
                            if(iPct > 50 && iPct <= 80) progressColor = '#57889c';  // blue
                            else if(iPct > 80)          progressColor = '#a90329';  // red
                            $unit.css({'background-color': progressColor, 'width' : iPct+'%'});
                        }
                    }
                }
            };


            // 4 pie chart 가 존재하지 않을때 화면에 추가 한다.
            var _create4PieChart = function(obj) {
                var graphId = '4-pie-chart-'+obj.id;
                var $graph = $('#'+graphId);

                if($graph.length > 0) {
                    if(my.ras.config.debug_log) console.log(_logkey+'already exist 4 pie chart. id [' + obj.id + ']');
                    return;
                }

                var displayClose = 'none';
                if(obj.canClose) displayClose = 'block';

                //var graph = '<div id="'+graphId+'" class="col-sm-4"><div class="well"><p class="txt-color-blueDark text-ellipsis">';
                var graph = '<div id="'+graphId+'" class="col-sm-4 rasui-4-pie-chart" data-loc="'+obj.id+'"><div class="well"><button id="4-pie-chart-close-'+(obj.id)+'" class="close" data-rasui="4piechart-close" data-4piechartid="'+(obj.id)+'" style="display:'+displayClose+';">×</button><p class="txt-color-blueDark text-ellipsis">';

                // 상단 문자열
                if(obj.text && obj.text.length > 0) {
                    for(var i=0 ; i<obj.text.length ; i++) {
                        graph += '<span id="4-pie-chart-text'+i+'-'+(obj.id)+'">' + obj.text[i] + '</span><br/>';
                    }
                }

                graph += '</p><div class="row text-center"><ul class="list-inline">';

                for(var i=0 ; i<obj.chart.length ; i++) {
                    var unit = obj.chart[i];
                    if(!unit)               continue;

                    if(!unit.percentage)    unit.percentage = 0;
                    if(!unit.color)         unit.color = '#57889c';

                    graph += '<li><div id="4-pie-chart-ui'+i+'-'+(obj.id)+'" class="easy-pie-chart easyPieChart" data-percent="'+(unit.percentage)+'" data-size="60" data-pie-size="30">' +
                        '<span id="4-pie-chart-data'+i+'-'+(obj.id)+'" class="percent percent-sign" style="color:'+(unit.color)+';">'+(unit.percentage)+'</span>';

                    if(unit.name) graph += '</div><div class="font-xs text-muted" style="text-align: center;">'+(unit.name)+'</div>';
                    graph += '</li>';
                }

                graph += '</ul></div></div></div>';

                if(obj.appendFirst) {
                    var $viewedChart = $('.rasui-4-pie-chart');
                    if($viewedChart.length <= 0) $('.'+obj.parentDomClass).append(graph);
                    else {
                        var lastLoc = 0, beforePos = '';
                        // append 될 위치를 찾는다.
                        $viewedChart.each(function(){
                            var $this = $(this);
                            var loc = my.fn.toNumber($this.data('loc'));

                            if(loc >= lastLoc) {
                                beforePos = $this.attr('id');
                                lastLoc = loc;
                            }
                        });
                        $('#'+beforePos).before(graph);
                    }
                } else {
                    $('.'+obj.parentDomClass).append(graph);
                }

                for(var i=0 ; i<obj.chart.length ; i++) {
                    var unit = obj.chart[i];
                    if(!unit)               continue;

                    $('#4-pie-chart-ui'+i+'-'+(obj.id)).easyPieChart({
                        scaleColor: false,
                        trackColor: '#f1f1f1',
                        barColor: unit.color
                    });
                }
            };


            // pie chart 가 들어 있는 ui component 를 그린다.
            // smart admin 환경 하에서 그려지는 것임. 다른데선 ?? 글쎄?? css 파일만 포함 시키면 되려나 ??
            // obj 은 다음을 포함하고 있어야 함
            // obj.ignoreModify         : 신규 생성인지 수정인지 모를 경우 사용. ignoreModify 가 true 일때는 신규 생성이 아니면 무시 된다.
            // obj.parentDomClass       : 4 pie chart 가 들어갈 부모 dom 의 class
            // obj.appendFirst          : 동일한 4 pie chart 들이 존재 할때 새로 추가하는 4 pie chart 를 어디에 추가할지 여부.
            //                            true 라면 기존에 추가한 4 pie chart 중에서 제일 처음 위치 앞에 추가 하고
            //                            false 라면 위치 상관 없이 제일 마지막에 추가 한다. 4 pie chart 제일 마지막이 아니라, 추가하는 곳에 제일 마지막 임.
            // obj.id                   : 4 pie chart 의 아이디
            // obj.text                 : pie chart 위에 보여줄 문자열. array 값임. array 에 포함된 string 요소에 따라 라인이 구분됨.
            // obj.chart                : pie chart 그릴 chart data array. 다음을 포함한다.
            //    - name                : chart 의 이름(pie char 하단에 보여줄 문자)
            //    - percentage          : chart 의 percentage
            //    - color               : chart 의 color. #ffffff 형태
            // obj.canClose             : chart 를 없앨 수 있는지 여부. true 이면 없앨 수 있는 x 를 보여 주고 아니면 x 를 등장 시키지 않는다.
            //                            아래 4 가지 상태를 보고 앞에서 판단하여 true, false 값을 주는 것임
            //                            start - 서버 데이터 변경 시작
            //                            progress - 서버 데이터 변경 진행 중
            //                            end -  서버 데이터 변경 완료
            var draw4PieChart = function(obj) {
                if(!obj) {
                    if(my.ras.config.debug_log) console.log(_logkey+'invalid push message status data.');
                    return;
                }
                if(!obj.id) {
                    if(my.ras.config.debug_log) console.log(_logkey+'invalid push message status data id');
                    return;
                }

                var graphId = '4-pie-chart-'+obj.id;
                var $graph = $('#'+graphId);

                if($graph.length <= 0) {
                    if(!obj.parentDomClass) {
                        if(my.ras.config.debug_log) console.log(_logkey+'invalid parent dom id for 4 pie chart append');
                        return;
                    }
                    if(!obj.chart) {
                        if(my.ras.config.debug_log) console.log(_logkey+'invalid 4 pie chart. not found chart data');
                        return;
                    }

                    return _create4PieChart(obj);
                }

                if(obj.ignoreModify) return;

                // 4 pie chart 삭제 버튼 출력 여부
                if(obj.canClose) $('#4-pie-chart-close-'+(obj.id)).show();
                else             $('#4-pie-chart-close-'+(obj.id)).hide();

                // 상단 text 변경
                if(obj.text && obj.text.length > 0) {
                    for(var i=0 ; i<obj.text.length ; i++) {
                        var $_target = $('#4-pie-chart-text'+i+'-'+obj.id);
                        if($_target.length > 0) $_target.html(obj.text[i]);
                    }
                }

                // pie chart 변경
                if(obj.chart && obj.chart.length > 0) {
                    for(var i=0 ; i<obj.chart.length ; i++) {
                        if(obj.chart[i].percentage) {
                            $('#4-pie-chart-ui'+i+'-'+(obj.id)).data('easyPieChart').update(obj.chart[i].percentage);
                            $('#4-pie-chart-data'+i+'-'+(obj.id)).text(obj.chart[i].percentage+'');
                        }
                    }
                }
            };

            // 4 pie chart 를 삭제 한다.
            var remove4PieChart = function(id) {
                if(!id) {
                    if(my.ras.config.debug_log) console.log(_logkey+'invalid 4 pie chart id for remove. id [' + id + ']');
                    return;
                }

                var graphId = '4-pie-chart-'+id;
                var $graph = $('#'+graphId);

                if($graph.length <= 0) {
                    if(my.ras.config.debug_log) console.log(_logkey+'not found 4 pie chart using id [' + id + ']');
                    return;
                }

                $graph.remove();
            };

            return {
                drawLiveProgress: drawLiveProgress,
                draw4PieChart: draw4PieChart,
                remove4PieChart: remove4PieChart
            }
        };

        return {
            sharedInstance: function () {
                if (!_instance) _instance = _init();
                return _instance;
            }
        };
    })();
}

if(!_ckras.ui) _ckras.ui = my.ras.ui.sharedInstance();