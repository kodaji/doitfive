-- 템플릿 생성 ---------------------------------
-- 슈퍼바이저
INSERT INTO `plymind_db`.`tbl_template` (
    template_title, template_content, template_description, c_date, u_date
) VALUES(
    '슈퍼바이저',
    '{"work":"text","office":"text"}', '슈퍼바이저 등록', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 너나들이
INSERT INTO `plymind_db`.`tbl_template` (
    template_title, template_content, template_description, c_date, u_date
) VALUES(
    '너나들이',
    '{"send":"datetime"}' ,'너나들이 관리', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 1:1 문의게시판
INSERT INTO `plymind_db`.`tbl_template` (
    template_title, template_content, template_description, c_date, u_date
) VALUES(
    '1:1문의게시판',
    '{"application_group":"text","advisor_srl":"text"}' ,'1:1문의게시판 상담or검사 선택', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);


-- 텝플릿 사용 앱 생성 - 템플릿 앱 맵핑
INSERT INTO `plymind_db`.`tbl_app_template` (
    app_srl, template_srl, c_date
) VALUES(
    100, 1,UNIX_TIMESTAMP()
);
INSERT INTO `plymind_db`.`tbl_app_template` (
    app_srl, template_srl, c_date
) VALUES(
    100, 2,UNIX_TIMESTAMP()
);
INSERT INTO `plymind_db`.`tbl_app_template` (
    app_srl, template_srl, c_date
) VALUES(
    100, 3,UNIX_TIMESTAMP()
);
