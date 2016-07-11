var my;
if(!my) my = {};
if(!my.ras) my.ras = {};

if(!my.ras.config) my.ras.config = {
    // 네트워크 로그 on/off 여부.
    debug_log: false,

    server_name: 'plymind.com',
    server_port: '20001',

    connection_type: ['websocket'],
    //connection_resource: 'socket.io',
    connection_resource: 'ras-sio-svc',

    socketio_auto_reconnection: false,

    protocol_version:           'ras-protocol-v1',
    protocol_ping_pong:         'ras-alive',
    protocol_auth:              'ras-user-auth',
    protocol_auth_user_name:    'backoffice',           // 인증 요청하는 사용자 아이디
    protocol_auth_member_srl:   $.now(),                // 인증 요청하는 사용자 시리얼 넘버(optional)
    protocol_auth_user_email:   'dhkim@ckstack.com',    // 인증 요청하는 사용자 이메일 주소(optional)
    protocol_auth_gender:       'male',                 // 인증 요청하는 사용자 성별(optional)
    protocol_auth_photo:        '',                     // 인증 요청하는 사용자 사진(optional)
    protocol_auth_ras_app_id:   'console',              // 인증 요청하는 애플리케이션 아이디
    protocol_sec_key:           '1234.',                // 인증 요청할때 사용되는 인증키. 없을때 사용

    ping_pong_count: 30,                                // 서버에 ping pong 치는 카운트. 30 이면 30초임.
    init_code: 'P2-DATA',

    // system handler
    sys_handler_hello:          'ras-hello',
    sys_handler_deny:           'ras-deny',
    sys_handler_accept:         'r-ras-user-auth',
    sys_handler_monitor:        'ras-monitor',
    sys_handler_connect:        'connect',
    sys_handler_disconnect:     'disconnect',
    sys_handler_ping_pong:      'r-ras-alive',
    sys_handler_object_change:  'object-changed',
    sys_handler_object_delete:  'object-deleted',
    sys_handler_data_init:      'ras-data-init',

    evt_ras_disconnect:         'evt-ras-disconnect',
    evt_ras_connect_retry:      'evt-ras-connect-retry',
    evt_auth_start:             'evt-ras-auth-start',
    evt_auth_fail:              'evt-ras-auth-fail',
    evt_auth_success:           'evt-ras-auth-success',
    evt_object_init:            'evt-ras-object-init',
    evt_object_changed:         'evt-ras-object-changed',
    evt_object_removed:         'evt-ras-object-removed'
};


// application 전용 handler
my.ras.config.app_handler = ['r-ras-console'];

// 지원하는 data 의 종류. ui component와 밀접하게 관계 되어 있음
my.ras.config.uitag_push_message = 'push-info1';
my.ras.config.uitag_system_status = 'system-status1';

// data 종류별 et 값(추가/삭제 시 필요. add, remove 는 공통으로 사용 해야 함)
my.ras.config[my.ras.config.uitag_push_message] = {
    add: 'ckpush-gcm-apns-send',
    remove: 'ckpush-gcm-apns-remove'
};