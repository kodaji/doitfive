var my;
if(!my) my = {};
if(!my.nmap) my.nmap = {};
if(!my.nmap.fn) my.nmap.fn = {};

if(!nhn.api.map) {console.warn('need NHN map load first');} else {

	if(!my.nmap.data)
		my.nmap.data = {
			mapPosition: null,
			defaultLevel:10,
			map:null,
			initHeight: 500,
			markerIcon: new nhn.api.map.Icon('http://static.naver.com/maps2/icons/pin_spot2.png',
				new nhn.api.map.Size(28, 37), new nhn.api.map.Size(14, 37)),
			markers: [],
			markerLabel: new nhn.api.map.MarkerLabel(),
			slider: new nhn.api.map.ZoomControl(),
			mapType: new nhn.api.map.MapTypeBtn()
		};

// 마커를 선택 했을때 라벨을 보여 준다.
	my.nmap.fn._markerClickAttach = function(ne) {
		var target = ne.target;
		if(!(target instanceof nhn.api.map.Marker)) return;

		if(my.nmap.data.markerLabel.sText)
			my.nmap.data.markerLabel.setVisible(true, target);
	};

	my.nmap.fn.init = function(mapId) {
		if(my.nmap.data.mapPosition) {
			delete my.nmap.data.mapPosition;
			my.nmap.data.mapPosition = null;
		}

		if(my.nmap.data.map) {
			$('#'+mapId).empty();

			delete my.nmap.data.map;
			my.nmap.data.map = null;
		}

		my.nmap.data.markerLabel.setVisible(false);
	};

// naver map을 생성 하고 마커를 추가 한다. 마커가 2개 이상이면 한번에 볼 수 있도록 축척과 중심점을 자동 조정 한다.
// 마커가 추가 되지 않으면 latitude, longitude 를 사용해서 지도의 중심점을 잡지만
// 마커가 1개 이상 추가 되면 마커가 모두 보일 수 있도록 지도의 축척과 중심점을 자동 조정 한다.
// 마커가 1개 일때는 defaultLevel 값으로 축척을 사용하지만 2개 이상일때는 축척을 자동 조정 한다.
//
// 한번 초기화 된 map은 두번째 show 할때는 size 조절을 무시한다.
// size 조절은 resize 함수를 통해서 하면 된다.
//
// w			: 지도의 너비
// h			: 지도의 높이. 0보다 작으면 my.nmap.data.initHeight에 정의된 기본값을 사용 한다.
// latitude		: 지도에서 중심에 위치할 위치의 위도
// longitude	: 지도에서 중심에 위차할 위치의 경도
// mapId		: 지도 생성시 지도를 넣을 div의 tag id
// markers		: 지도에 표시할 마커 array. 마커 object의 array 이다.
//				  title		- 마커를 클릭 했을 때 보여줄 문자열, null 또는 empty string 이면 클릭 해도 아무 반응 없음
//				  latitude	- 마커의 위도
//				  longitude	- 마커의 경도
//				  {
//					title: <string>,
//					latitude: <float>,
//					longitude: <float>
//				  }
	my.nmap.fn.show = function(w, h, latitude, longitude, mapId, markers) {
		if(h < 0) h = my.nmap.data.initHeight;

		if(latitude <= 0 || longitude <= 0) {
			console.warn('no latitude or longitude');
			return;
		}

		my.nmap.data.mapPosition = new nhn.api.map.LatLng(latitude, longitude);

		if(!my.nmap.data.map) {
			my.nmap.data.map = new nhn.api.map.Map(document.getElementById(mapId), {
				point: my.nmap.data.mapPosition,
				zoom : my.nmap.data.defaultLevel,
				enableWheelZoom : true,
				enableDragPan : true,
				enableDblClickZoom : false,
				mapMode : 0,
				activateTrafficMap : false,
				activateBicycleMap : false,
				minMaxLevel : [ 1, 14 ],
				size : new nhn.api.map.Size(w, h)});

			my.nmap.data.map.addOverlay(my.nmap.data.markerLabel);
			my.nmap.data.map.attach('click', my.nmap.fn._markerClickAttach);
			// 삭제는 deatach 를 사용 하면 된다. my.nmap.data.map 찍어 보면 함수 보임

			// 지도 확대, 축소 slider 추가
			my.nmap.data.map.addControl(my.nmap.data.slider);
			my.nmap.data.slider.setPosition({top:10, left:10});

			// 지도 타입 추가
			my.nmap.data.map.addControl(my.nmap.data.mapType);
			my.nmap.data.mapType.setPosition({bottom:10, right:10});

		} else {
			my.nmap.data.markerLabel.setVisible(false);
			//my.nmap.data.map.setSize(new nhn.api.map.Size(w, h));
		}

		// 기존 마커가 존재하면 삭제 한다.
		if(my.nmap.data.markers.length > 0) {
			var len = my.nmap.data.markers.length;
			for(var i=0 ; i<len ; i++) {

				my.nmap.data.map.removeOverlay(my.nmap.data.markers[i]);
				delete my.nmap.data.markers[i];
			}
			my.nmap.data.markers = [];
		}

		// 마커를 추가하고, 마커에 따라서 축척을 자동 조정 한다.
		if(markers && markers.length > 0) {
			_.each(markers, function(item) {
				var marker = new nhn.api.map.Marker(my.nmap.data.markerIcon, {title: item.title});
				marker.setPoint(new nhn.api.map.LatLng(item.latitude, item.longitude));
				my.nmap.data.map.addOverlay(marker);
				my.nmap.data.markers.push(marker);
			});

			var points = [];
			_.each(my.nmap.data.markers, function(item){points.push(item.getPoint());});

			// 마커가 모두 보일 수 있도록 축척을 조정 한다.
			if(points.length > 1)
				my.nmap.data.map.setBound(points, {useEffect:false, centerMark:false});
			else {
				my.nmap.data.map.setCenter(my.nmap.data.mapPosition, {useEffect: false, centerMark: false});
				my.nmap.data.map.setLevel(my.nmap.data.defaultLevel, {useEffect: false, centerMark: false});
			}

		} else {
			my.nmap.data.map.setCenter(my.nmap.data.mapPosition, {useEffect: false, centerMark: false});
		}

	};


// naver map의 크기를 resize 한다.
// w	: resize 할 지도의 너비. pixel 단위
// h	: resize 할 지도의 높이. pixel 단위
	my.nmap.fn.resize = function(w, h) {
		if(!my.nmap.data.map) {
			console.warn('not found naver map object');
			return;
		}

		if(h < 0) h = my.nmap.data.initHeight;

		my.nmap.data.map.setSize(new nhn.api.map.Size(w, h));
	};

} // end of if(!nhn.api.map) {console.warn('need NHN map load first');} else {
