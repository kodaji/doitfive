-- 심리검사 및 심리상담 검사지 저장 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_plymind_document` RESTRICT;
-- 마음일기 저장 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_plymind_diary` RESTRICT;
-- 예약 정보 저장 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_plymind_push` RESTRICT;
-- 휴일 관리 및 상담사 일정 관리
DROP TABLE IF EXISTS `plymind_db`.`tbl_plymind_holiday` RESTRICT;
-- PUSH 메시지 History 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_plymind_noti` RESTRICT;


-- 심리검사 및 심리상담 검사지 저장 테이블
CREATE TABLE `plymind_db`.`tbl_plymind_document` (
  `document_srl`        BIGINT        NOT NULL COMMENT '검사지 시리얼 넘버',
  `application_srl`     BIGINT        NOT NULL COMMENT '상담 시리얼 넘버',
  `application_group`   BIGINT        NOT NULL COMMENT '상담 그룹',
  `advisor_comment`     VARCHAR(256)  NOT NULL COMMENT '상담사 코멘트',
  `checkup_file_srl`    BIGINT                 DEFAULT -1 COMMENT '검사지 파일 시리얼 넘버',
  `reply_file_srl`      BIGINT                 DEFAULT -1 COMMENT '답변지 파일 시리얼 넘버',
  `result_file_srl`     BIGINT                 DEFAULT -1 COMMENT '결과지 파일 시리얼 넘버',
  `checkup_date`        INT                    COMMENT '검사지 등록일',
  `reply_date`          INT                    COMMENT '답변지 등록일',
  `result_date`         INT                    COMMENT '결과지 등록일',
  `c_date`              INT           NOT NULL COMMENT '등록일'
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '검사지 정보 테이블';

ALTER TABLE `plymind_db`.`tbl_plymind_document`
ADD CONSTRAINT `PK_tbl_plymind_document`
PRIMARY KEY (
    `document_srl`
  );

CREATE INDEX `IX_tbl_plymind_document`
ON `plymind_db`.`tbl_plymind_document`(
  `application_group` ASC
);

ALTER TABLE `plymind_db`.`tbl_plymind_document`
MODIFY COLUMN `document_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '검사지 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_plymind_document`
AUTO_INCREMENT = 1;


-- 마음일기 저장 테이블
CREATE TABLE `plymind_db`.`tbl_plymind_diary` (
  `diary_srl`           BIGINT          NOT NULL  COMMENT '마음일기 시리얼 넘버',
  `member_srl`          BIGINT          NOT NULL  COMMENT '회원정보 시리얼 넘버',
  `application_srl`     BIGINT          NOT NULL  COMMENT '상담 시리얼 넘버',
  `application_group`   INT             NOT NULL  COMMENT '상담 그룹',
  `mind_diary`          VARCHAR(256)    NOT NULL  COMMENT '마음일기 내용',
  `c_date`              INT             NOT NULL  COMMENT '생성일',
  `u_date`              INT             NOT NULL  COMMENT '수정일'
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '마음일기 정보 테이블';

ALTER TABLE `plymind_db`.`tbl_plymind_diary`
ADD CONSTRAINT `PK_tbl_plymind_diary`
PRIMARY KEY (
    `diary_srl`
  );

CREATE INDEX `IX_tbl_plymind_diary1`
ON `plymind_db`.`tbl_plymind_diary`(
  `application_srl` ASC
);

CREATE INDEX `IX_tbl_plymind_diary2`
ON `plymind_db`.`tbl_plymind_diary`(
  `application_group` ASC
);

ALTER TABLE `plymind_db`.`tbl_plymind_diary`
MODIFY COLUMN `diary_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '마음일기 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_plymind_diary`
AUTO_INCREMENT = 1;


-- SMSPUSH 예약 정보 테이블
CREATE TABLE `plymind_db`.`tbl_plymind_push` (
  `push_srl`       BIGINT        NOT NULL COMMENT 'smspush 시리얼 넘버',
  `application_srl`   BIGINT        NOT NULL COMMENT '상담 시리얼 넘버',
  `application_group` BIGINT        NOT NULL COMMENT '상담 그룹',
  `push_contents`      VARCHAR(128)  NOT NULL COMMENT 'PUSH 내용',
  `push_date1`        INT           NOT NULL COMMENT '발송일자1',
  `push_date2`        VARCHAR(16)   NOT NULL COMMENT '발송일자2'
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT 'SMSPUSH 예약 정보 테이블';

ALTER TABLE `plymind_db`.`tbl_plymind_push`
ADD CONSTRAINT `PK_tbl_plymind_push`
PRIMARY KEY (
    `push_srl`
  );

CREATE INDEX `IX_tbl_plymind_push1`
ON `plymind_db`.`tbl_plymind_push`(
  `application_srl` ASC
);

CREATE INDEX `IX_tbl_plymind_push2`
ON `plymind_db`.`tbl_plymind_push`(
  `application_group` ASC
);

ALTER TABLE `plymind_db`.`tbl_plymind_push`
MODIFY COLUMN `push_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'smspush 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_plymind_push`
AUTO_INCREMENT = 1;

-- PUSH 메시지 History 테이블
CREATE TABLE `plymind_db`.`tbl_plymind_noti` (
  `noti_srl`          BIGINT       NOT NULL COMMENT 'PUSH 메시지 시리얼 넘버',
  `application_group` INT          NULL     COMMENT '상담 그룹',
  `application_srl`   BIGINT       NULL     COMMENT '상담 시리얼 넘버',
  `noti_type`         TINYINT      NULL     COMMENT 'PUSH 메시지 종류, 1-너나들이, 2-공지사항, 3-그룹테라피, 4-개인테라피',
  `member_srl`        BIGINT       NULL     COMMENT 'PUSH 메시지 받은 사람 member_srl',
  `user_id`           VARCHAR(128) NULL     COMMENT 'PUSH 메시지 받은 사람 user_id',
  `push_title`        VARCHAR(128) NULL     COMMENT 'PUSh 메시지 제목',
  `push_text`         TEXT         NOT NULL COMMENT 'PUSH 메시지 본문',
  `callback_url`      VARCHAR(256) NULL     COMMENT 'callback URL',
  `push_status`       TINYINT      NOT NULL DEFAULT 1 COMMENT 'PUSH 상태, 1-메시지 발송 전, 2-메시지 발송됨',
  `book_time`         INT          NOT NULL COMMENT '예약시간',
  `noti_time1`        INT          NULL     COMMENT '발송시간1',
  `noti_time2`        VARCHAR(16)  NULL     COMMENT '발송시간2',
  `c_date`            INT          NOT NULL COMMENT '생성일'
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = MyISAM
  COMMENT 'PUSH 메시지 History 테이블';

ALTER TABLE `plymind_db`.`tbl_plymind_noti`
ADD CONSTRAINT `PK_tbl_plymind_noti`
PRIMARY KEY (
    `noti_srl`
  );

CREATE INDEX `IX_tbl_plymind_noti1`
ON `plymind_db`.`tbl_plymind_noti`(
  `noti_type` ASC
);

CREATE INDEX `IX_tbl_plymind_noti2`
ON `plymind_db`.`tbl_plymind_noti`(
  `user_id` ASC
);

ALTER TABLE `plymind_db`.`tbl_plymind_noti`
MODIFY COLUMN `noti_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'PUSH 메시지 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_plymind_noti`
AUTO_INCREMENT = 1;

-- 휴일 및 상담사 일정 정보 테이블
CREATE TABLE `plymind_db`.`tbl_plymind_holiday` (
  `holiday_srl`       BIGINT        NOT NULL COMMENT '휴일 시리얼 넘버',
  `member_srl`        INT           NOT NULL COMMENT '상담사 시리얼 넘버',
  `holiday_title`     VARCHAR(64)   NOT NULL COMMENT '휴일 명',
  `holiday_date`      VARCHAR(16)   NOT NULL COMMENT '휴일 날짜',
  `c_date`            INT           NOT NULL COMMENT '등록일'
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '휴일관리 정보 테이블';

ALTER TABLE `plymind_db`.`tbl_plymind_holiday`
ADD CONSTRAINT `PK_tbl_plymind_holiday`
PRIMARY KEY (
    `holiday_srl`
  );

CREATE INDEX `IX_tbl_plymind_holiday`
ON `plymind_db`.`tbl_plymind_holiday`(
  `member_srl` ASC
);

ALTER TABLE `plymind_db`.`tbl_plymind_holiday`
MODIFY COLUMN `holiday_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '휴일 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_plymind_holiday`
AUTO_INCREMENT = 1;

