-- 9999. 환경 설정
-- default account
-- 기본 관리자(wypark@i-mobilepark.com)를 추가 한다
-- 패스워드는 abcd1234
INSERT INTO `plymind_db`.`tbl_member` (
    user_id, email_address, user_password, user_name, nick_name,
    mobile_phone_number, allow_mailing, allow_message, description, last_login_date,
    change_password_date, enabled, email_confirm, sign_out, c_date,
    u_date
) VALUES (
    'wypark', 'wypark@i-mobilepark.com', '$2a$10$9X/Xk3My2cTE0tHtoyul3eIU6L1/tUTaZS9ioqAA7kT1P.MjR8g2W',
    '박우용', '박우용',
    '01037514286', 1, 1, '기본 관리자', UNIX_TIMESTAMP(),
    UNIX_TIMESTAMP(), 1, 1, 2, UNIX_TIMESTAMP(),
    UNIX_TIMESTAMP()
);

INSERT INTO `plymind_db`.`tbl_member_extra` (
    member_srl, social_type, social_id, login_count, serial_login_count,
    c_date, u_date
)
SELECT
    member_srl, -1 as social_type, '' as social_id, 1 as login_count, 1 as serial_login_count, c_date, u_date
FROM `plymind_db`.`tbl_member`
WHERE user_id = 'wypark';

-- 기본 관리자(kas0610@i-mobilepark.com)를 추가 한다
-- 패스워드는 abcd1234
INSERT INTO `plymind_db`.`tbl_member` (
    user_id, email_address, user_password, user_name, nick_name,
    mobile_phone_number, allow_mailing, allow_message, description, last_login_date,
    change_password_date, enabled, email_confirm, sign_out, c_date,
    u_date
) VALUES (
    'kas0610', 'kas0610@i-mobilepark.com', '$2a$10$9X/Xk3My2cTE0tHtoyul3eIU6L1/tUTaZS9ioqAA7kT1P.MjR8g2W',
    '김애선', '김애선',
    '01041320584', 1, 1, '기본 관리자', UNIX_TIMESTAMP(),
    UNIX_TIMESTAMP(), 1, 1, 2, UNIX_TIMESTAMP(),
    UNIX_TIMESTAMP()
);

INSERT INTO `plymind_db`.`tbl_member_extra` (
    member_srl, social_type, social_id, login_count, serial_login_count,
    c_date, u_date
)
SELECT member_srl, -1 as social_type, '' as social_id, 1 as login_count, 1 as serial_login_count, c_date, u_date
FROM `plymind_db`.`tbl_member`
WHERE user_id = 'kas0610';

-- 기본 관리자(je7646@k-smartcity.kr)를 추가 한다
-- 패스워드는 abcd1234
INSERT INTO `plymind_db`.`tbl_member` (
    user_id, email_address, user_password, user_name, nick_name,
    mobile_phone_number, allow_mailing, allow_message, description, last_login_date,
    change_password_date, enabled, email_confirm, sign_out, c_date,
    u_date
) VALUES (
    'je7646', '', '$2a$10$9X/Xk3My2cTE0tHtoyul3eIU6L1/tUTaZS9ioqAA7kT1P.MjR8g2W',
    '박정은', '박정은',
    '01049427646', 1, 1, '기본 관리자', UNIX_TIMESTAMP(),
    UNIX_TIMESTAMP(), 1, 1, 2, UNIX_TIMESTAMP(),
    UNIX_TIMESTAMP()
);

INSERT INTO `plymind_db`.`tbl_member_extra` (
    member_srl, social_type, social_id, login_count, serial_login_count,
    c_date, u_date
)
SELECT member_srl, -1 as social_type, '' as social_id, 1 as login_count, 1 as serial_login_count, c_date, u_date
FROM `plymind_db`.`tbl_member`
WHERE user_id = 'je7646';

-- 기본 관리자(scss@k-smartcity.kr)를 추가 한다
-- 패스워드는 abcd1234
INSERT INTO `plymind_db`.`tbl_member` (
    user_id, email_address, user_password, user_name, nick_name,
    mobile_phone_number, allow_mailing, allow_message, description, last_login_date,
    change_password_date, enabled, email_confirm, sign_out, c_date,
    u_date
) VALUES (
    'plymind', '', '$2a$10$9X/Xk3My2cTE0tHtoyul3eIU6L1/tUTaZS9ioqAA7kT1P.MjR8g2W',
    '플리마인드', '플리마인드',
    '01041320584', 1, 1, '기본 관리자', UNIX_TIMESTAMP(),
    UNIX_TIMESTAMP(), 1, 1, 2, UNIX_TIMESTAMP(),
    UNIX_TIMESTAMP()
);

INSERT INTO `plymind_db`.`tbl_member_extra` (
    member_srl, social_type, social_id, login_count, serial_login_count,
    c_date, u_date
)
SELECT member_srl, -1 as social_type, '' as social_id, 1 as login_count, 1 as serial_login_count, c_date, u_date
FROM `plymind_db`.`tbl_member`
WHERE user_id = 'plymind';




-- 기본 관리자(wypark@i-mobilepark.com)를 서비스 루트 그룹에 매핑 시킨다
INSERT INTO `plymind_db`.`tbl_group_member` (
    group_srl, member_srl, c_date
)
SELECT B.group_srl, A.member_srl, A.c_date
FROM `plymind_db`.`tbl_member` A, `plymind_db`.`tbl_group` B
WHERE A.user_id = 'wypark' AND B.authority = 'ROLE_ROOT';

-- 기본 관리자(kas0610@i-mobilepark.com)를 서비스 루트 그룹에 매핑 시킨다
INSERT INTO `plymind_db`.`tbl_group_member` (
    group_srl, member_srl, c_date
)
SELECT B.group_srl, A.member_srl, A.c_date
FROM `plymind_db`.`tbl_member` A, `plymind_db`.`tbl_group` B
WHERE A.user_id = 'kas0610' AND B.authority = 'ROLE_ROOT';

-- 기본 관리자(kas0610@i-mobilepark.com)를 서비스 루트 그룹에 매핑 시킨다
INSERT INTO `plymind_db`.`tbl_group_member` (
    group_srl, member_srl, c_date
)
SELECT B.group_srl, A.member_srl, A.c_date
FROM `plymind_db`.`tbl_member` A, `plymind_db`.`tbl_group` B
WHERE A.user_id = 'je7646' AND B.authority = 'ROLE_ROOT';

-- 기본 관리자(scss@k-smartcity.kr)를 서비스 루트 그룹에 매핑 시킨다
INSERT INTO `plymind_db`.`tbl_group_member` (
    group_srl, member_srl, c_date
)
SELECT B.group_srl, A.member_srl, A.c_date
FROM `plymind_db`.`tbl_member` A, `plymind_db`.`tbl_group` B
WHERE A.user_id = 'plymind' AND B.authority = 'ROLE_ROOT';



--  앱 생성 ( 플리마인드 생성 )
INSERT INTO `plymind_db`.`tbl_app` (
    app_srl, app_id, app_name, api_key, app_version, api_secret, enabled,
    reg_terminal, reg_push_terminal, push_count, c_date, u_date
) VALUES (
    100, 'plymind', '플리마인드', '8eed6ff9e24943db9cbe93b18f916fc8', '1.0.0', 'b1d2b481fbfb4b0aa9a477e8015ba8b5' , 1,
    0, 0, 0 , UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);


-- 앱(사회적 약자) 관리자 그룹 추가
INSERT INTO `plymind_db`.`tbl_app_group` (
    app_srl, group_name, group_description, group_type, authority, enabled, allow_default, c_date, u_date
) VALUES (
    100, '앱 관리자 그룹', '앱 관리자 그룹 입니다', 1 , 'ROLE_ROOT', 1, 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 앱 정회원 그룹 추가
INSERT INTO `plymind_db`.`tbl_app_group` (
    app_srl, group_name, group_description, group_type, authority, enabled, allow_default, c_date, u_date
) VALUES (
    100, '정회원', '앱의 정회원 그룹 입니다', 1 , 'ROLE_USER', 1, 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);


-- 앱 루트 그룹에 앱 만든 사람 추가
-- member_srl - 1 : wypark
-- member_srl - 2 : kas0610
-- member_srl - 3 : je7646
-- member_srl - 4 : plymind

INSERT INTO `plymind_db`.`tbl_app_group_member` (
    app_group_srl, member_srl, c_date
) VALUES (
    1, 1, UNIX_TIMESTAMP()
);

INSERT INTO `plymind_db`.`tbl_app_group_member` (
    app_group_srl, member_srl, c_date
) VALUES (
    1, 2, UNIX_TIMESTAMP()
);

INSERT INTO `plymind_db`.`tbl_app_group_member` (
    app_group_srl, member_srl, c_date
) VALUES (
    1, 3, UNIX_TIMESTAMP()
);

INSERT INTO `plymind_db`.`tbl_app_group_member` (
    app_group_srl, member_srl, c_date
) VALUES (
    1, 4, UNIX_TIMESTAMP()
);

INSERT INTO `plymind_db`.`tbl_app_group_member` (
    app_group_srl, member_srl, c_date
) VALUES (
    1, 5, UNIX_TIMESTAMP()
);

INSERT INTO `plymind_db`.`tbl_app_group_member` (
    app_group_srl, member_srl, c_date
) VALUES (
    1, 6, UNIX_TIMESTAMP()
);

-- 사회적 약자 --------------------------------------------------------------------------------------------------------------
-- 게시판생성 - srl - 1
INSERT INTO `plymind_db`.`tbl_document_board` (
    board_srl, app_srl, board_name, board_description, enabled, open_type, c_date, u_date
) VALUES (
    1, 100, '게시판', '게시판', 1, 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);
-- 카테고리생성 - 1
INSERT INTO `plymind_db`.`tbl_document_category` (
    category_srl, app_srl, board_srl, category_name, category_description, category_type, enabled, open_type, c_date, u_date
) VALUES (
    1, 100, 1, '1:1문의게시판', '1:1문의게시판 관리', 1 , 1, 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 카테고리생성 - 2
INSERT INTO `plymind_db`.`tbl_document_category` (
    category_srl, app_srl, board_srl, category_name, category_description, category_type, enabled, open_type, c_date, u_date
) VALUES (
    2, 100, 1, '비밀게시판', '비밀게시판 관리', 1 , 1, 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 카테고리생성 - 3
INSERT INTO `plymind_db`.`tbl_document_category` (
    category_srl, app_srl, board_srl, category_name, category_description, category_type, enabled, open_type, c_date, u_date
) VALUES (
    3, 100, 1, '테마게시판', '테마게시판 관리', 1 , 1, 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 카테고리생성 - 4
INSERT INTO `plymind_db`.`tbl_document_category` (
    category_srl, app_srl, board_srl, category_name, category_description, category_type, enabled, open_type, c_date, u_date
) VALUES (
    4, 100, 1, 'FAQ', 'FAQ 관리', 1 , 1, 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 카테고리생성 - 5
INSERT INTO `plymind_db`.`tbl_document_category` (
    category_srl, app_srl, board_srl, category_name, category_description, category_type, enabled, open_type, c_date, u_date
) VALUES (
    5, 100, 1, '공지사항', '공지사항 관리', 1 , 1, 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 카테고리생성 - 6
INSERT INTO `plymind_db`.`tbl_document_category` (
    category_srl, app_srl, board_srl, category_name, category_description, category_type, enabled, open_type, c_date, u_date
) VALUES (
    6, 100, 1, '문의게시판', '문의게시판 관리', 1 , 1, 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 카테고리생성 - 7
INSERT INTO `plymind_db`.`tbl_document_category` (
    category_srl, app_srl, board_srl, category_name, category_description, category_type, enabled, open_type, c_date, u_date
) VALUES (
    7, 100, 1, '단체', '단체 관리', 1 , 1, 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 카테고리생성 - 8
INSERT INTO `plymind_db`.`tbl_document_category` (
    category_srl, app_srl, board_srl, category_name, category_description, category_type, enabled, open_type, c_date, u_date
) VALUES (
    8, 100, 1, '슈퍼바이저', '슈퍼바이저 관리', 1 , 1, 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 카테고리생성 - 9
INSERT INTO `plymind_db`.`tbl_document_category` (
    category_srl, app_srl, board_srl, category_name, category_description, category_type, enabled, open_type, c_date, u_date
) VALUES (
    9, 100, 1, '너나들이', '너나들이 관리', 1 , 1, 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);



-- 템플릿 생성 -----------------------------------------------------------------------------------------------------------

/*
-- 템플릿 생성  템플릿
INSERT INTO `plymind_db`.`tbl_template` (
    template_title, template_content, template_description, c_date, u_date
) VALUES(
    '안심 태그-LoRa',
    '{"name":"text","birthdate":"text","phone":"text","address":"text","type":[{"0":"해당없음"},{"1":"치매노인"},{"2":"지체장애인"},{"3":"초등학교"},{"4":"어린이집"}],"target":[{"0":"해당없음"},{"1":"반석초"},{"2":"반산초"},{"3":"영진어린이집"},{"4":"반여1동 어린이집"}],"version":"text","kind":[{"0":"lora"},{"1":"beacon"},{"2":"nfc"}],"seq":"text","rssi":"text","latitude":"text","longitude":"text","activity":"text","temperature":"text","humidity":"text","heartRate":"text","battery":[{"high":"high"},{"middle":"middle"},{"row":"row"}],"emerency":[{"noraml":"평상시/해제"},{"emerency":"위급상황"}],"gpsStatus":[{"off":"off"},{"on":"on"}],"temphumStatus":[{"off":"off"},{"on":"on"}],"heartRateStatus":[{"off":"off"},{"on":"on"}],"activityStatus":[{"off":"off"},{"on":"on"}],"beaconStatus":[{"off":"off"},{"on":"on"}],"loraPeriod":"text","gpsPeriod":"text","temphumPeriod":"text","heartRatePeriod":"text","beaconPeriod":"text","snr":"text","periodcontainer":[{"2":"미등록"},{"1":"등록"}],"periodurl":[{"2":"미등록"},{"1":"등록"}]}'
    , '안심 태그 템플릿', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);


-- 텝플릿 사용 앱 생성 - 3개의 템플릿에 앱 맵핑
INSERT INTO `plymind_db`.`tbl_app_template` (
    app_srl, template_srl, c_date
) VALUES(
    100, 1,UNIX_TIMESTAMP()
);
*/


