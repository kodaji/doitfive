(function($){$(document).ready(function(){
    pageSetUp();

    var plot_3;

    var pagefunction = function() {
        drawBreadCrumb(['막대 그래프 샘플']);


        var chrt_border_color = "#efefef";
        var chrt_second = "#6595b4";        // blue
        var chrt_fourth = "#7e9d3a";        // green

        if ($("#bar-chart").length) {
            // blue color 막대 그래프 데이터. 총 12개
            var data1 = [];
            for(var i=0 ; i <= 12; i++) data1.push([i, parseInt(Math.random() * 30)]);

            // green color 막대 그래프 데이터. 총 12개
            var data2 = [];
            for(var i=0 ; i <= 12; i++) data2.push([i, parseInt(Math.random() * 30)]);

            // gray color 막대 그래프 데이터. 총 12개
            var data3 = [];
            for(var i=0 ; i <= 12; i++) data3.push([i, parseInt(Math.random() * 30)]);

            var ds = new Array();

            // blue color 막대 그래프 추가
            ds.push({
                data: data1,
                bars: {
                    show: true,
                    barWidth: 0.2,  // 막대의 너비
                    order: 1        // 막대의 order. 제일 왼쪽
                }
            });

            // green color 막대 그래프 추가
            ds.push({
                data: data2,
                bars: {
                    show: true,
                    barWidth: 0.2,  // 막대의 너비
                    order: 2        // 막대의 order. 중간
                }
            });

            // gray color 막대 그래프 추가
            ds.push({
                data: data3,
                bars: {
                    show: true,
                    barWidth: 0.2,  // 막대의 너비
                    order: 3        // 막대의 order. 제일 오른쪽
                }
            });

            // 막대 그래프를 그린다.
            plot_3 = $.plot($("#bar-chart"), ds, {
                colors : [chrt_second, chrt_fourth, "#666", "#BBB"],
                grid : {
                    show : true,
                    hoverable : true,
                    clickable : true,
                    tickColor : chrt_border_color,
                    borderWidth : 0,
                    borderColor : chrt_border_color,
                },
                legend : true,
                tooltip : true,
                tooltipOpts : {
                    //content : "<b>%x</b> = <span>%y</span>",
                    content : "<span>%y</span>",
                    defaultTheme : false
                }

            });
        }

    };

    var pagedestroy = function(){
        console.log('destroy page');

        plot_3.shutdown();
        plot_3 = null;
    };

    loadScript("/adm/js/plugin/flot/jquery.flot.cust.min.js", function(){
        loadScript("/adm/js/plugin/flot/jquery.flot.resize.min.js", function(){
            loadScript("/adm/js/plugin/flot/jquery.flot.fillbetween.min.js", function(){
                loadScript("/adm/js/plugin/flot/jquery.flot.orderBar.min.js", function(){
                    loadScript("/adm/js/plugin/flot/jquery.flot.pie.min.js", function(){
                        loadScript("/adm/js/plugin/flot/jquery.flot.time.min.js", function(){
                            loadScript("/adm/js/plugin/flot/jquery.flot.tooltip.min.js", pagefunction);
                        });
                    });
                });
            });
        });
    });
});}(jQuery));