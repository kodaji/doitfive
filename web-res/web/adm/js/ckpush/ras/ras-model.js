/**
 * 현재 파일을 import 하기 전에 다음의 것들을 미리 import 시켜 두어야 한다.
 *
 * 1. jquery
 * 2. underscore
 * 3. socket.io.js
 * 4. my.js
 * 5. ras-config.js
 */

var my;
if(!my) my = {};
if(!my.ras) my.ras = {};

if(!my.ras.socketIO) {
    my.ras.socketIO = (function() {
        var _instance, _socket = null, _events = [],
            _loaded = false, _ioName = null, _doRetry = true,
            _connectTimer = 0, _retryCount = 0, _logkey = '[ras-socketIO] ';

        var _init = function() {
            var reconnect = function () {
                _retryCount++;
                if(my.ras.config.debug_log) console.log(_logkey + 'try reconnect:' + _connectTimer + ', retry=' + _retryCount);
                _socket.socket.connect();
            };

            var emit = function (object) {
                if(my.ras.config.debug_log) console.log(_logkey + 'ras.socketIO:emit:' + JSON.stringify(object));
                _socket.emit(_ioName, object);
            };

            var sendPacket = function (et, data) {
                emit({
                    _t: my.ras.config.protocol_version,
                    _cmd: et,
                    data: data
                });
            };

            var init = function (io_name) {
                if(my.ras.config.debug_log) console.log(_logkey + 'init');

                if (_loaded) {
                    if(my.ras.config.debug_log) console.log(_logkey + 'already loaded. ignore init.');
                    return;
                }

                _ioName = io_name;

                if(my.ras.config.debug_log) console.log(_logkey + 'try connect. io=' + _ioName);

                // default socket.io
                //_socket = io.connect(null, {
                //        'transports': ['websocket'],
                //        'reconnect' : false
                //});

                var connectTarget = '';

                if (my.ras.config.server_name && $.trim(my.ras.config.server_name) != '') {
                    connectTarget = my.ras.config.server_name;
                }
                if (connectTarget != '' && my.ras.config.server_port && $.trim(my.ras.config.server_port) != '') {
                    connectTarget += (':' + my.ras.config.server_port);
                }

                // cors 는 서버에서 처리 해 줘야 한다. 클라이언트에서 처리 할 수 없음
                _socket = io.connect(connectTarget, {
                    resource: my.ras.config.connection_resource,
                    transports: my.ras.config.connection_type,
                    reconnect: my.ras.config.socketio_auto_reconnection
                });

                _socket.on('connect', function () {
                    if(my.ras.config.debug_log) console.log(_logkey + 'connect : ' + _retryCount);

                    if (_events['connect']) (_events['connect'])(_retryCount);
                    _retryCount = 0;

                    if (_connectTimer) {
                        if(my.ras.config.debug_log) console.log(_logkey + 'clear retry connect' + _connectTimer);
                        clearTimeout(_connectTimer);
                        _connectTimer = 0;
                    }
                });

                _socket.on('disconnect', function() {
                    console.warn(_logkey + 'disconnect');

                    if (_events['disconnect']) (_events['disconnect'])();

                    if (_doRetry && _connectTimer == 0) {
                        $(document).trigger(my.ras.config.evt_ras_connect_retry);
                        _connectTimer = setInterval(reconnect, 3000);
                        if(my.ras.config.debug_log) console.log(_logkey + 'retry timer start on disconnect_handler : ' + _connectTimer);
                    } else {
                        $(document).trigger(my.ras.config.evt_ras_disconnect);
                        if(my.ras.config.debug_log) console.log(_logkey + 'ignore try reconnect.');
                    }
                });

                _socket.on(_ioName, function(data) {
                    if(my.ras.config.debug_log) console.log(_logkey + 'Recv: ' + JSON.stringify(data));

                    if (data == null || !data._t) {
                        if(my.ras.config.debug_log) console.log(_logkey + 'invalid custom event. not found _t');
                        return;
                    }

                    if (_events[data._t]) _events[data._t](data);
                    else { if(my.ras.config.debug_log) console.log(_logkey + 'not support event handler : _t =' + data._t); }
                });

                _loaded = true;
            };

            var addHandler = function (event_id, object) {
                if(my.ras.config.debug_log) console.log(_logkey + 'add_handler :' + event_id);
                _events[event_id] = object;
            };

            var isRetry = function (retry) {
                _doRetry = retry;
            };

            return {
                reconnect: reconnect,
                emit: emit,
                init: init,
                sendPacket: sendPacket,
                addHandler: addHandler,
                isRetry: isRetry
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

if(!my.ras.model) {
    my.ras.model = (function(){
        var _instance, _data = {}, _socket = my.ras.socketIO.sharedInstance(),
            _socketId = '', _tick, _tickHandler = 0, _isConnect = false,
            _logkey = '[ras-model] ';

        var arrange = function(data) {
            var packet = _.clone(data);

            if(packet._key)     delete packet._key;
            if(packet._t)       delete packet._t;
            if(packet._i)       delete packet._i;
            if(packet.app_id)   delete packet.app_id;

            return packet;
        };

        var _init = function() {
            var init = function(auth) {
                // 1. 서버 접속 handler 등록
                _socket.addHandler(my.ras.config.sys_handler_connect, function() {
                    $(document).trigger(my.ras.config.evt_auth_start);
                    if(my.ras.config.debug_log) console.log(_logkey + 'connected to ras');
                });


                // 2. 접속 인증 handler 등록
                _socket.addHandler(my.ras.config.sys_handler_hello, function(data) {
                    if(my.ras.config.debug_log) console.log(_logkey + 'try authorization');
                    //showNotify('인증요청 : 인증처리 중입니다.', "info");

                    _socketId = data.user.soc_id;

                    var authkey = '';
                    if(!_.isObject(auth)) {
                        authkey = auth;
                        auth = {};
                    }

                    if(!_.has(auth, '_t'))          auth._t = my.ras.config.protocol_auth;
                    if(!_.has(auth, 'user_name'))   auth.user_name = my.ras.config.protocol_auth_user_name;
                    if(!_.has(auth, 'member_srl'))  auth.member_srl = my.ras.config.protocol_auth_member_srl;
                    if(!_.has(auth, 'user_email'))  auth.user_email = my.ras.config.protocol_auth_user_email;
                    if(!_.has(auth, 'sex'))         auth.sex = my.ras.config.protocol_auth_gender;
                    if(!_.has(auth, 'photo'))       auth.photo = my.ras.config.protocol_auth_photo;
                    if(!_.has(auth, 'ras_app_id'))  auth.ras_app_id = my.ras.config.protocol_auth_ras_app_id;
                    if(!_.has(auth, 'sec_key'))     auth.sec_key = my.ras.config.protocol_sec_key;
                    if(authkey)                     auth.sec_key = authkey;

                    _socket.emit(auth);
                });


                // 3. 인증 실패 handler 등록
                _socket.addHandler(my.ras.config.sys_handler_deny, function() {
                    _isConnect = false;
                    _socket.isRetry(false);
                    $(document).trigger(my.ras.config.evt_auth_fail);
                    if(my.ras.config.debug_log) console.log(_logkey + 'failed authorized. deny connection');
                    //showNotify('DENY! : 서버에 의해 접속이 거부 되었습니다.', "error");
                });


                // 4. 인증 성공 handler 등록
                _socket.addHandler(my.ras.config.sys_handler_accept, function() {
                    _isConnect = true;
                    $(document).trigger(my.ras.config.evt_auth_success);
                    if(my.ras.config.debug_log) console.log(_logkey + 'success authorized. success connection');

                    _tick = 0;
                    _tickHandler = setInterval(function() {
                        if(_isConnect) {
                            _tick++;
                            if (_tick >= my.ras.config.ping_pong_count) {
                                if(my.ras.config.debug_log) console.log(_logkey + 'ras alive. tick [' + _tick + ']');

                                _socket.emit({
                                    _t: my.ras.config.protocol_ping_pong,
                                    tick: _tick
                                });
                            }
                        }
                    }, 1000);
                });


                // 5. ping-pong handler 등록
                _socket.addHandler(my.ras.config.sys_handler_ping_pong, function() {
                    if(my.ras.config.debug_log) console.log(_logkey + 'reply ping-pong. time [' +((new Date()).toLocaleTimeString()) + ']');
                    _tick = 0;
                });


                // 6. 접속 종료 handler 등록
                _socket.addHandler(my.ras.config.sys_handler_disconnect, function() {
                    _isConnect = false;
                    clearInterval(_tickHandler);
                    _tickHandler = 0;

                    if(my.ras.config.debug_log) console.log(_logkey + 'ras disconnect');
                    //showNotify('접속해제 : 서버와 접속이 끊어 졌습니다.', "error");
                });


                // 7. 모니터 handler 등록
                _socket.addHandler(my.ras.config.sys_handler_monitor, function(data) {
                    if(my.ras.config.debug_log) console.log(_logkey+'monitor data [' + JSON.stringify(data) + ']');
                });


                // 8. object create or object changed handler 등록
                _socket.addHandler(my.ras.config.sys_handler_object_change, function(data) {
                    //if(my.ras.config.debug_log) console.log(_logkey+'object changed : ' + JSON.stringify(data) );

                    if(!_isConnect) {
                        if(my.ras.config.debug_log) console.log(_logkey+'receive object-changed but not authorized. data : ' + JSON.stringify(data) );
                        return;
                    }

                    upsert(data);
                });


                // 9. object deleted handler 등록
                _socket.addHandler(my.ras.config.sys_handler_object_delete, function(data) {
                    //if(my.ras.config.debug_log) console.log(_logkey+'object remove : ' + JSON.stringify(data));

                    if(!_isConnect) {
                        if(my.ras.config.debug_log) console.log(_logkey+'receive object-removed but not authorized. data : ' + JSON.stringify(data) );
                        return;
                    }

                    remove(data._key);
                });


                // 10. 데이터 초기화 handler 등록
                _socket.addHandler(my.ras.config.sys_handler_data_init, function(data) {
                    //if(my.ras.config.debug_log) console.log(_logkey+'init data : ' + JSON.stringify(data));

                    if(!_isConnect) {
                        if(my.ras.config.debug_log) console.log(_logkey+'receive init-data but not authorized. data : ' + JSON.stringify(data) );
                        return;
                    }

                    if(!data.status || !data.status.hash) {
                        if(my.ras.config.debug_log) console.log(_logkey+'not found init data. not exist status hash value');
                        return;
                    }

                    set(data.status.hash);
                    $(document).trigger(my.ras.config.evt_object_init);
                });


                // 11. 애플리케이션 임의의 handler 는 애플리케이션 컨트롤 부분에서 처리 한다.
                for(var i=0 ; i<my.ras.config.app_handler.length ; i++) {
                    _socket.addHandler(my.ras.config.app_handler[i], function(data) {
                        $(document).trigger(data._t);
                        //if(my.ras.config.debug_log) console.log(_logkey + 'app event received. data [' + JSON.stringify(data) + ']');
                    });
                }

                // ras 서버 접속
                _socket.init(my.ras.config.init_code);
            };

            // key 에 매핑 되는 데이터를 구한다.
            var get = function(key) {
                if(_data[key]) return _data[key];
                return null;
            };

            // _ui_tag 에 매핑 되는 데이터를 구한다.
            var getByUITag = function(uitag) {
                var ret = [];
                if(!uitag) return ret;

                for(var prop in _data) {
                    if(!_data[prop]._ui_tag) continue;
                    if(_data[prop]._ui_tag == uitag) ret.push(_.clone(_data[prop]));
                }
                return ret;
            };

            // model 의 모든 데이터를 초기화 한다.
            var set = function(data) {
                if(!data) return;
                _data = _.clone(data);
            };

            // update 일때는 true, insert 일때는 false
            var upsert = function(value) {
                if(_data[value._key]) {
                    _data[value._key] = arrange(value);
                    if(my.ras.config.debug_log) console.log(_logkey+'update [' + value._key + '] data [' + JSON.stringify(_data[value._key]) + ']' );
                    $(document).trigger(my.ras.config.evt_object_changed, [value._key, true]);
                    return true;
                } else {
                    _data[value._key] = arrange(value);
                    if(my.ras.config.debug_log) console.log(_logkey+'insert [' + value._key + '] data [' + JSON.stringify(_data[value._key]) + ']' );
                    $(document).trigger(my.ras.config.evt_object_changed, [value._key, false]);
                    return false;
                }
            };

            // uitag 값으로 검색하여 id 에 맞는 항목을 삭제 한다.
            var removeByUITag = function(uitag, id, et) {
                if(!uitag || !id) {
                    if(my.ras.config.debug_log) console.log(_logkey+'invalid uitag or id for remove. uitag [' + uitag + '], id [' + id + ']');
                    return;
                }

                var key = '';

                for(var prop in _data) {
                    if(!_data[prop]._ui_tag) continue;
                    if(_data[prop]._ui_tag == uitag && _data[prop].tid == id) {
                        key = prop;
                        break;
                    }
                }

                if(!key) {
                    if(my.ras.config.debug_log) console.log(_logkey+'not found data for remove. uitag [' + uitag + '], id [' + id + ']');
                    return;
                }

                var value = _.clone(_data[key]);
                delete _data[key];
                $(document).trigger(my.ras.config.evt_object_removed, [key, value]);

                // 서버에 삭제 요청 한다.
                if(et) _ckras.sock.sendPacket(et, {_key:key});
            };

            // key에 매핑되는 데이터를 삭제 한다.
            var remove = function(key) {
                if(_data[key]) {
                    var value = _.clone(_data[key]);
                    delete _data[key];
                    $(document).trigger(my.ras.config.evt_object_removed, [key, value]);
                }
            };

            // 모든 데이터를 삭제 한다.
            var removeAll = function() {
                _data = {};
            };

            return {
                init: init,
                get: get,
                getByUITag: getByUITag,
                upsert: upsert,
                remove: remove,
                removeByUITag: removeByUITag,
                removeAll: removeAll
            };
        };

        return {
            sharedInstance: function () {
                if (!_instance) _instance = _init();
                return _instance;
            }
        };
    })();
}

var _ckras;
if(!_ckras) _ckras = {};

if(!_ckras.sock) _ckras.sock = my.ras.socketIO.sharedInstance();
if(!_ckras.model) _ckras.model = my.ras.model.sharedInstance();
