(function($){$(document).ready(function(){
	pageSetUp();
	
	var addAddressItem = function(addr, latitude, longitude) {
		addr2 = addr + ' (lati : ' + latitude + ', longi : ' + longitude + ')';
		
		$('#lalong-list').append(
			'<div class="form-group"><div class="col-md-12"><div class="row"><div class="col-sm-12"><div class="input-group">'+
			'<input class="form-control" disabled="disabled" type="text" value="'+addr2+'">'+
			'<div class="input-group-btn"><button class="btn btn-default show-map" type="button" data-addr="'+addr+'" data-lati="'+latitude+'" data-longi="'+longitude+'">지도에서 보기</button></div>'+
			'</div></div></div></div></div>'
		);
	};
	
	
	var pagefunction = function() {
		drawBreadCrumb(['네이버 지도 샘플']);
		
		// 1. 주소로 위도, 경도 구하기
		$('#address-to-lalong').click(function(e){
			e.preventDefault();
			e.stopPropagation();
			
			var address = $('#convert-address').val();
			if($.trim(address) == '') {
				console.warn('input address');
				return;
			}

			// jsonp로 주소에서 위도, 경로를 구한다.
			$.ajax({
				type: 'GET',
				dataType: 'jsonp',
				jsonp: 'callback',
				url: 'http://openapi.map.naver.com/api/geocode?key=799a6e577159ceb5f273eacc1fad1248&encoding=utf-8&coord=latlng&output=json&query='+address,
				success: function(data, textStatus, jqXHR) {
					if(!data || !data.result || !data.result.items || data.result.items.length <= 0) {
						console.log('-----> todo show error');
						return;
					}
					
					var item = data.result.items[0];
					addAddressItem(data.result.userquery, item.point.y, item.point.x);
				},
				error: function(jqXHR, textStatus, errorThrown) {
					console.log('-----> todo show error');
				}
			});
		});
		
		
		// latitude의 최소값은 30.3466388, 최대값은 44.1447805
		// langitude의 최소값은 116.1252694, 최대값은 137.3551916
		var $nmapWrapper = $('#nmap-wrapper'), nmapInitWidth = $nmapWrapper.width();
		
		
		// 2. 브라우저의 크기에 따라 지도의 크기도 auto resize를 처리
		$nmapWrapper.resize(function(e){
			var $this = $(this), w = $this.width();
			my.nmap.fn.resize(w, -1);
		});
		
		
		// 3. 지도에서 보기 버튼을 클릭하면 지도를 보여 준다.
		// 씨케이스텍: 경기도 성남시 분당구 구미동 7-2 (돌마로46) 광천프라자 424호 (lati : 37.349694, longi : 127.1069783)
		// 모바일 파크: 경기도 성남시 분당구 수내동 9-4 현대오피스빌딩 11층 1118호 (lati : 37.3799929, longi : 127.114923)
		// 블루가: 경기 성남시 분당구 구미동 153 로드랜드 EZ타워 606호 (lati : 37.3420648, longi : 127.1083488)
		// 옆 건물: 경기도 성남시 분당구 구미동 7-1 (lati : 37.3496971, longi : 127.1066062)
		// 우리집: 경기도 용인시 기흥구 언남동 495 (lati : 37.2929907, longi : 127.1184442)
		$('#lalong-list').on('click', function(e){
			e.preventDefault();
			e.stopPropagation();
			
			if(e.target.tagName.toUpperCase() != 'BUTTON') {
				return;
			}
			
			var $this = $(e.target);
			if(!$this.hasClass('show-map')) {
				return false;
			}
			
			var lati = $this.data('lati'), 
				longi = $this.data('longi'),
				address = $this.data('addr');
			
			// 여러개의 마커를 보여 주는 것	
			//my.nmap.fn.show(nmapInitWidth, -1, lati, longi, 'nmap', [
			//	{title: '씨케이스텍', latitude: 37.349694, longitude: 127.1069783},
			//  {title: '한국과학기술 한림원', latitude: 37.3496971, longitude: 127.1066062},
			//	{title: '모바일파크', latitude: 37.3799929, longitude: 127.114923},
			//	{title: '블루가', latitude: 37.3420648, longitude: 127.1083488},
			//	{title: '우리집', latitude: 37.2929907, longitude: 127.1184442}
			//]);
			
			// 위도, 경도 리스트에서 선택한 것에 마커를 찍고 지도을 이동 시켜서 보여 준다.
			my.nmap.fn.show(nmapInitWidth, -1, lati, longi, 'nmap', [
				{title: address, latitude: lati, longitude: longi}
			]);
		});
		
		
		
	};
	
	var pagedestroy = function(){
		console.log('destroy page');
	};
	
	pagefunction();
});}(jQuery));