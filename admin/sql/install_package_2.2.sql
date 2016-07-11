-- 게시물 링크 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_document_link` RESTRICT;
-- 사용자와 앱 매핑
DROP TABLE IF EXISTS `plymind_db`.`tbl_app_member` RESTRICT;
-- 회원형 서비스를 위한 접속 토큰 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_member_access_token` RESTRICT;
-- 게시물, 파일 매핑 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_document_file` RESTRICT;
-- 게시물, 댓글 첨부 파일 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_document_attach` RESTRICT;
-- 게시물, 태그 매핑 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_document_tag` RESTRICT;
-- 게시물 태그 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_tag` RESTRICT;
-- 게시물 댓글 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_document_comment` RESTRICT;
-- 게시물 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_document` RESTRICT;
-- 게시판 카테고리 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_document_category` RESTRICT;
-- 게시판 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_document_board` RESTRICT;
-- 앱, 템플릿 매핑
DROP TABLE IF EXISTS `plymind_db`.`tbl_app_template` RESTRICT;
-- 게시물 템플릿 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_template` RESTRICT;
-- 앱 그룹 사용자 매핑
DROP TABLE IF EXISTS `plymind_db`.`tbl_app_group_member` RESTRICT;
-- 앱 그룹 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_app_group` RESTRICT;
-- 디바이스를 위한 접속 토큰 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_device_access_token` RESTRICT;
-- 파일 저장소
DROP TABLE IF EXISTS `plymind_db`.`tbl_file_repository` RESTRICT;
-- Push 메시지에서 사용되는 파일 매핑 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_push_message_pic` RESTRICT;
-- Push 메시지 이미지
DROP TABLE IF EXISTS `plymind_db`.`tbl_push_pic` RESTRICT;
-- Push 메시지 이력 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_push_message` RESTRICT;
-- 앱 단말기 매핑
DROP TABLE IF EXISTS `plymind_db`.`tbl_app_device` RESTRICT;
-- 유저 프로필 사진 매핑
DROP TABLE IF EXISTS `plymind_db`.`tbl_member_pic` RESTRICT;
-- 유저 프로필 사진
DROP TABLE IF EXISTS `plymind_db`.`tbl_profile_pic` RESTRICT;
-- 사용자, 그룹 매핑
DROP TABLE IF EXISTS `plymind_db`.`tbl_group_member` RESTRICT;
-- 유저 그룹 종류
DROP TABLE IF EXISTS `plymind_db`.`tbl_group` RESTRICT;
-- 유저, 단말기 매핑
DROP TABLE IF EXISTS `plymind_db`.`tbl_member_device` RESTRICT;
-- 서비스 앱 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_app` RESTRICT;
-- 유저 부가 정보
DROP TABLE IF EXISTS `plymind_db`.`tbl_member_extra` RESTRICT;
-- 유저
DROP TABLE IF EXISTS `plymind_db`.`tbl_member` RESTRICT;
-- 안드로이드 디바이스 관리
DROP TABLE IF EXISTS `plymind_db`.`tbl_device` RESTRICT;
-- 서비스 이력
DROP TABLE IF EXISTS `plymind_db`.`tbl_service_history` RESTRICT;
-- 시퀀스
DROP TABLE IF EXISTS `plymind_db`.`tbl_sequence` RESTRICT;


-- 1. 시퀀스
CREATE TABLE `plymind_db`.`tbl_sequence` (
	`seq_type` INT    NOT NULL COMMENT '시퀀스 종류', -- 시퀀스 종류
	`seq_no`   BIGINT NOT NULL COMMENT '프로그래밍 생성 시퀀스 넘버' -- 시퀀스 넘버
)
DEFAULT CHARACTER SET = 'utf8'
DEFAULT COLLATE = 'utf8_general_ci'
ENGINE = InnoDB
COMMENT '프로그래밍 생성 시퀀스 테이블';

-- 시퀀스
ALTER TABLE `plymind_db`.`tbl_sequence`
	ADD CONSTRAINT `PK_tbl_sequence` -- 시퀀스 기본키
		PRIMARY KEY (
			`seq_type` -- 시퀀스 종류
		);



-- 2. 서비스 이력
CREATE TABLE `plymind_db`.`tbl_service_history` (
  `history_srl`     BIGINT(11)   NOT NULL COMMENT '이력 시리얼 넘버', -- 이력 시리얼 넘버
  `c_date`          INT          NOT NULL COMMENT '생성일', -- 생성일
  `history_type`    INT          NOT NULL COMMENT '이력 종류. 1:유저 관리 이력, 2:유저 그룹 이력', -- 이력 종류
  `member_srl`      BIGINT(11)   NOT NULL COMMENT '유저 시리얼 넘버. 만일 값을 구할 수 없으면 -1을 사용 한다', -- 유저 시리얼 넘버
  `history_content` TEXT         NOT NULL COMMENT '활동 이력 내용', -- 활동 이력
  `history_url`     VARCHAR(256) NULL     COMMENT '이력 접근 경로(스킴 포함. add://document/1 이렇게 사용)', -- 새 컬럼
  `ipaddress`       CHAR(16)     NOT NULL COMMENT '유저 사용 아이피' -- 활동 아이피
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '서비스 전체 이력 테이블'
  PARTITION BY
  RANGE COLUMNS (`c_date`)
  (
  PARTITION `p201503`
  VALUES LESS THAN (1427814000),
  PARTITION `p201504`
  VALUES LESS THAN (1430406000),
  PARTITION `p201505`
  VALUES LESS THAN (1433084400)
  );

-- 서비스 이력
ALTER TABLE `plymind_db`.`tbl_service_history`
ADD CONSTRAINT `PK_tbl_service_history` -- 서비스 이력 기본키
PRIMARY KEY (
    `history_srl`, -- 이력 시리얼 넘버
    `c_date`       -- 생성일
  );

-- 서비스 이력 인덱스
CREATE INDEX `IX_tbl_service_history`
ON `plymind_db`.`tbl_service_history`( -- 서비스 이력
  `history_type` ASC -- 이력 종류
);

-- 서비스 이력 인덱스2
CREATE INDEX `IX_tbl_service_history2`
ON `plymind_db`.`tbl_service_history`( -- 서비스 이력
  `member_srl` ASC -- 유저 시리얼 넘버
);

-- 서비스 이력 인덱스3
CREATE INDEX `IX_tbl_service_history3`
ON `plymind_db`.`tbl_service_history`( -- 서비스 이력
  `c_date` ASC -- 생성일
);



-- 3. 디바이스 관리
CREATE TABLE `plymind_db`.`tbl_device` (
  `device_srl`          BIGINT       NOT NULL COMMENT '단말기 시리얼 넘버', -- 단말기 시리얼 넘버
  `device_id`           VARCHAR(64)  NOT NULL COMMENT '안드로이드 단말기 아이디. 유저와 매핑 할 수 있는 값', -- 단말기 아이디
  `device_type`         VARCHAR(128) NULL     COMMENT '단말기 종류(벤더-모델명)', -- 단말기 종류
  `device_class`        TINYINT      NOT NULL DEFAULT 1 COMMENT '단말기 구분. 1:Android, 2:iOS', -- 단말기 구분
  `os_version`          VARCHAR(32)  NULL     COMMENT '단말기 OS 버전', -- 안드로이드 버전
  `mobile_phone_number` VARCHAR(16)  NULL     COMMENT '휴대폰 번호', -- 휴대폰 번호
  `c_date`              INT          NOT NULL COMMENT '생성일', -- 생성일
  `u_date`              INT          NOT NULL COMMENT '수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '단말기 테이블';

-- 디바이스 관리
ALTER TABLE `plymind_db`.`tbl_device`
ADD CONSTRAINT `PK_tbl_device` -- 디바이스 관리 기본키
PRIMARY KEY (
    `device_srl` -- 단말기 시리얼 넘버
  );

-- 디바이스 관리 인덱스
CREATE INDEX `IX_tbl_device`
ON `plymind_db`.`tbl_device`( -- 디바이스 관리
  `device_type` ASC -- 단말기 종류
);

-- 디바이스 관리 인덱스2
CREATE INDEX `IX_tbl_device2`
ON `plymind_db`.`tbl_device`( -- 디바이스 관리
  `os_version` ASC -- 안드로이드 버전
);

-- 디바이스 관리 인덱스3
CREATE INDEX `IX_tbl_device3`
ON `plymind_db`.`tbl_device`( -- 디바이스 관리
  `mobile_phone_number` ASC -- 휴대폰 번호
);

-- 디바이스 관리 인덱스4
CREATE INDEX `IX_tbl_device4`
ON `plymind_db`.`tbl_device`( -- 디바이스 관리
  `device_id` ASC -- 단말기 아이디
);

ALTER TABLE `plymind_db`.`tbl_device`
MODIFY COLUMN `device_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '단말기 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_device`
AUTO_INCREMENT = 1;



-- 4. 유저
CREATE TABLE `plymind_db`.`tbl_member` (
  `member_srl`           BIGINT(11)   NOT NULL COMMENT '유저 시리얼 넘버', -- 유저 시리얼 넘버
  `user_id`              VARCHAR(128) NOT NULL COMMENT '유저 아이디', -- 아이디
  `email_address`        VARCHAR(128) NULL     COMMENT '유저 이메일 주소', -- 이메일
  `user_password`        VARCHAR(128) NOT NULL COMMENT '유저 패스워드', -- 패스워드
  `user_name`            VARCHAR(64)  NOT NULL COMMENT '유저 성명', -- 이름
  `nick_name`            VARCHAR(64)  NOT NULL COMMENT '유저 별명. 별명이 없으면 성명과 동일한 값으로 사용', -- 별명
  `mobile_phone_number`  VARCHAR(16)  NOT NULL COMMENT '유저 휴대폰 대표 번호. 번호사이에 dash를 사용하지 않음. 번호만 입력. 번호가 없으면 empty string 사용', -- 휴대폰 번호
  `allow_mailing`        TINYINT      NOT NULL DEFAULT 1 COMMENT '메일링 허용 여부. 1:허용, 2:비허용', -- 메일링 허용 여부
  `allow_message`        TINYINT      NOT NULL DEFAULT 1 COMMENT 'GCM, SMS 등등의 메시징 허용 여부. 1:허용, 2:비허용', -- 메시징 허용 여부
  `description`          VARCHAR(256) NULL     COMMENT '유저에 대한 설명', -- 설명
  `last_login_date`      INT          NOT NULL COMMENT '유저의 최종 로그인 시간', -- 최종 로그인 시간
  `change_password_date` INT          NOT NULL COMMENT '유저의 패스워드 변경 최종 시간', -- 패스워드 변경 시간
  `enabled`              TINYINT      NOT NULL DEFAULT 1 COMMENT '유저 계정의 활성 여부. 일시 중지/차단등에 사용하면 됨. 1:활성, 2:일시중단, 3:차단', -- 활성 여부
  `email_confirm`        TINYINT      NOT NULL DEFAULT 2 COMMENT '유저 이메일 주소 확인 여부. 1:확인됨, 2:미확인', -- 메일 주소 확인 여부
  `sign_out`             TINYINT      NOT NULL DEFAULT 2 COMMENT '유저 탈퇴 여부. 1:탈퇴, 2:미탈퇴', -- 탈퇴 여부
  `c_date`               INT          NOT NULL COMMENT '유저 가입 날짜', -- 생성일
  `u_date`               INT          NOT NULL COMMENT '유저 메인 정보 수정 날짜' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '유저 관리 테이블';

-- 유저
ALTER TABLE `plymind_db`.`tbl_member`
ADD CONSTRAINT `PK_tbl_member` -- 유저 기본키
PRIMARY KEY (
    `member_srl` -- 유저 시리얼 넘버
  );

-- 유저 유니크 인덱스
CREATE UNIQUE INDEX `UIX_tbl_member`
ON `plymind_db`.`tbl_member` ( -- 유저
  `user_id` ASC -- 아이디
);

-- 유저 인덱스
CREATE INDEX `IX_tbl_member`
ON `plymind_db`.`tbl_member`( -- 유저
  `user_name` ASC -- 이름
);

-- 유저 인덱스2
CREATE INDEX `IX_tbl_member2`
ON `plymind_db`.`tbl_member`( -- 유저
  `mobile_phone_number` ASC -- 휴대폰 번호
);

-- 유저 인덱스3
CREATE INDEX `IX_tbl_member3`
ON `plymind_db`.`tbl_member`( -- 유저
  `nick_name` ASC -- 별명
);

-- 유저 인덱스4
CREATE INDEX `IX_tbl_member4`
ON `plymind_db`.`tbl_member`( -- 유저
  `c_date` ASC -- 생성일
);

ALTER TABLE `plymind_db`.`tbl_member`
MODIFY COLUMN `member_srl` BIGINT(11) NOT NULL AUTO_INCREMENT COMMENT '유저 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_member`
AUTO_INCREMENT = 1;



-- 5. 유저 부가 정보
CREATE TABLE `plymind_db`.`tbl_member_extra` (
  `member_srl`         BIGINT(11)  NOT NULL COMMENT '유저 시리얼 넘버', -- 유저 시리얼 넘버
  `social_type`        TINYINT     NOT NULL DEFAULT -1 COMMENT '가입시 사용한 소셜 타입. -1: 없음, 1:카카오톡, 2:페이스북, 3:트위터, 4:구글', -- 소셜 타입
  `social_id`          VARCHAR(64) NULL     COMMENT '연동된 소셜에서 받은 유닉 아이디', -- 소셜 아이디
  `login_count`        BIGINT(11)  NOT NULL DEFAULT 1 COMMENT '유저의 총 로그인 카운트', -- 총 로그인 카운트
  `serial_login_count` INT         NOT NULL DEFAULT 1 COMMENT '유저의 연속 로그인(1일 기준) 카운트', -- 연속 로그인 카운트
  `allow_temperature`  TINYINT(4)  DEFAULT 1 COMMENT '이상 온도 알림 설정', -- 이상 온도 알림 설정
  `allow_distance`     TINYINT(4)  DEFAULT 1 COMMENT '이격 거리 알림 설정', -- 이격 거리 알림 설정
  `allow_battery`      TINYINT(4)  DEFAULT 1 COMMENT '배터리 알림 설정', -- 배터리 알림 설정
  `allow_call`         TINYINT(4)  DEFAULT 1 COMMENT '긴급 호출 알림 설정', -- 긴급 호출 알림 설정
  `c_date`             INT         NOT NULL COMMENT '생성일', -- 생성일
  `u_date`             INT         NOT NULL COMMENT '수정일', -- 수정일
  `group_gubun`        TINYINT(4)  DEFAULT 1 COMMENT '단체 구분', -- 단체 구분
  `user_group_srl`     BIGINT(11)            COMMENT '단체 시리얼넘버', -- 단체 시리얼넘버
  `birthday`           VARCHAR(8)             COMMENT '생년월일', -- 생년월일
  `job`                VARCHAR(128)         COMMENT '직업', -- 직업
  `marriage`           TINYINT(4)  DEFAULT 1  COMMENT '결혼 유무', -- 결혼 유무
  `children`           VARCHAR(8)             COMMENT '자녀 수', -- 자녀 수
  `religion`           TINYINT(4)  DEFAULT 1  COMMENT '종교 유무', -- 종교 유무
  `religion_name`      VARCHAR(64)            COMMENT '종교 이름', -- 종교 이름
  `disability`         TINYINT(4)  DEFAULT 1  COMMENT '장애 유무', -- 장애 유무
  `disability_type`    VARCHAR(128)           COMMENT '장애 유형', -- 장애 유형
  `disability_rate`    VARCHAR(64)            COMMENT '장애 등급', -- 장애 등급
  `academic_srl`       BIGINT(11)             COMMENT '학력', -- 학력
  `gender`             TINYINT(4)  DEFAULT 1  COMMENT '성별', -- 성별
  `certificate`        VARCHAR(64)            COMMENT '자격증명(자격증번호)', -- 자격증명(자격증번호)
  `kakao_id`           VARCHAR(128)           COMMENT '카카오 아이디', -- 카카오아이디
  `self_introduction`  VARCHAR(512)           COMMENT '자기소개', -- 자기소개
  `class_srl`          BIGINT(11)             COMMENT '등급', -- 등급
  `domain_srl`         TINYINT(4)             COMMENT '상담영역', -- 상담영역
  `advisor_class`      TINYINT(4)
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '유저 부가 정보 테이블';

-- 유저 부가 정보
ALTER TABLE `plymind_db`.`tbl_member_extra`
ADD CONSTRAINT `PK_tbl_member_extra` -- 유저 부가 정보 기본키
PRIMARY KEY (
    `member_srl` -- 유저 시리얼 넘버
  );

-- 유저 부가 정보 인덱스
CREATE INDEX `IX_tbl_member_extra`
ON `plymind_db`.`tbl_member_extra`( -- 유저 부가 정보
  `social_type` ASC -- 소셜 타입
);

-- 유저 부가 정보 인덱스2
CREATE INDEX `IX_tbl_member_extra2`
ON `plymind_db`.`tbl_member_extra`( -- 유저 부가 정보
  `social_id` ASC -- 소셜 아이디
);

-- 유저 부가 정보
ALTER TABLE `plymind_db`.`tbl_member_extra`
ADD CONSTRAINT `FK_tbl_member_TO_tbl_member_extra` -- 유저 -> 유저 부가 정보
FOREIGN KEY (
    `member_srl` -- 유저 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_member` ( -- 유저
    `member_srl` -- 유저 시리얼 넘버
  )
  ON DELETE CASCADE;



-- 6. 서비스 앱 테이블
CREATE TABLE `plymind_db`.`tbl_app` (
  `app_srl`           INT          NOT NULL COMMENT '앱 시리얼 넘버', -- 앱 시리얼 넘버
  `app_id`            VARCHAR(128) NOT NULL COMMENT '앱 아이디', -- 앱 아이디
  `app_name`          VARCHAR(64)  NOT NULL COMMENT '앱 이름', -- 앱 이름
  `api_key`           VARCHAR(32)  NOT NULL COMMENT '앱의 구분키. 동일한 앱은 동일한 키를 가진다(버전 대비용)', -- API Key
  `app_version`       VARCHAR(16)  NOT NULL COMMENT '앱 버전', -- 앱 버전
  `api_secret`        VARCHAR(32)  NOT NULL COMMENT '앱의 인증키. 동일한 앱은 동일한 키를 가진다(버전 대비용)', -- API Secret
  `enabled`           TINYINT      NOT NULL DEFAULT 1 COMMENT '앱의 활성 여부. 1:활성, 2:서비스 일시 중단, 3:차단', -- 활성 여부
  `reg_terminal`      BIGINT       NOT NULL DEFAULT 0 COMMENT '등록된 단말기의 총 카운트', -- 등록 단말 카운트
  `reg_push_terminal` BIGINT       NOT NULL DEFAULT 0 COMMENT '등록된 단말기 중 Push ID(GCM_RID 등등) 가 존재하는 단말기 카운트', -- Push ID 등록 단말 카운트
  `push_count`        BIGINT       NULL     DEFAULT 0 COMMENT '메시지를 Push 한 횟수', -- 메시지 Push 횟수
  `c_date`            INT          NOT NULL COMMENT '생성일', -- 생성일
  `u_date`            INT          NOT NULL COMMENT '수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '서비스 하는 앱 테이블';

-- 서비스하는 앱
ALTER TABLE `plymind_db`.`tbl_app`
ADD CONSTRAINT `PK_tbl_app` -- 서비스하는 앱 기본키
PRIMARY KEY (
    `app_srl` -- 앱 시리얼 넘버
  );

-- 서비스하는 앱 유니크 인덱스
CREATE UNIQUE INDEX `UIX_tbl_app`
ON `plymind_db`.`tbl_app` ( -- 서비스하는 앱
                           `api_key` ASC,     -- API Key
                           `app_version` ASC  -- 앱 버전
);

-- 서비스하는 앱 유니크 인덱스2
CREATE UNIQUE INDEX `UIX_tbl_app2`
ON `plymind_db`.`tbl_app` ( -- 서비스하는 앱
  `app_id` ASC -- 앱 아이디
);

-- 서비스하는 앱 인덱스2
CREATE INDEX `IX_tbl_app2`
ON `plymind_db`.`tbl_app`( -- 서비스하는 앱
  `app_name` ASC -- 앱 이름
);

ALTER TABLE `plymind_db`.`tbl_app`
MODIFY COLUMN `app_srl` INT NOT NULL AUTO_INCREMENT COMMENT '앱 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_app`
AUTO_INCREMENT = 2048;



-- 7. 유저, 단말기 매핑
CREATE TABLE `plymind_db`.`tbl_member_device` (
  `app_srl`             INT         NOT NULL COMMENT '앱 시리얼 넘버', -- 앱 시리얼 넘버
  `member_srl`          BIGINT      NOT NULL COMMENT '유저 시리얼 넘버(비가입자라면 -1 값을 사용)', -- 유저 시리얼 넘버
  `device_srl`          BIGINT      NOT NULL COMMENT '단말기 시리얼 너버(각 단말기 테이블의 device_srl)', -- 단말기 시리얼 넘버
  `mobile_phone_number` VARCHAR(16) NOT NULL COMMENT '단말기 전화 번호. 존재하지 않으면 empty string 사용', -- 휴대폰 번호
  `allow_push_noti`     TINYINT     NOT NULL COMMENT 'GCM, APNS 수신 허용 여부. 1:허용, 2:비허용', -- Push Noti 수신 허용 여부
  `push_noti_type`      TINYINT     NOT NULL DEFAULT 1 COMMENT 'Push Noti의 형태. 1:소리, 2:진동, 99:무음', -- Push Noti 사운드 형태
  `c_date`              INT         NOT NULL COMMENT '생성일', -- 생성일
  `u_date`              INT         NOT NULL COMMENT '수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '사용자 단말기 매핑 테이블';

-- 유저, 단말기 매핑
ALTER TABLE `plymind_db`.`tbl_member_device`
ADD CONSTRAINT `PK_tbl_member_device` -- 유저, 단말기 매핑 기본키
PRIMARY KEY (
    `app_srl`,    -- 앱 시리얼 넘버
    `member_srl`, -- 유저 시리얼 넘버
    `device_srl`  -- 단말기 시리얼 넘버
  );

-- 유저, 단말기 매핑 인덱스2
CREATE INDEX `IX_tbl_member_device2`
ON `plymind_db`.`tbl_member_device`( -- 유저, 단말기 매핑
  `device_srl` ASC -- 단말기 시리얼 넘버
);

-- 유저, 단말기 매핑 인덱스3
CREATE INDEX `IX_tbl_member_device3`
ON `plymind_db`.`tbl_member_device`( -- 유저, 단말기 매핑
  `member_srl` ASC -- 유저 시리얼 넘버
);

-- 유저, 단말기 매핑
ALTER TABLE `plymind_db`.`tbl_member_device`
ADD CONSTRAINT `FK_tbl_app_TO_tbl_member_device` -- 서비스하는 앱 -> 유저, 단말기 매핑
FOREIGN KEY (
    `app_srl` -- 앱 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_app` ( -- 서비스하는 앱
    `app_srl` -- 앱 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_app_TO_tbl_member_device` (
  `app_srl` ASC -- 앱 시리얼 넘버
);



-- 8. 유저 그룹 종류
CREATE TABLE `plymind_db`.`tbl_group` (
  `group_srl`     INT          NOT NULL COMMENT '그룹 시리얼 넘버', -- 그룹 시리얼 넘버
  `group_name`    VARCHAR(128) NOT NULL COMMENT '그룹명', -- 그룹명
  `allow_default` TINYINT      NOT NULL DEFAULT 2 COMMENT '기본 그룹(가입시 특정 조건 없으면 기본으로 포함될 그룹) 여부. 1:기본그룹, 2:기본 그룹 아님', -- 기본 그룹 여부
  `authority`     VARCHAR(16)  NOT NULL DEFAULT 'ROLE_VISITOR' COMMENT '그룹 권한. ROLE_ROOT:루트 권한, ROLE_USER:가입자 권한, ROLE_VISITOR:방문자 권한', -- 그룹 권한
  `description`   VARCHAR(256) NULL     COMMENT '그룹 설명', -- 설명
  `c_date`        INT          NOT NULL COMMENT '생성일', -- 생성일
  `u_date`        INT          NOT NULL COMMENT '수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '사용자 그룹 테이블';

-- 유저 그룹 종류
ALTER TABLE `plymind_db`.`tbl_group`
ADD CONSTRAINT `PK_tbl_group` -- 유저 그룹 종류 기본키
PRIMARY KEY (
    `group_srl` -- 그룹 시리얼 넘버
  );

-- 유저 그룹 종류 인덱스
CREATE INDEX `IX_tbl_group`
ON `plymind_db`.`tbl_group`( -- 유저 그룹 종류
  `authority` ASC -- 그룹 권한
);

ALTER TABLE `plymind_db`.`tbl_group`
MODIFY COLUMN `group_srl` INT NOT NULL AUTO_INCREMENT COMMENT '그룹 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_group`
AUTO_INCREMENT = 1;



-- 9. 사용자, 그룹 매핑
CREATE TABLE `plymind_db`.`tbl_group_member` (
  `group_srl`  INT    NOT NULL COMMENT '그룹 시리얼 넘버', -- 그룹 시리얼 넘버
  `member_srl` BIGINT NOT NULL COMMENT '유저 시리얼 넘버', -- 유저 시리얼 넘버
  `c_date`     INT    NOT NULL COMMENT '생성일' -- 생성일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '사용자의 그룹 매핑 테이블';

-- 사용자, 그룹 매핑
ALTER TABLE `plymind_db`.`tbl_group_member`
ADD CONSTRAINT `PK_tbl_group_member` -- 사용자, 그룹 매핑 기본키
PRIMARY KEY (
    `group_srl`,  -- 그룹 시리얼 넘버
    `member_srl`  -- 유저 시리얼 넘버
  );

-- 사용자, 그룹 매핑
ALTER TABLE `plymind_db`.`tbl_group_member`
ADD CONSTRAINT `FK_tbl_group_TO_tbl_group_member` -- 유저 그룹 종류 -> 사용자, 그룹 매핑
FOREIGN KEY (
    `group_srl` -- 그룹 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_group` ( -- 유저 그룹 종류
    `group_srl` -- 그룹 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_group_TO_tbl_group_member` (
  `group_srl` ASC -- 그룹 시리얼 넘버
);

-- 사용자, 그룹 매핑
ALTER TABLE `plymind_db`.`tbl_group_member`
ADD CONSTRAINT `FK_tbl_member_TO_tbl_group_member` -- 유저 -> 사용자, 그룹 매핑
FOREIGN KEY (
    `member_srl` -- 유저 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_member` ( -- 유저
    `member_srl` -- 유저 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_member_TO_tbl_group_member` (
  `member_srl` ASC -- 유저 시리얼 넘버
);



-- 10. 유저 프로필 사진
CREATE TABLE `plymind_db`.`tbl_profile_pic` (
  `file_srl`     BIGINT       NOT NULL COMMENT '파일 시리얼 넘버', -- 파일 시리얼 넘버
  `orig_name`    VARCHAR(128) NULL     COMMENT '원본 파일의 파일명. 외부 이미지라면 empty string', -- 원본 파일명
  `file_size`    BIGINT       NOT NULL DEFAULT -1 COMMENT '원본 파일의 파일 크기(바이트 단위). 외부 이미지라면 0', -- 원본 파일 크기
  `file_path`    VARCHAR(256) NULL     COMMENT '원본 파일의 서버에서 저장 경로. 외부 이미지라면 empty string', -- 원본 파일 저장 경로
  `file_url`     VARCHAR(256) NOT NULL COMMENT '도메인을 제외한 원본 파일의 접근 URL. 외부 이미지라면 도메인 포함한 전체 URL', -- 원본 파일 접근 상대 주소
  `width`        INT          NOT NULL DEFAULT -1 COMMENT '원본 파일의 이미지 너비. 외부 이미지라면 0', -- 원본 이미지 너비
  `height`       INT          NOT NULL DEFAULT -1 COMMENT '원본 파일의 이미지 높이. 외부 이미지라면 0', -- 원본 이미지 높이
  `thumb_path`   VARCHAR(256) NULL     COMMENT '썸네일 파일의 서버에서 저장 경로', -- 썸네일 파일 저장 경로
  `thumb_url`    VARCHAR(256) NULL     COMMENT '도메인을 제외한 썸네일 파일의 접근 URL', -- 썸네일 파일 접근 상대 주소
  `thumb_width`  INT          NOT NULL DEFAULT -1 COMMENT '썸네일 파일의 이미지 너비', -- 썸네일 파일 이미지 너비
  `thumb_height` INT          NOT NULL DEFAULT -1 COMMENT '썸네일 파일의 이미지 높이', -- 썸네일 파일 이미지 높이
  `ipaddress`    CHAR(16)     NULL     COMMENT '파일 업로드한 아이피 주소', -- 파일 업로드 아이피 주소
  `deleted`      TINYINT      NOT NULL DEFAULT 2 COMMENT '파일의 삭제 여부. 물리 파일 삭제 용도. 1:삭제, 2:삭제하면 안됨', -- 파일 삭제 여부
  `c_date`       INT          NOT NULL COMMENT '파일 정보의 생성일', -- 생성일
  `u_date`       INT          NOT NULL COMMENT '파일 정보의 수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '유저 프로필 사진 테이블';

-- 유저 프로필 사진
ALTER TABLE `plymind_db`.`tbl_profile_pic`
ADD CONSTRAINT `PK_tbl_profile_pic` -- 유저 프로필 사진 기본키
PRIMARY KEY (
    `file_srl` -- 파일 시리얼 넘버
  );

-- 유저 프로필 사진 인덱스
CREATE INDEX `IX_tbl_profile_pic`
ON `plymind_db`.`tbl_profile_pic`( -- 유저 프로필 사진
  `orig_name` ASC -- 원본 파일명
);

ALTER TABLE `plymind_db`.`tbl_profile_pic`
MODIFY COLUMN `file_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '파일 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_profile_pic`
AUTO_INCREMENT = 1;



-- 11. 유저 프로필 사진 매핑
CREATE TABLE `plymind_db`.`tbl_member_pic` (
  `member_srl` BIGINT(11) NOT NULL COMMENT '유저 시리얼 넘버', -- 유저 시리얼 넘버
  `file_srl`   BIGINT(11) NOT NULL COMMENT '파일 시리얼 넘버', -- 파일 시리얼 넘버
  `c_date`     INT        NOT NULL COMMENT '생성일' -- 생성일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '유저 프로필 사진 매핑';

-- 유저 프로필 사진 매핑
ALTER TABLE `plymind_db`.`tbl_member_pic`
ADD CONSTRAINT `PK_tbl_member_pic` -- 유저 프로필 사진 매핑 기본키
PRIMARY KEY (
    `member_srl`, -- 유저 시리얼 넘버
    `file_srl`    -- 파일 시리얼 넘버
  );

-- 유저 프로필 사진 매핑
ALTER TABLE `plymind_db`.`tbl_member_pic`
ADD CONSTRAINT `FK_tbl_member_TO_tbl_member_pic` -- 유저 -> 유저 프로필 사진 매핑
FOREIGN KEY (
    `member_srl` -- 유저 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_member` ( -- 유저
    `member_srl` -- 유저 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_member_TO_tbl_member_pic` (
  `member_srl` ASC -- 유저 시리얼 넘버
);

-- 유저 프로필 사진 매핑
ALTER TABLE `plymind_db`.`tbl_member_pic`
ADD CONSTRAINT `FK_tbl_profile_pic_TO_tbl_member_pic` -- 유저 프로필 사진 -> 유저 프로필 사진 매핑
FOREIGN KEY (
    `file_srl` -- 파일 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_profile_pic` ( -- 유저 프로필 사진
    `file_srl` -- 파일 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_profile_pic_TO_tbl_member_pic` (
  `file_srl` ASC -- 파일 시리얼 넘버
);



-- 12. 앱 단말기 매핑
CREATE TABLE `plymind_db`.`tbl_app_device` (
  `app_srl`     INT     NOT NULL COMMENT '앱 시리얼 넘버', -- 앱 시리얼 넘버
  `device_srl`  BIGINT  NOT NULL COMMENT '단말기 시리얼 넘버', -- 단말기 시리얼 넘버
  `push_id`     TEXT    NULL     COMMENT 'GCM, APNs를 위한 Push ID(device token)', -- Push ID
  `reg_push_id` TINYINT NOT NULL DEFAULT 2 COMMENT 'Push ID(device_token) 등록 여부. 1:등록됨, 2:등록되지 않음', -- Push ID 등록 여부
  `allow_push`  TINYINT NOT NULL DEFAULT 1 COMMENT 'GCM, APNs 발송 허용 여부. 1:허용, 2:비허용', -- Push 발송 허용 여부
  `enabled`     TINYINT NOT NULL DEFAULT 1 COMMENT '활성 여부. 1:활성, 2:일시중단, 3:차단', -- 활성 여부
  `c_date`      INT     NOT NULL COMMENT '생성일', -- 생성일
  `u_date`      INT     NOT NULL COMMENT '수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT 'app을 사용하는 단말기 매핑';

-- 앱 단말기 매핑
ALTER TABLE `plymind_db`.`tbl_app_device`
ADD CONSTRAINT `PK_tbl_app_device` -- 앱 단말기 매핑 기본키
PRIMARY KEY (
    `app_srl`,    -- 앱 시리얼 넘버
    `device_srl`  -- 단말기 시리얼 넘버
  );

-- 앱 단말기 매핑 인덱스
CREATE INDEX `IX_tbl_app_device`
ON `plymind_db`.`tbl_app_device`( -- 앱 단말기 매핑
  `device_srl` ASC -- 단말기 시리얼 넘버
);

-- 앱 단말기 매핑 인덱스2
CREATE INDEX `IX_tbl_app_device2`
ON `plymind_db`.`tbl_app_device`( -- 앱 단말기 매핑
  `c_date` ASC -- 생성일
);

-- 앱 단말기 매핑
ALTER TABLE `plymind_db`.`tbl_app_device`
ADD CONSTRAINT `FK_tbl_app_TO_tbl_app_device` -- 서비스하는 앱 -> 앱 단말기 매핑
FOREIGN KEY (
    `app_srl` -- 앱 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_app` ( -- 서비스하는 앱
    `app_srl` -- 앱 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_app_TO_tbl_app_device` (
  `app_srl` ASC -- 앱 시리얼 넘버
);



-- 13. Push 메시지 이력 테이블
CREATE TABLE `plymind_db`.`tbl_push_message` (
  `push_srl`         BIGINT       NOT NULL COMMENT 'Push 메시지 시리얼 넘버', -- Push 시리얼 넘버
  `app_srl`          INT          NOT NULL COMMENT 'Push 메시지를 보낸 앱 시리얼 넘버', -- 앱 시리얼 넘버
  `user_id`          VARCHAR(128) NOT NULL COMMENT 'Push 메시지 작성한 사용자', -- Push 메시지 작성자
  `push_title`       VARCHAR(128) NOT NULL COMMENT 'Push 메시지 제목', -- Push 제목
  `push_text`        TEXT         NULL     COMMENT 'Push 메시지 본문', -- Push 본문
  `callback_url`     VARCHAR(256) NULL     COMMENT 'Push 메시지에서 포함하는 callback URL. 유저값으로 사용', -- callback URL
  `push_target`      VARCHAR(64)  NOT NULL COMMENT 'Push 대상자. ALL-TARGET: 전체, 단말그룹명: 특정 그룹 대상, Push ID: 특정 ID 단일', -- Push 대상
  `total_count`      BIGINT       NULL     DEFAULT 0 COMMENT 'Push 메시지를 받을 대상자 전체 카운트. 0 이면 화면에서는 카운팅 중이라고 보여 주면 됨', -- 전체 Push 대상 카운트
  `total_real_count` BIGINT       NULL     DEFAULT 0 COMMENT 'Push 메시지를 받을 실제 대상자 전체 카운트. 앱을 삭제한 대상자는 total_count 에는 포함되지만 total_real_count에는 포함되지 않음', -- 유효 Push 대상 카운트
  `success_count`    BIGINT       NULL     DEFAULT 0 COMMENT 'Push 메시지 발송 성공 대상자 카운트', -- Push 발송 성공 카운트
  `fail_count`       BIGINT       NULL     DEFAULT 0 COMMENT 'Push 메시지 발송 실패 대상자 카운트', -- Push 발송 실패 카운트
  `fail_real_count`  BIGINT       NULL     DEFAULT 0 COMMENT 'Push 메시지 발송 실제 실패 대상자 카운트. 앱을 삭제한 대상자는 fail_count 에는 포함되지만, fail_real_count에는 포함되지 않음', -- Push 발송 유효 실패 카운트
  `received_count`   BIGINT       NULL     DEFAULT 0 COMMENT 'Push 메시지 대상 단말에 정상적으로 수신한 카운트. 앱에서 push 메시지 받고 바로 올려 메시지 수신했다고 알려 주었을때 증가', -- 단말 Push 수신 카운트
  `confirm_count`    BIGINT       NULL     DEFAULT 0 COMMENT 'Push 메시지 수신 이후 확인한 대상자 카운트. 앱에서 push 메시지 받고 push 메시지로 앱을 실행 시켰을때 증가', -- Push 로 인한 앱 실행 카운트
  `c_date`           INT          NOT NULL COMMENT 'Push 메시지 생성일', -- 생성일
  `u_date`           INT          NOT NULL COMMENT '수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT 'Push 이력 테이블';

-- Push 메시지 이력 테이블
ALTER TABLE `plymind_db`.`tbl_push_message`
ADD CONSTRAINT `PK_tbl_push_message` -- Push 메시지 이력 테이블 기본키
PRIMARY KEY (
    `push_srl` -- Push 시리얼 넘버
  );

ALTER TABLE `plymind_db`.`tbl_push_message`
MODIFY COLUMN `push_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'Push 메시지 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_push_message`
AUTO_INCREMENT = 1;

-- Push 메시지 이력 테이블
ALTER TABLE `plymind_db`.`tbl_push_message`
ADD CONSTRAINT `FK_tbl_app_TO_tbl_push_message` -- 서비스하는 앱 -> Push 메시지 이력 테이블
FOREIGN KEY (
    `app_srl` -- 앱 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_app` ( -- 서비스하는 앱
    `app_srl` -- 앱 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_app_TO_tbl_push_message` (
  `app_srl` ASC -- 앱 시리얼 넘버
);



-- 14. Push 메시지 이미지
CREATE TABLE `plymind_db`.`tbl_push_pic` (
  `file_srl`     BIGINT       NOT NULL COMMENT '파일 시리얼 넘버', -- 파일 시리얼 넘버
  `orig_name`    VARCHAR(128) NULL     COMMENT '원본 파일의 파일명', -- 원본 파일명
  `file_size`    BIGINT       NOT NULL DEFAULT -1 COMMENT '원본 파일의 파일 크기(바이트 단위)', -- 원본 파일 크기
  `file_path`    VARCHAR(256) NULL     COMMENT '원본 파일의 서버에서 저장 경로', -- 원본 파일 저장 경로
  `file_url`     VARCHAR(256) NOT NULL COMMENT '도메인을 제외한 원본 파일의 접근 URL', -- 원본 파일 접근 상대 주소
  `width`        INT          NOT NULL DEFAULT -1 COMMENT '원본 파일의 이미지 너비', -- 원본 이미지 너비
  `height`       INT          NOT NULL DEFAULT -1 COMMENT '원본 파일의 이미지 높이', -- 원본 이미지 높이
  `thumb_path`   VARCHAR(256) NULL     COMMENT '썸네일 파일의 서버에서 저장 경로', -- 썸네일 파일 저장 경로
  `thumb_url`    VARCHAR(256) NULL     COMMENT '도메인을 제외한 썸네일 파일의 접근 URL', -- 썸네일 파일 접근 상대 주소
  `thumb_width`  INT          NOT NULL DEFAULT -1 COMMENT '썸네일 파일의 이미지 너비', -- 썸네일 파일 이미지 너비
  `thumb_height` INT          NOT NULL DEFAULT -1 COMMENT '썸네일 파일의 이미지 높이', -- 썸네일 파일 이미지 높이
  `ipaddress`    CHAR(16)     NULL     COMMENT '파일 업로드한 아이피 주소', -- 파일 업로드 아이피 주소
  `deleted`      TINYINT      NOT NULL DEFAULT 2 COMMENT '파일의 삭제 여부. 물리 파일 삭제 용도. 1:삭제, 2:삭제하면 안됨', -- 파일 삭제 여부
  `c_date`       INT          NOT NULL COMMENT '파일 정보의 생성일', -- 생성일
  `u_date`       INT          NOT NULL COMMENT '파일 정보의 수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT 'Push용 메시지에서 사용할 이미지 테이블';

-- Push 메시지 이미지
ALTER TABLE `plymind_db`.`tbl_push_pic`
ADD CONSTRAINT `PK_tbl_push_pic` -- Push 메시지 이미지 기본키
PRIMARY KEY (
    `file_srl` -- 파일 시리얼 넘버
  );

-- Push 메시지 이미지 인덱스
CREATE INDEX `IX_tbl_push_pic`
ON `plymind_db`.`tbl_push_pic`( -- Push 메시지 이미지
  `orig_name` ASC -- 원본 파일명
);

ALTER TABLE `plymind_db`.`tbl_push_pic`
MODIFY COLUMN `file_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '파일 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_push_pic`
AUTO_INCREMENT = 1;



-- 15. Push 메시지에서 사용되는 파일 매핑 테이블
CREATE TABLE `plymind_db`.`tbl_push_message_pic` (
  `push_srl` BIGINT NOT NULL COMMENT 'Push 메시지 시리얼 넘버', -- Push 시리얼 넘버
  `file_srl` BIGINT NOT NULL COMMENT 'Push 메시지에서 사용되는 파일의 시리얼 넘버', -- 파일 시리얼 넘버
  `c_date`   INT    NOT NULL COMMENT '생성일' -- 생성일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT 'Push 메시지와 사용되는 이미지 매핑 테이블';

-- Push 메시지에서 사용되는 파일 매핑 테이블
ALTER TABLE `plymind_db`.`tbl_push_message_pic`
ADD CONSTRAINT `PK_tbl_push_message_pic` -- Push 메시지에서 사용되는 파일 매핑 테이블 기본키
PRIMARY KEY (
    `push_srl`, -- Push 시리얼 넘버
    `file_srl`  -- 파일 시리얼 넘버
  );

-- Push 메시지에서 사용되는 파일 매핑 테이블
ALTER TABLE `plymind_db`.`tbl_push_message_pic`
ADD CONSTRAINT `FK_tbl_push_message_TO_tbl_push_message_pic` -- Push 메시지 이력 테이블 -> Push 메시지에서 사용되는 파일 매핑 테이블
FOREIGN KEY (
    `push_srl` -- Push 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_push_message` ( -- Push 메시지 이력 테이블
    `push_srl` -- Push 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_push_message_TO_tbl_push_message_pic` (
  `push_srl` ASC -- Push 시리얼 넘버
);

-- Push 메시지에서 사용되는 파일 매핑 테이블
ALTER TABLE `plymind_db`.`tbl_push_message_pic`
ADD CONSTRAINT `FK_tbl_push_pic_TO_tbl_push_message_pic` -- Push 메시지 이미지 -> Push 메시지에서 사용되는 파일 매핑 테이블
FOREIGN KEY (
    `file_srl` -- 파일 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_push_pic` ( -- Push 메시지 이미지
    `file_srl` -- 파일 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_push_pic_TO_tbl_push_message_pic` (
  `file_srl` ASC -- 파일 시리얼 넘버
);



-- 16. 파일 저장소
CREATE TABLE `plymind_db`.`tbl_file_repository` (
  `file_srl`     BIGINT       NOT NULL COMMENT '파일 시리얼 넘버', -- 파일 시리얼 넘버
  `orig_name`    VARCHAR(128) NULL     COMMENT '원본 파일의 파일명', -- 원본 파일명
  `mime_type`    VARCHAR(128) NULL     COMMENT '파일의 마임 타입', -- 마임 타입
  `file_size`    BIGINT       NOT NULL DEFAULT -1 COMMENT '원본 파일의 파일 크기(바이트 단위)', -- 파일 크기
  `file_path`    VARCHAR(256) NULL     COMMENT '원본 파일의 서버에서 저장 경로', -- 파일 저장 경로
  `file_url`     VARCHAR(256) NOT NULL COMMENT '도메인을 제외한 원본 파일의 접근 URL', -- 파일 접근 상대 주소
  `width`        INT          NOT NULL DEFAULT -1 COMMENT '원본 파일의 이미지 너비', -- 이미지 너비
  `height`       INT          NOT NULL DEFAULT -1 COMMENT '원본 파일의 이미지 높이', -- 이미지 높이
  `thumb_path`   VARCHAR(256) NULL     COMMENT '썸네일 파일의 서버에서 저장 경로', -- 썸네일 파일 저장 경로
  `thumb_url`    VARCHAR(256) NULL     COMMENT '도메인을 제외한 썸네일 파일의 접근 URL', -- 썸네일 파일 접근 상대 주소
  `thumb_width`  INT          NOT NULL DEFAULT -1 COMMENT '썸네일 파일의 이미지 너비', -- 썸네일 파일 이미지 너비
  `thumb_height` INT          NOT NULL DEFAULT -1 COMMENT '썸네일 파일의 이미지 높이', -- 썸네일 파일 이미지 높이
  `file_comment` VARCHAR(256) NULL     COMMENT '파일 설명', -- 파일 설명
  `user_id`      VARCHAR(128) NULL     COMMENT '파일을 업로드한 사용자 아이디', -- 사용자 아이디
  `ipaddress`    CHAR(16)     NULL     COMMENT '파일 업로드한 아이피 주소', -- 파일 업로드 아이피 주소
  `deleted`      TINYINT      NOT NULL DEFAULT 2 COMMENT '파일의 삭제 여부. 물리 파일 삭제 용도. 1:삭제, 2:삭제하면 안됨', -- 파일 삭제 여부
  `file_type`    TINYINT      NOT NULL DEFAULT 0  COMMENT '1:심리검사지, 2:사전검사지, 3:사후검사지, 4:기타', -- 1:심리검사지, 2:사전검사지, 3:사후검사지, 4:기타
  `c_date`       INT          NOT NULL COMMENT '파일 정보의 생성일', -- 생성일
  `u_date`       INT          NOT NULL COMMENT '파일 정보의 수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '임의의 파일 저장소';

-- 파일 저장소
ALTER TABLE `plymind_db`.`tbl_file_repository`
ADD CONSTRAINT `PK_tbl_file_repository` -- 파일 저장소 기본키
PRIMARY KEY (
    `file_srl` -- 파일 시리얼 넘버
  );

-- 파일 저장소 인덱스
CREATE INDEX `IX_tbl_file_repository`
ON `plymind_db`.`tbl_file_repository`( -- 파일 저장소
  `orig_name` ASC -- 원본 파일명
);

-- 파일 저장소 인덱스2
CREATE INDEX `IX_tbl_file_repository2`
ON `plymind_db`.`tbl_file_repository`( -- 파일 저장소
  `user_id` ASC -- 사용자 아이디
);

ALTER TABLE `plymind_db`.`tbl_file_repository`
MODIFY COLUMN `file_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '파일 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_file_repository`
AUTO_INCREMENT = 1;



-- 17. 디바이스를 위한 접속 토큰 테이블
CREATE TABLE `plymind_db`.`tbl_device_access_token` (
  `token_srl`    BIGINT      NOT NULL COMMENT '토큰 시리얼 넘버', -- 토큰 시리얼 넘버
  `device_srl`   BIGINT      NOT NULL COMMENT '접속 토큰을 발급한 단말기 시리얼 넘버', -- 단말기 시리얼 넘버
  `app_srl`      INT         NOT NULL COMMENT '접속 토큰을 발급한 앱 시리얼 넘버', -- 앱 시리얼 넘버
  `access_token` VARCHAR(32) NOT NULL COMMENT '접속 토큰', -- 접속 토큰
  `token_expire` INT         NOT NULL COMMENT '접속 토큰 만료 시간', -- 토큰 만료 시간
  `c_date`       INT         NOT NULL COMMENT '생성일', -- 생성일
  `u_date`       INT         NOT NULL COMMENT '수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '회원 가입이 되지 않고 단말로 접속 했을 때 API 사용을 위한 access_token';

-- 디바이스를 위한 접속 토큰 테이블
ALTER TABLE `plymind_db`.`tbl_device_access_token`
ADD CONSTRAINT `PK_tbl_device_access_token` -- 디바이스를 위한 접속 토큰 테이블 기본키
PRIMARY KEY (
    `token_srl` -- 토큰 시리얼 넘버
  );

-- 디바이스를 위한 접속 토큰 테이블 유니크 인덱스
CREATE UNIQUE INDEX `UIX_tbl_device_access_token`
ON `plymind_db`.`tbl_device_access_token` ( -- 디바이스를 위한 접속 토큰 테이블
  `access_token` ASC -- 접속 토큰
);

-- 디바이스를 위한 접속 토큰 테이블 인덱스2
CREATE INDEX `IX_tbl_device_access_token2`
ON `plymind_db`.`tbl_device_access_token`( -- 디바이스를 위한 접속 토큰 테이블
  `token_expire` ASC -- 토큰 만료 시간
);

ALTER TABLE `plymind_db`.`tbl_device_access_token`
MODIFY COLUMN `token_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '토큰 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_device_access_token`
AUTO_INCREMENT = 1;

-- 디바이스를 위한 접속 토큰 테이블
ALTER TABLE `plymind_db`.`tbl_device_access_token`
ADD CONSTRAINT `FK_tbl_device_TO_tbl_device_access_token` -- 디바이스 관리 -> 디바이스를 위한 접속 토큰 테이블
FOREIGN KEY (
    `device_srl` -- 단말기 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_device` ( -- 디바이스 관리
    `device_srl` -- 단말기 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_device_TO_tbl_device_access_token` (
  `device_srl` ASC -- 단말기 시리얼 넘버
);

-- 디바이스를 위한 접속 토큰 테이블
ALTER TABLE `plymind_db`.`tbl_device_access_token`
ADD CONSTRAINT `FK_tbl_app_TO_tbl_device_access_token` -- 서비스하는 앱 -> 디바이스를 위한 접속 토큰 테이블
FOREIGN KEY (
    `app_srl` -- 앱 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_app` ( -- 서비스하는 앱
    `app_srl` -- 앱 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_app_TO_tbl_device_access_token` (
  `app_srl` ASC -- 앱 시리얼 넘버
);



-- 18. 앱 그룹 테이블
CREATE TABLE `plymind_db`.`tbl_app_group` (
  `app_group_srl`     BIGINT       NOT NULL COMMENT '앱에서 사용하는 사용자 그룹 시리얼 넘버', -- 앱 그룹 시리얼 넘버
  `app_srl`           INT          NOT NULL COMMENT '앱 시리얼 넘버', -- 앱 시리얼 넘버
  `group_name`        VARCHAR(128) NOT NULL COMMENT '앱내 그룹명', -- 앱 그룹명
  `group_description` VARCHAR(256) NULL     COMMENT '그룹 설명', -- 설명
  `group_type`        INT          NOT NULL DEFAULT 2 COMMENT '그룹의 종류. 1:시스템에서 생성한 그룹. 삭제 불가, 2:임의 생성한 그룹 삭제 가능', -- 앱 그룹 분류
  `authority`         VARCHAR(16)  NOT NULL DEFAULT 'ROLE_VISITOR' COMMENT '앱 그룹의 권한', -- 앱 그룹 권한
  `enabled`           TINYINT      NOT NULL DEFAULT 1 COMMENT '그룹 활성 여부. 1: 활성, 2:일시 중지, 3:차단', -- 활성 여부
  `allow_default`     TINYINT      NOT NULL DEFAULT 2 COMMENT '기본 그룹 여부. 1:기본 그룹, 2:기본 그룹 아님', -- 기본 그룹 여부
  `c_date`            INT          NOT NULL COMMENT '생성일', -- 생성일
  `u_date`            INT          NOT NULL COMMENT '수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '앱에서 사용되는 그룹';

-- 앱 그룹 테이블
ALTER TABLE `plymind_db`.`tbl_app_group`
ADD CONSTRAINT `PK_tbl_app_group` -- 앱 그룹 테이블 기본키
PRIMARY KEY (
    `app_group_srl` -- 앱 그룹 시리얼 넘버
  );

-- 앱 그룹 테이블 인덱스
CREATE INDEX `IX_tbl_app_group`
ON `plymind_db`.`tbl_app_group`( -- 앱 그룹 테이블
  `group_name` ASC -- 앱 그룹명
);

-- 앱 그룹 테이블 인덱스2
CREATE INDEX `IX_tbl_app_group2`
ON `plymind_db`.`tbl_app_group`( -- 앱 그룹 테이블
  `authority` ASC -- 앱 그룹 권한
);

ALTER TABLE `plymind_db`.`tbl_app_group`
MODIFY COLUMN `app_group_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '앱에서 사용하는 사용자 그룹 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_app_group`
AUTO_INCREMENT = 1;

-- 앱 그룹 테이블
ALTER TABLE `plymind_db`.`tbl_app_group`
ADD CONSTRAINT `FK_tbl_app_TO_tbl_app_group` -- 서비스하는 앱 -> 앱 그룹 테이블
FOREIGN KEY (
    `app_srl` -- 앱 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_app` ( -- 서비스하는 앱
    `app_srl` -- 앱 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_app_TO_tbl_app_group` (
  `app_srl` ASC -- 앱 시리얼 넘버
);



-- 19. 앱 그룹 사용자 매핑
CREATE TABLE `plymind_db`.`tbl_app_group_member` (
  `app_group_srl` BIGINT NOT NULL COMMENT '앱 그룹 시리얼 넘버', -- 앱 그룹 시리얼 넘버
  `member_srl`    BIGINT NOT NULL COMMENT '사용자 시리얼 넘버', -- 유저 시리얼 넘버
  `c_date`        INT    NOT NULL COMMENT '생성일' -- 생성일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '앱 그룹의 사용자';

-- 앱 그룹 사용자 매핑
ALTER TABLE `plymind_db`.`tbl_app_group_member`
ADD CONSTRAINT `PK_tbl_app_group_member` -- 앱 그룹 사용자 매핑 기본키
PRIMARY KEY (
    `app_group_srl`, -- 앱 그룹 시리얼 넘버
    `member_srl`     -- 유저 시리얼 넘버
  );

-- 앱 그룹 사용자 매핑
ALTER TABLE `plymind_db`.`tbl_app_group_member`
ADD CONSTRAINT `FK_tbl_app_group_TO_tbl_app_group_member` -- 앱 그룹 테이블 -> 앱 그룹 사용자 매핑
FOREIGN KEY (
    `app_group_srl` -- 앱 그룹 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_app_group` ( -- 앱 그룹 테이블
    `app_group_srl` -- 앱 그룹 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_app_group_TO_tbl_app_group_member` (
  `app_group_srl` ASC -- 앱 그룹 시리얼 넘버
);

-- 앱 그룹 사용자 매핑
ALTER TABLE `plymind_db`.`tbl_app_group_member`
ADD CONSTRAINT `FK_tbl_member_TO_tbl_app_group_member` -- 유저 -> 앱 그룹 사용자 매핑
FOREIGN KEY (
    `member_srl` -- 유저 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_member` ( -- 유저
    `member_srl` -- 유저 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_member_TO_tbl_app_group_member` (
  `member_srl` ASC -- 유저 시리얼 넘버
);



-- 20. 게시물 템플릿 테이블
CREATE TABLE `plymind_db`.`tbl_template` (
  `template_srl`         INT          NOT NULL COMMENT '게시물 템플릿 시리얼 넘버', -- 게시물 템플릿 시리얼 넘버
  `template_title`       VARCHAR(64)  NOT NULL COMMENT '템플릿 제목', -- 템플릿 제목
  `template_content`     TEXT         NULL     COMMENT '템플릿 내용', -- 템플릿 구조
  `template_description` VARCHAR(256) NULL     COMMENT '템플릿 설명', -- 템플릿 러명
  `c_date`               INT          NOT NULL COMMENT '생성일', -- 생성일
  `u_date`               INT          NOT NULL COMMENT '수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '게시물 템플릿 테이블';

-- 게시물 템플릿 테이블
ALTER TABLE `plymind_db`.`tbl_template`
ADD CONSTRAINT `PK_tbl_template` -- 게시물 템플릿 테이블 기본키
PRIMARY KEY (
    `template_srl` -- 게시물 템플릿 시리얼 넘버
  );

-- 게시물 템플릿 테이블 인덱스
CREATE INDEX `IX_tbl_template`
ON `plymind_db`.`tbl_template`( -- 게시물 템플릿 테이블
  `template_title` ASC -- 템플릿 제목
);

ALTER TABLE `plymind_db`.`tbl_template`
MODIFY COLUMN `template_srl` INT NOT NULL AUTO_INCREMENT COMMENT '게시물 템플릿 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_template`
AUTO_INCREMENT = 1;



-- 21. 앱, 템플릿 매핑
CREATE TABLE `plymind_db`.`tbl_app_template` (
  `app_srl`      INT NOT NULL COMMENT '앱 시리얼 넘버', -- 앱 시리얼 넘버
  `template_srl` INT NOT NULL COMMENT '게시물 템플릿 시리얼 넘버', -- 템플릿 시리얼 넘버
  `c_date`       INT NOT NULL COMMENT '생성일' -- 생성일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '앱, 템플릿 매핑. 앱에서 사용하는 템플릿 설정';

-- 앱, 템플릿 매핑
ALTER TABLE `plymind_db`.`tbl_app_template`
ADD CONSTRAINT `PK_tbl_app_template` -- 앱, 템플릿 매핑 기본키
PRIMARY KEY (
    `app_srl`,      -- 앱 시리얼 넘버
    `template_srl`  -- 템플릿 시리얼 넘버
  );

-- 앱, 템플릿 매핑
ALTER TABLE `plymind_db`.`tbl_app_template`
ADD CONSTRAINT `FK_tbl_app_TO_tbl_app_template` -- 서비스하는 앱 -> 앱, 템플릿 매핑
FOREIGN KEY (
    `app_srl` -- 앱 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_app` ( -- 서비스하는 앱
    `app_srl` -- 앱 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_app_TO_tbl_app_template` (
  `app_srl` ASC -- 앱 시리얼 넘버
);

-- 앱, 템플릿 매핑
ALTER TABLE `plymind_db`.`tbl_app_template`
ADD CONSTRAINT `FK_tbl_template_TO_tbl_app_template` -- 게시물 템플릿 테이블 -> 앱, 템플릿 매핑
FOREIGN KEY (
    `template_srl` -- 템플릿 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_template` ( -- 게시물 템플릿 테이블
    `template_srl` -- 게시물 템플릿 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_template_TO_tbl_app_template` (
  `template_srl` ASC -- 템플릿 시리얼 넘버
);


-- 게시물 댓글 테이블
CREATE TABLE `plymind_db`.`tbl_document_comment` (
        `comment_srl`         BIGINT       NOT NULL COMMENT '댓글 시리얼 넘버', -- 댓글 시리얼 넘버
        `app_srl`             INT          NOT NULL COMMENT '앱 시리얼 넘버', -- 앱 시리얼 넘버
        `board_srl`           BIGINT       NOT NULL COMMENT '게시판 시리얼 넘버', -- 게시판 시리얼 넘버
        `category_srl`        BIGINT       NOT NULL COMMENT '카테고리 시리얼 넘버', -- 카테고리 시리얼 넘버
        `document_srl`        BIGINT       NOT NULL COMMENT '게시물 시리얼 넘버', -- 게시물 시리얼 넘버
        `head_comment_srl`    BIGINT       NOT NULL COMMENT '대댓글 일때 최고 부모 댓글 시리얼 넘버. 최고 부모일 경우는 -1', -- 최고 부모 댓글 시리얼 넘버
        `parent_comment_srl`  BIGINT       NOT NULL COMMENT '대댓글 일때 부모의 시리얼 넘버. 최고 부모일 경우는 -1', -- 부모 시리얼 넘버
        `comment_depth`       INT          NOT NULL COMMENT '대댓글의 depth. 1 부터 시작 한다', -- 댓글 depth
        `comment_content`     TEXT         NULL     COMMENT '댓글 내용', -- 댓글 내용
        `like_count`          BIGINT       NOT NULL DEFAULT 0 COMMENT '좋아요 횟수', -- 좋아요 횟수
        `blame_count`         BIGINT       NOT NULL DEFAULT 0 COMMENT '비난 횟수', -- 비난 횟수
        `child_comment_count` BIGINT       NOT NULL DEFAULT 0 COMMENT '최고 부모 댓글 일때 자식 댓글의 개수. 최고 부모가 아니거나 자식이 없으면 0으로 고정', -- 자식 댓글 갯수
        `file_count`          INT          NOT NULL DEFAULT 0 COMMENT '첨부 파일 갯수', -- 첨부 파일 갯수
        `block`               TINYINT      NOT NULL DEFAULT 2 COMMENT '차단 여부. 1:차단됨, 2:차단되지 않음', -- 댓글 차단 여부
        `member_srl`          BIGINT       NOT NULL COMMENT '댓글 게시자 유저 시리얼 넘버. 정보가 없다면 -1로 설정', -- 유저 시리얼 넘버
        `user_id`             VARCHAR(128) NOT NULL COMMENT '댓글 게시자 사용자 아이디. 정보가 없다면 empty string으로 설정', -- 사용자 아이디
        `user_name`           VARCHAR(64)  NOT NULL COMMENT '댓글 게시자 이름. 정보가 없다면 empty string으로 설정', -- 사용자 이름
        `nick_name`           VARCHAR(64)  NOT NULL COMMENT '댓글 게시자 별명. 정보가 없다면 empty string으로 설정', -- 사용자 별명
        `email_address`       VARCHAR(128) NULL     COMMENT '댓글 게시자 이메일 주소. 정보가 없다면 empty string으로 설정', -- 사용자 이메일 주소
        `ipaddress`           CHAR(16)     NOT NULL COMMENT '댓글 게시자 아이피 주소', -- 게시자 아이피
        `c_date`              INT          NOT NULL COMMENT '생성일', -- 생성일
        `u_date`              INT          NOT NULL COMMENT '수정일' -- 수정일
)
DEFAULT CHARACTER SET = 'utf8'
DEFAULT COLLATE = 'utf8_general_ci'
ENGINE = InnoDB
COMMENT '게시물 댓글 테이블';

-- 게시물 댓글 테이블
ALTER TABLE `plymind_db`.`tbl_document_comment`
        ADD CONSTRAINT `PK_tbl_document_comment` -- 게시물 댓글 테이블 기본키
                PRIMARY KEY (
                        `comment_srl` -- 댓글 시리얼 넘버
                );

-- 게시물 댓글 테이블 인덱스
CREATE INDEX `IX_tbl_document_comment`
        ON `plymind_db`.`tbl_document_comment`( -- 게시물 댓글 테이블
                `member_srl` ASC -- 유저 시리얼 넘버
        );

-- 게시물 댓글 테이블 인덱스2
CREATE INDEX `IX_tbl_document_comment2`
        ON `plymind_db`.`tbl_document_comment`( -- 게시물 댓글 테이블
                `user_id` ASC -- 사용자 아이디
        );

-- 게시물 댓글 테이블 인덱스3
CREATE INDEX `IX_tbl_document_comment3`
        ON `plymind_db`.`tbl_document_comment`( -- 게시물 댓글 테이블
                `user_name` ASC -- 사용자 이름
        );

-- 게시물 댓글 테이블 인덱스4
CREATE INDEX `IX_tbl_document_comment4`
        ON `plymind_db`.`tbl_document_comment`( -- 게시물 댓글 테이블
                `nick_name` ASC -- 사용자 별명
        );

ALTER TABLE `plymind_db`.`tbl_document_comment`
        MODIFY COLUMN `comment_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '댓글 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_document_comment`
        AUTO_INCREMENT = 1;

-- 22. 게시판 테이블
CREATE TABLE `plymind_db`.`tbl_document_board` (
  `board_srl`         BIGINT       NOT NULL COMMENT '게시판 시리얼 넘버. 1번 부터 2048까지는 특수 용도의 게시판 시리얼 넘버', -- 게시판 시리얼 넘버
  `app_srl`           INT          NOT NULL COMMENT '앱 시리얼 넘버', -- 앱 시리얼 넘버
  `board_name`        VARCHAR(64)  NOT NULL COMMENT '게시판 이름', -- 게시판 이름
  `board_description` VARCHAR(256) NULL     COMMENT '게시판 설명', -- 게시판 설명
  `enabled`           TINYINT      NOT NULL DEFAULT 1 COMMENT '활성여부. 1:활성, 2:비활성', -- 활성 여부
  `open_type`         TINYINT      NOT NULL DEFAULT 1 COMMENT '비로그인 사용자에게 게시판 공개 여부. 1:공개, 2:비공개', -- 공개 여부
  `c_date`            INT          NOT NULL COMMENT '생성일', -- 생성일
  `u_date`            INT          NOT NULL COMMENT '수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '앱에서 사용하는 게시판 테이블';

-- 게시판 테이블
ALTER TABLE `plymind_db`.`tbl_document_board`
ADD CONSTRAINT `PK_tbl_document_board` -- 게시판 테이블 기본키
PRIMARY KEY (
    `board_srl` -- 게시판 시리얼 넘버
  );

-- 게시판 테이블 인덱스
CREATE INDEX `IX_tbl_document_board`
ON `plymind_db`.`tbl_document_board`( -- 게시판 테이블
  `board_name` ASC -- 게시판 이름
);

ALTER TABLE `plymind_db`.`tbl_document_board`
MODIFY COLUMN `board_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '게시판 시리얼 넘버. 1번 부터 2048까지는 특수 용도의 게시판 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_document_board`
AUTO_INCREMENT = 2048;

-- 게시판 테이블
ALTER TABLE `plymind_db`.`tbl_document_board`
ADD CONSTRAINT `FK_tbl_app_TO_tbl_document_board` -- 서비스하는 앱 -> 게시판 테이블
FOREIGN KEY (
    `app_srl` -- 앱 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_app` ( -- 서비스하는 앱
    `app_srl` -- 앱 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_app_TO_tbl_document_board` (
  `app_srl` ASC -- 앱 시리얼 넘버
);



-- 23. 게시판 카테고리 테이블
CREATE TABLE `plymind_db`.`tbl_document_category` (
  `category_srl`         BIGINT       NOT NULL COMMENT '카테고리 시리얼 넘버', -- 카테고리 시리얼 넘버
  `app_srl`              INT          NOT NULL COMMENT '앱 시리얼 넘버', -- 앱 시리얼 넘버
  `board_srl`            BIGINT       NOT NULL COMMENT '게시판 시리얼 넘버', -- 게시판 시리얼 넘버
  `category_name`        VARCHAR(64)  NOT NULL COMMENT '카테고리 이름', -- 카테고리 이름
  `category_description` VARCHAR(256) NULL     COMMENT '카테고리 설명', -- 카테고리 설명
  `category_type`        TINYINT      NOT NULL DEFAULT 1 COMMENT '카테고리 타입. 포함된 게시물의 형태. 1:일반 게시물, 2:링크 게시물', -- 카테고리 타입
  `enabled`              TINYINT      NOT NULL DEFAULT 1 COMMENT '활성 여부. 1:활성, 2:비활성', -- 활성 여부
  `open_type`            TINYINT      NOT NULL DEFAULT 1 COMMENT '비로그인 사용자에게 게시판 공개 여부. 1:공개, 2:비공개', -- 공개 여부
  `c_date`               INT          NOT NULL COMMENT '생성일', -- 생성일
  `u_date`               INT          NOT NULL COMMENT '수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '게시판의 카테고리 테이블';

-- 게시판 카테고리 테이블
ALTER TABLE `plymind_db`.`tbl_document_category`
ADD CONSTRAINT `PK_tbl_document_category` -- 게시판 카테고리 테이블 기본키
PRIMARY KEY (
    `category_srl` -- 카테고리 시리얼 넘버
  );

-- 게시판 카테고리 테이블 인덱스
CREATE INDEX `IX_tbl_document_category`
ON `plymind_db`.`tbl_document_category`( -- 게시판 카테고리 테이블
  `category_name` ASC -- 카테고리 이름
);

ALTER TABLE `plymind_db`.`tbl_document_category`
MODIFY COLUMN `category_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '카테고리 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_document_category`
AUTO_INCREMENT = 2048;

-- 게시판 카테고리 테이블
ALTER TABLE `plymind_db`.`tbl_document_category`
ADD CONSTRAINT `FK_tbl_document_board_TO_tbl_document_category` -- 게시판 테이블 -> 게시판 카테고리 테이블
FOREIGN KEY (
    `board_srl` -- 게시판 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_document_board` ( -- 게시판 테이블
    `board_srl` -- 게시판 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_document_board_TO_tbl_document_category` (
  `board_srl` ASC -- 게시판 시리얼 넘버
);

-- 게시판 카테고리 테이블
ALTER TABLE `plymind_db`.`tbl_document_category`
ADD CONSTRAINT `FK_tbl_app_TO_tbl_document_category` -- 서비스하는 앱 -> 게시판 카테고리 테이블
FOREIGN KEY (
    `app_srl` -- 앱 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_app` ( -- 서비스하는 앱
    `app_srl` -- 앱 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_app_TO_tbl_document_category` (
  `app_srl` ASC -- 앱 시리얼 넘버
);



-- 24. 게시물 테이블
CREATE TABLE `plymind_db`.`tbl_document` (
  `document_srl`      BIGINT       NOT NULL COMMENT '게시물 시리얼 넘버', -- 게시물 시리얼 넘버
  `app_srl`           INT          NOT NULL COMMENT '앱 시리얼 넘버', -- 앱 시리얼 넘버
  `board_srl`         BIGINT       NOT NULL COMMENT '게시판 시리얼 넘버', -- 게시판 시리얼 넘버
  `category_srl`      BIGINT       NOT NULL COMMENT '카테고리 시리얼 넘버', -- 카테고리 시리얼 넘버
  `document_title`    VARCHAR(128) NOT NULL COMMENT '게시물 제목', -- 게시물 제목
  `document_content`  TEXT         NULL     COMMENT '게시물 본문 내용', -- 게시물 내용
  `read_count`        BIGINT       NOT NULL DEFAULT 0 COMMENT '게시물 조회 횟수', -- 게시물 조회 횟수
  `like_count`        BIGINT       NOT NULL DEFAULT 0 COMMENT '게시물 좋아요 횟수', -- 게시물 좋아요 횟수
  `blame_count`       BIGINT       NOT NULL DEFAULT 0 COMMENT '게시물 비난 횟수', -- 게시물 비난 횟수
  `comment_count`     INT          NOT NULL DEFAULT 0 COMMENT '게시물 댓글 개수', -- 게시물 댓글 횟수
  `file_count`        INT          NOT NULL DEFAULT 0 COMMENT '게시물 첨부 파일 개수', -- 게시물 첨부파일 개수
  `outer_link`        VARCHAR(256) NULL     COMMENT '게시물의 외부 링크', -- 외부 링크
  `secret`            BIGINT       NOT NULL DEFAULT -1 COMMENT '비밀글 여부. 비밀글 이면 게시물 작성자의 시리얼 넘버가 들어 간다. -1:비밀글 아님, 사용자 시리얼 넘버: 특정 사용자의 비밀글', -- 비밀글 여부
  `block`             TINYINT      NOT NULL DEFAULT 2 COMMENT '게시물 차단 여부. 1:차단됨, 2:차단되지 않음', -- 차단 여부
  `allow_comment`     TINYINT      NOT NULL DEFAULT 1 COMMENT '게시물에 댓글 허용 여부. 1:댓글 허용함, 2:댓글 허용하지 않음', -- 댓글 허용 여부
  `allow_notice`      TINYINT      NOT NULL DEFAULT 2 COMMENT '공지 게시물인지 여부. 1:공지 게시물, 2:일반 게시물', -- 공지사항 여부
  `list_order`        BIGINT       NOT NULL DEFAULT 0 COMMENT '게시물의 임의 순서.초기값은 document_srl과 동일하다', -- 임의 순서
  `template_srl`      INT          NOT NULL COMMENT '만일 -1이면 템플릿을 사용하지 않음', -- 템플릿 시리얼 너버
  `template_extra`    TEXT         NULL     COMMENT 'template_srl이 -1 일때 값이 있으면 정해지지 않은 임의의 템플릿을 사용하는 것임', -- 템플릿 내용
  `member_srl`        BIGINT       NOT NULL COMMENT '게시물 작성자의 사용자 시리얼 넘버. 만일 정보가 없다면 -1로 설정', -- 유저 시리얼 넘버
  `user_id`           VARCHAR(128) NOT NULL COMMENT '게시물 작성자의 사용자 아이디. 만일 정보가 없다면 empty string으로 설정', -- 사용자 아이디
  `user_name`         VARCHAR(64)  NOT NULL COMMENT '게시물 작성자의 이름. 만일 정보가 없다면 empty string으로 설정', -- 사용자 이름
  `nick_name`         VARCHAR(64)  NOT NULL COMMENT '게시물 작성자의 별명. 만일 정보가 없다면 empty string으로 설정', -- 사용자 별명
  `email_address`     VARCHAR(128) NULL     COMMENT '게시물 작성자의 메일 주소. 만일 정보가 없다면 empty string으로 설정', -- 사용자 이메일 주소
  `document_password` VARCHAR(128) NULL     COMMENT '게시물의 패스워드. 공개 게시판 일때 작성자는 패스워드를 넣고 수정, 삭제시 패스워드를 이용한다', -- 게시물 패스워드
  `ipaddress`         CHAR(16)     NOT NULL COMMENT '게시물 작성자의 client ip address', -- 작성자 아이피
  `c_date`            INT          NOT NULL COMMENT '생성일', -- 생성일
  `u_date`            INT          NOT NULL COMMENT '수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '게시물 테이블';

-- 게시물 테이블
ALTER TABLE `plymind_db`.`tbl_document`
ADD CONSTRAINT `PK_tbl_document` -- 게시물 테이블 기본키
PRIMARY KEY (
    `document_srl` -- 게시물 시리얼 넘버
  );

-- 게시물 테이블 인덱스
CREATE INDEX `IX_tbl_document`
ON `plymind_db`.`tbl_document`( -- 게시물 테이블
  `document_title` ASC -- 게시물 제목
);

-- 게시물 테이블 인덱스2
CREATE INDEX `IX_tbl_document2`
ON `plymind_db`.`tbl_document`( -- 게시물 테이블
  `member_srl` ASC -- 유저 시리얼 넘버
);

-- 게시물 테이블 인덱스3
CREATE INDEX `IX_tbl_document3`
ON `plymind_db`.`tbl_document`( -- 게시물 테이블
  `user_id` ASC -- 사용자 아이디
);

-- 게시물 테이블 인덱스4
CREATE INDEX `IX_tbl_document4`
ON `plymind_db`.`tbl_document`( -- 게시물 테이블
  `user_name` ASC -- 사용자 이름
);

-- 게시물 테이블 인덱스5
CREATE INDEX `IX_tbl_document5`
ON `plymind_db`.`tbl_document`( -- 게시물 테이블
  `nick_name` ASC -- 사용자 별명
);

-- 게시물 테이블 인덱스6
CREATE INDEX `IX_tbl_document6`
ON `plymind_db`.`tbl_document`( -- 게시물 테이블
  `read_count` ASC -- 게시물 조회 횟수
);

-- 게시물 테이블 인덱스7
CREATE INDEX `IX_tbl_document7`
ON `plymind_db`.`tbl_document`( -- 게시물 테이블
  `like_count` ASC -- 게시물 좋아요 횟수
);

-- 게시물 테이블 인덱스8
CREATE INDEX `IX_tbl_document8`
ON `plymind_db`.`tbl_document`( -- 게시물 테이블
  `blame_count` ASC -- 게시물 비난 횟수
);

-- 게시물 테이블 인덱스9
CREATE INDEX `IX_tbl_document9`
ON `plymind_db`.`tbl_document`( -- 게시물 테이블
  `comment_count` ASC -- 게시물 댓글 횟수
);

-- 게시물 테이블 인덱스10
CREATE INDEX `IX_tbl_document10`
ON `plymind_db`.`tbl_document`( -- 게시물 테이블
  `list_order` DESC -- 임의 순서
);

-- 게시물 테이블 인덱스11
CREATE INDEX `IX_tbl_document11`
ON `plymind_db`.`tbl_document`( -- 게시물 테이블
  `secret` ASC -- 비밀글 여부
);

ALTER TABLE `plymind_db`.`tbl_document`
MODIFY COLUMN `document_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '게시물 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_document`
AUTO_INCREMENT = 1;

-- 게시물 테이블
ALTER TABLE `plymind_db`.`tbl_document`
ADD CONSTRAINT `FK_tbl_app_TO_tbl_document` -- 서비스하는 앱 -> 게시물 테이블
FOREIGN KEY (
    `app_srl` -- 앱 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_app` ( -- 서비스하는 앱
    `app_srl` -- 앱 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_app_TO_tbl_document` (
  `app_srl` ASC -- 앱 시리얼 넘버
);

-- 게시물 테이블
ALTER TABLE `plymind_db`.`tbl_document`
ADD CONSTRAINT `FK_tbl_document_board_TO_tbl_document` -- 게시판 테이블 -> 게시물 테이블
FOREIGN KEY (
    `board_srl` -- 게시판 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_document_board` ( -- 게시판 테이블
    `board_srl` -- 게시판 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_document_board_TO_tbl_document` (
  `board_srl` ASC -- 게시판 시리얼 넘버
);

-- 게시물 테이블
ALTER TABLE `plymind_db`.`tbl_document`
ADD CONSTRAINT `FK_tbl_document_category_TO_tbl_document` -- 게시판 카테고리 테이블 -> 게시물 테이블
FOREIGN KEY (
    `category_srl` -- 카테고리 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_document_category` ( -- 게시판 카테고리 테이블
    `category_srl` -- 카테고리 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_document_category_TO_tbl_document` (
  `category_srl` ASC -- 카테고리 시리얼 넘버
);



-- 25. 게시물 태그 테이블
CREATE TABLE `plymind_db`.`tbl_tag` (
  `tag_srl`    BIGINT      NOT NULL COMMENT '태그 시리얼 넘버', -- 태그 시리얼 넘버
  `app_srl`    INT         NOT NULL COMMENT '태그가 포함된 앱 시리얼 넘버', -- 앱 시리얼 넘버
  `member_srl` BIGINT      NOT NULL COMMENT '태그 생성한 사용자 시리얼 넘버', -- 유저 시리얼 넘버
  `tag_name`   VARCHAR(32) NOT NULL COMMENT '태그 이름', -- 태그명
  `admin_tag`  TINYINT     NOT NULL DEFAULT 1 COMMENT '태그 종류 구분. 1:앱별 어드민만 사용하는 태그, 2:앱별 일반 태그', -- 태그 타입
  `c_date`     INT         NOT NULL COMMENT '생성일', -- 생성일
  `u_date`     INT         NOT NULL COMMENT '수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '게시물 태그 테이블';

-- 게시물 태그 테이블
ALTER TABLE `plymind_db`.`tbl_tag`
ADD CONSTRAINT `PK_tbl_tag` -- 게시물 태그 테이블 기본키
PRIMARY KEY (
    `tag_srl` -- 태그 시리얼 넘버
  );

-- 게시물 태그 테이블 인덱스
CREATE INDEX `IX_tbl_tag`
ON `plymind_db`.`tbl_tag`( -- 게시물 태그 테이블
  `tag_name` ASC -- 태그명
);

ALTER TABLE `plymind_db`.`tbl_tag`
MODIFY COLUMN `tag_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '태그 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_tag`
AUTO_INCREMENT = 1;

-- 게시물 태그 테이블
ALTER TABLE `plymind_db`.`tbl_tag`
ADD CONSTRAINT `FK_tbl_app_TO_tbl_tag` -- 서비스하는 앱 -> 게시물 태그 테이블
FOREIGN KEY (
    `app_srl` -- 앱 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_app` ( -- 서비스하는 앱
    `app_srl` -- 앱 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_app_TO_tbl_tag` (
  `app_srl` ASC -- 앱 시리얼 넘버
);

-- 게시물 태그 테이블
ALTER TABLE `plymind_db`.`tbl_tag`
ADD CONSTRAINT `FK_tbl_member_TO_tbl_tag` -- 유저 -> 게시물 태그 테이블
FOREIGN KEY (
    `member_srl` -- 유저 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_member` ( -- 유저
    `member_srl` -- 유저 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_member_TO_tbl_tag` (
  `member_srl` ASC -- 유저 시리얼 넘버
);



-- 26. 게시물, 태그 매핑 테이블
CREATE TABLE `plymind_db`.`tbl_document_tag` (
  `document_srl` BIGINT NOT NULL COMMENT '게시물 시리얼 넘버', -- 게시물 시리얼 넘버
  `tag_srl`      BIGINT NOT NULL COMMENT '태그 시리얼 넘버', -- 태그 시리얼 넘버
  `c_date`       INT    NOT NULL COMMENT '생성일' -- 생성일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '게시물과 태그의 매핑';

-- 게시물, 태그 매핑 테이블
ALTER TABLE `plymind_db`.`tbl_document_tag`
ADD CONSTRAINT `PK_tbl_document_tag` -- 게시물, 태그 매핑 테이블 기본키
PRIMARY KEY (
    `document_srl`, -- 게시물 시리얼 넘버
    `tag_srl`       -- 태그 시리얼 넘버
  );

-- 게시물, 태그 매핑 테이블
ALTER TABLE `plymind_db`.`tbl_document_tag`
ADD CONSTRAINT `FK_tbl_document_TO_tbl_document_tag` -- 게시물 테이블 -> 게시물, 태그 매핑 테이블
FOREIGN KEY (
    `document_srl` -- 게시물 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_document` ( -- 게시물 테이블
    `document_srl` -- 게시물 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_document_TO_tbl_document_tag` (
  `document_srl` ASC -- 게시물 시리얼 넘버
);

-- 게시물, 태그 매핑 테이블
ALTER TABLE `plymind_db`.`tbl_document_tag`
ADD CONSTRAINT `FK_tbl_tag_TO_tbl_document_tag` -- 게시물 태그 테이블 -> 게시물, 태그 매핑 테이블
FOREIGN KEY (
    `tag_srl` -- 태그 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_tag` ( -- 게시물 태그 테이블
    `tag_srl` -- 태그 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_tag_TO_tbl_document_tag` (
  `tag_srl` ASC -- 태그 시리얼 넘버
);



-- 27. 게시물, 댓글 첨부 파일 테이블
CREATE TABLE `plymind_db`.`tbl_document_attach` (
  `file_srl`     BIGINT       NOT NULL COMMENT '파일 시리얼 넘버', -- 파일 시리얼 넘버
  `orig_name`    VARCHAR(128) NOT NULL COMMENT '원본 파일의 파일명', -- 원본 파일명
  `mime_type`    VARCHAR(128) NULL     COMMENT '파일의 마임 타입', -- 마임 타입
  `file_size`    BIGINT       NOT NULL DEFAULT -1 COMMENT '원본 파일의 파일 크기(바이트 단위)', -- 파일 크기
  `file_path`    VARCHAR(256) NULL     COMMENT '원본 파일의 서버에서 저장 경로', -- 파일 저장 경로
  `file_url`     VARCHAR(256) NOT NULL COMMENT '도메인을 제외한 원본 파일의 접근 URL', -- 파일 접근 상대 주소
  `width`        INT          NOT NULL DEFAULT -1 COMMENT '원본 파일의 이미지 너비', -- 이미지 너비
  `height`       INT          NOT NULL DEFAULT -1 COMMENT '원본 파일의 이미지 높이', -- 이미지 높이
  `thumb_path`   VARCHAR(256) NULL     COMMENT '썸네일 파일의 서버에서 저장 경로', -- 썸네일 저장 경로
  `thumb_url`    VARCHAR(256) NULL     COMMENT '도메인을 제외한 썸네일 파일의 접근 URL', -- 썸네일 접근 상대 주소
  `thumb_width`  INT          NOT NULL DEFAULT -1 COMMENT '썸네일 파일의 이미지 너비', -- 썸네일 너비
  `thumb_height` INT          NOT NULL DEFAULT -1 COMMENT '썸네일 파일의 이미지 높이', -- 썸네일 높이
  `file_comment` VARCHAR(256) NULL     COMMENT '파일 설명', -- 파일 설명
  `ipaddress`    CHAR(16)     NOT NULL COMMENT '파일 업로드한 아이피 주소', -- 업로드 IP
  `member_srl`   BIGINT       NOT NULL COMMENT '파일 업로드한 사용자 시리얼 넘버. 값이 없으면 -1로 설정됨', -- 유저 시리얼 넘버
  `deleted`      TINYINT      NOT NULL DEFAULT 2 COMMENT '파일의 삭제 여부. 물리 파일 삭제 용도. 1:삭제, 2:삭제하면 안됨', -- 파일 삭제 여부
  `c_date`       INT          NOT NULL COMMENT '생성일', -- 생성일
  `u_date`       INT          NOT NULL COMMENT '수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '게시물및 댓글 첨부 파일';

-- 게시물, 댓글 첨부 파일 테이블
ALTER TABLE `plymind_db`.`tbl_document_attach`
ADD CONSTRAINT `PK_tbl_document_attach` -- 게시물, 댓글 첨부 파일 테이블 기본키
PRIMARY KEY (
    `file_srl` -- 파일 시리얼 넘버
  );

-- 게시물, 댓글 첨부 파일 테이블 인덱스
CREATE INDEX `IX_tbl_document_attach`
ON `plymind_db`.`tbl_document_attach`( -- 게시물, 댓글 첨부 파일 테이블
  `orig_name` ASC -- 원본 파일명
);

-- 게시물, 댓글 첨부 파일 테이블 인덱스2
CREATE INDEX `IX_tbl_document_attach2`
ON `plymind_db`.`tbl_document_attach`( -- 게시물, 댓글 첨부 파일 테이블
  `member_srl` ASC -- 유저 시리얼 넘버
);

ALTER TABLE `plymind_db`.`tbl_document_attach`
MODIFY COLUMN `file_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '파일 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_document_attach`
AUTO_INCREMENT = 1;



-- 28. 게시물, 파일 매핑 테이블
CREATE TABLE `plymind_db`.`tbl_document_file` (
  `document_srl` BIGINT NOT NULL COMMENT '게시물 시리얼 넘버', -- 게시물 시리얼 넘버
  `file_srl`     BIGINT NOT NULL COMMENT '파일 시리얼 넘버', -- 파일 시리얼 넘버
  `c_date`       INT    NOT NULL COMMENT '생성일' -- 생성일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '게시물, 파일 매핑 테이블';

-- 게시물, 파일 매핑 테이블
ALTER TABLE `plymind_db`.`tbl_document_file`
ADD CONSTRAINT `PK_tbl_document_file` -- 게시물, 파일 매핑 테이블 기본키
PRIMARY KEY (
    `document_srl`, -- 게시물 시리얼 넘버
    `file_srl`      -- 파일 시리얼 넘버
  );

-- 게시물, 파일 매핑 테이블
ALTER TABLE `plymind_db`.`tbl_document_file`
ADD CONSTRAINT `FK_tbl_document_TO_tbl_document_file` -- 게시물 테이블 -> 게시물, 파일 매핑 테이블
FOREIGN KEY (
    `document_srl` -- 게시물 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_document` ( -- 게시물 테이블
    `document_srl` -- 게시물 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_document_TO_tbl_document_file` (
  `document_srl` ASC -- 게시물 시리얼 넘버
);

-- 게시물, 파일 매핑 테이블
ALTER TABLE `plymind_db`.`tbl_document_file`
ADD CONSTRAINT `FK_tbl_document_attach_TO_tbl_document_file` -- 게시물, 댓글 첨부 파일 테이블 -> 게시물, 파일 매핑 테이블
FOREIGN KEY (
    `file_srl` -- 파일 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_document_attach` ( -- 게시물, 댓글 첨부 파일 테이블
    `file_srl` -- 파일 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_document_attach_TO_tbl_document_file` (
  `file_srl` ASC -- 파일 시리얼 넘버
);



-- 29. 회원형 서비스를 위한 접속 토큰 테이블
CREATE TABLE `plymind_db`.`tbl_member_access_token` (
  `token_srl`    BIGINT      NOT NULL COMMENT '토큰 시리얼 넘버', -- 토큰 시리얼 넘버
  `member_srl`   BIGINT      NOT NULL COMMENT '접속 토큰을 발급한 사용자 시리얼 넘버', -- 유저 시리얼 넘버
  `app_srl`      INT         NOT NULL COMMENT '접속 토큰을 발급한 앱 시리얼 넘버', -- 앱 시리얼 넘버
  `access_token` VARCHAR(32) NOT NULL COMMENT '접속 토큰', -- 접속 토큰
  `token_expire` INT         NOT NULL COMMENT '접속 토큰 만료 시간', -- 토큰 만료 시간
  `user_data`    TEXT        NULL     COMMENT '토큰 발급한 사용자 데이터. redis를 사용하지 않을때 사용자 데이터 저장소', -- 사용자 데이터
  `c_date`       INT         NOT NULL COMMENT '생성일', -- 생성일
  `u_date`       INT         NOT NULL COMMENT '수정일' -- 수정일
)
  COMMENT '회원 가입형에서 API 사용을 위한 access_token';

-- 회원형 서비스를 위한 접속 토큰 테이블
ALTER TABLE `plymind_db`.`tbl_member_access_token`
ADD CONSTRAINT `PK_tbl_member_access_token` -- 회원형 서비스를 위한 접속 토큰 테이블 기본키
PRIMARY KEY (
    `token_srl` -- 토큰 시리얼 넘버
  );

-- 회원형 서비스를 위한 접속 토큰 테이블 유니크 인덱스
CREATE UNIQUE INDEX `UIX_tbl_member_access_token`
ON `plymind_db`.`tbl_member_access_token` ( -- 회원형 서비스를 위한 접속 토큰 테이블
  `access_token` ASC -- 접속 토큰
);

-- 회원형 서비스를 위한 접속 토큰 테이블 인덱스
CREATE INDEX `IX_tbl_member_access_token`
ON `plymind_db`.`tbl_member_access_token`( -- 회원형 서비스를 위한 접속 토큰 테이블
  `token_expire` ASC -- 토큰 만료 시간
);

ALTER TABLE `plymind_db`.`tbl_member_access_token`
MODIFY COLUMN `token_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '토큰 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_member_access_token`
AUTO_INCREMENT = 1;

-- 회원형 서비스를 위한 접속 토큰 테이블
ALTER TABLE `plymind_db`.`tbl_member_access_token`
ADD CONSTRAINT `FK_tbl_member_TO_tbl_member_access_token` -- 유저 -> 회원형 서비스를 위한 접속 토큰 테이블
FOREIGN KEY (
    `member_srl` -- 유저 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_member` ( -- 유저
    `member_srl` -- 유저 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_member_TO_tbl_member_access_token` (
  `member_srl` ASC -- 유저 시리얼 넘버
);

-- 회원형 서비스를 위한 접속 토큰 테이블
ALTER TABLE `plymind_db`.`tbl_member_access_token`
ADD CONSTRAINT `FK_tbl_app_TO_tbl_member_access_token` -- 서비스하는 앱 -> 회원형 서비스를 위한 접속 토큰 테이블
FOREIGN KEY (
    `app_srl` -- 앱 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_app` ( -- 서비스하는 앱
    `app_srl` -- 앱 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_app_TO_tbl_member_access_token` (
  `app_srl` ASC -- 앱 시리얼 넘버
);



-- 30. 사용자와 앱 매핑
CREATE TABLE `plymind_db`.`tbl_app_member` (
  `app_srl`         INT         NOT NULL COMMENT '앱 시리얼 넘버', -- 앱 시리얼 넘버
  `member_srl`      BIGINT      NOT NULL COMMENT '사용자 시리얼 넘버', -- 유저 시리얼 넘버
  `nick_name`       VARCHAR(64) NOT NULL COMMENT '앱에서만 사용하는 사용자 별명', -- 별명
  `allow_mailing`   TINYINT     NOT NULL DEFAULT 1 COMMENT '앱에서 메일링 허용 여부', -- 메일링 허용 여부
  `allow_message`   TINYINT     NOT NULL DEFAULT 1 COMMENT '앱에서 메시징(푸시) 허용 여부', -- 메시징 허용 여부
  `last_login_date` INT         NOT NULL COMMENT '앱에 최종 로그인 날짜', -- 최종 로그인 시간
  `enabled`         TINYINT     NOT NULL DEFAULT 1 COMMENT '앱 사용 활성 여부. 1:활성, 2:일시중단, 3:차단', -- 활성 여부
  `c_date`          INT         NOT NULL COMMENT '생성일', -- 생성일
  `u_date`          INT         NOT NULL COMMENT '수정일' -- 수정일
)
  COMMENT '사용자가 가입되어 있는 앱';

-- 사용자와 앱 매핑
ALTER TABLE `plymind_db`.`tbl_app_member`
ADD CONSTRAINT `PK_tbl_app_member` -- 사용자와 앱 매핑 기본키
PRIMARY KEY (
    `app_srl`,    -- 앱 시리얼 넘버
    `member_srl`  -- 유저 시리얼 넘버
  );

-- 사용자와 앱 매핑
ALTER TABLE `plymind_db`.`tbl_app_member`
ADD CONSTRAINT `FK_tbl_app_TO_tbl_app_member` -- 서비스하는 앱 -> 사용자와 앱 매핑
FOREIGN KEY (
    `app_srl` -- 앱 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_app` ( -- 서비스하는 앱
    `app_srl` -- 앱 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_app_TO_tbl_app_member` (
  `app_srl` ASC -- 앱 시리얼 넘버
);

-- 사용자와 앱 매핑
ALTER TABLE `plymind_db`.`tbl_app_member`
ADD CONSTRAINT `FK_tbl_member_TO_tbl_app_member` -- 유저 -> 사용자와 앱 매핑
FOREIGN KEY (
    `member_srl` -- 유저 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_member` ( -- 유저
    `member_srl` -- 유저 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_member_TO_tbl_app_member` (
  `member_srl` ASC -- 유저 시리얼 넘버
);



-- 31. 게시물 링크 테이블
CREATE TABLE `plymind_db`.`tbl_document_link` (
  `document_link_srl` BIGINT NOT NULL COMMENT '게시물 링크 시리얼 넘버', -- 게시물 링크 시리얼 넘버
  `app_srl`           INT    NOT NULL COMMENT '앱 시리얼 넘버', -- 앱 시리얼 넘버
  `board_srl`         BIGINT NOT NULL COMMENT '게시판 시리얼 넘버', -- 게시판 시리얼 넘버
  `category_srl`      BIGINT NOT NULL COMMENT '카테고리 시리얼 넘버', -- 카테고리 시리얼 넘버
  `document_srl`      BIGINT NOT NULL COMMENT '게시물 시리얼 넘버', -- 게시물 시리얼 넘버
  `list_order`        BIGINT NOT NULL DEFAULT 0 COMMENT '링크 게시물 순서', -- 임의 순서
  `c_date`            INT    NOT NULL COMMENT '생성일' -- 생성일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '게시물 링크 테이블';

-- 게시물 링크 테이블
ALTER TABLE `plymind_db`.`tbl_document_link`
ADD CONSTRAINT `PK_tbl_document_link` -- 게시물 링크 테이블 기본키
PRIMARY KEY (
    `document_link_srl` -- 게시물 링크 시리얼 넘버
  );

-- 게시물 링크 테이블 인덱스
CREATE INDEX `IX_tbl_document_link`
ON `plymind_db`.`tbl_document_link`( -- 게시물 링크 테이블
  `list_order` ASC -- 임의 순서
);

ALTER TABLE `plymind_db`.`tbl_document_link`
MODIFY COLUMN `document_link_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '게시물 링크 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_document_link`
AUTO_INCREMENT = 1;

-- 게시물 링크 테이블
ALTER TABLE `plymind_db`.`tbl_document_link`
ADD CONSTRAINT `FK_tbl_app_TO_tbl_document_link` -- 서비스하는 앱 -> 게시물 링크 테이블
FOREIGN KEY (
    `app_srl` -- 앱 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_app` ( -- 서비스하는 앱
    `app_srl` -- 앱 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_app_TO_tbl_document_link` (
  `app_srl` ASC -- 앱 시리얼 넘버
);

-- 게시물 링크 테이블
ALTER TABLE `plymind_db`.`tbl_document_link`
ADD CONSTRAINT `FK_tbl_document_board_TO_tbl_document_link` -- 게시판 테이블 -> 게시물 링크 테이블
FOREIGN KEY (
    `board_srl` -- 게시판 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_document_board` ( -- 게시판 테이블
    `board_srl` -- 게시판 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_document_board_TO_tbl_document_link` (
  `board_srl` ASC -- 게시판 시리얼 넘버
);

-- 게시물 링크 테이블
ALTER TABLE `plymind_db`.`tbl_document_link`
ADD CONSTRAINT `FK_tbl_document_category_TO_tbl_document_link` -- 게시판 카테고리 테이블 -> 게시물 링크 테이블
FOREIGN KEY (
    `category_srl` -- 카테고리 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_document_category` ( -- 게시판 카테고리 테이블
    `category_srl` -- 카테고리 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_document_category_TO_tbl_document_link` (
  `category_srl` ASC -- 카테고리 시리얼 넘버
);

-- 게시물 링크 테이블
ALTER TABLE `plymind_db`.`tbl_document_link`
ADD CONSTRAINT `FK_tbl_document_TO_tbl_document_link` -- 게시물 테이블 -> 게시물 링크 테이블
FOREIGN KEY (
    `document_srl` -- 게시물 시리얼 넘버
  )
REFERENCES `plymind_db`.`tbl_document` ( -- 게시물 테이블
    `document_srl` -- 게시물 시리얼 넘버
  )
  ON DELETE CASCADE,
ADD INDEX `FK_tbl_document_TO_tbl_document_link` (
  `document_srl` ASC -- 게시물 시리얼 넘버
);



-- 9999. 환경 설정
-- 기본 History 용도 sequence 생성
INSERT INTO `plymind_db`.`tbl_sequence` (seq_type, seq_no) VALUES (1, 0);

-- 서비스 루트 그룹 생성
INSERT INTO `plymind_db`.`tbl_group` (group_name, allow_default, authority, description, c_date, u_date)
VALUES ('루트', 2, 'ROLE_ROOT', '서비스 전체 루트 권한', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

-- 정회원용 그룹 생성
INSERT INTO `plymind_db`.`tbl_group` (group_name, allow_default, authority, description, c_date, u_date)
VALUES ('정회원', 2, 'ROLE_USER', '서비스 정회원 권한', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());

-- 방문자용 그룹 생성
INSERT INTO `plymind_db`.`tbl_group` (group_name, allow_default, authority, description, c_date, u_date)
VALUES ('준회원', 1, 'ROLE_VISITOR', '서비스 준회원 권한', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());


-- 기본 준회원(guest@ckstack.com)을 추가 한다.
-- 패스워드는 guest
INSERT INTO `plymind_db`.`tbl_member` (
    user_id, email_address, user_password, user_name, nick_name,
    mobile_phone_number, allow_mailing, allow_message, description, last_login_date,
    change_password_date, enabled, email_confirm, sign_out, c_date,
    u_date
) VALUES (
    'guest@ckstack.com', 'guest@ckstack.com', '$2a$10$XvNTaf2fAmVvfIBWtgiqEetNggEjDmWpQYtNZJbzUR4CGKZRjZa6.',
    '준회원', '준회원',
    '01053728336', 1, 1, '기본 준회원', UNIX_TIMESTAMP(),
    UNIX_TIMESTAMP(), 1, 1, 2, UNIX_TIMESTAMP(),
    UNIX_TIMESTAMP()
);

INSERT INTO `plymind_db`.`tbl_member_extra` (
    member_srl, social_type, social_id, login_count, serial_login_count,
    c_date, u_date
)
SELECT member_srl, -1 as social_type, '' as social_id, 1 as login_count, 1 as serial_login_count, c_date, u_date
FROM `plymind_db`.`tbl_member`
WHERE user_id = 'guest@ckstack.com';

-- 기본 준회원(guest@ckstack.com)을 준회원 그룹에 매핑 시킨다
INSERT INTO `plymind_db`.`tbl_group_member` (
    group_srl, member_srl, c_date
)
SELECT B.group_srl, A.member_srl, A.c_date
FROM `plymind_db`.`tbl_member` A, `plymind_db`.`tbl_group` B
WHERE A.user_id = 'guest@ckstack.com' AND B.authority = 'ROLE_VISITOR';

-- 기본 정회원(member@ckstack.com)을 추가 한다.
-- 패스워드는 member
INSERT INTO `plymind_db`.`tbl_member` (
    user_id, email_address, user_password, user_name, nick_name,
    mobile_phone_number, allow_mailing, allow_message, description, last_login_date,
    change_password_date, enabled, email_confirm, sign_out, c_date,
    u_date
) VALUES (
    'member@ckstack.com', 'member@ckstack.com', '$2a$10$7TRzomW6L8zi9cIQPDwdDOLZtSa6ddh4/mEoqghrpB.D7oxL7JSH.',
    '정회원', '정회원',
    '01053728336', 1, 1, '기본 정회원', UNIX_TIMESTAMP(),
    UNIX_TIMESTAMP(), 1, 1, 2, UNIX_TIMESTAMP(),
    UNIX_TIMESTAMP()
);

INSERT INTO `plymind_db`.`tbl_member_extra` (
    member_srl, social_type, social_id, login_count, serial_login_count,
    c_date, u_date
)
SELECT member_srl, -1 as social_type, '' as social_id, 1 as login_count, 1 as serial_login_count, c_date, u_date
FROM `plymind_db`.`tbl_member`
WHERE user_id = 'member@ckstack.com';

-- 기본 정회원(member@ckstack.com)을 정회원 그룹에 매핑 시킨다
INSERT INTO `plymind_db`.`tbl_group_member` (
    group_srl, member_srl, c_date
)
SELECT B.group_srl, A.member_srl, A.c_date
FROM `plymind_db`.`tbl_member` A, `plymind_db`.`tbl_group` B
WHERE A.user_id = 'member@ckstack.com' AND B.authority = 'ROLE_USER';
