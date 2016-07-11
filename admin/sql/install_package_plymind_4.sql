-- 상담 정보 저장 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_plymind_application` RESTRICT;
-- 결제 정보 저장 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_plymind_payment` RESTRICT;
-- 예약 정보 저장 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_plymind_appointment` RESTRICT;
-- 싸이케어세라피 / 커플케어세라피 수령지 주소 저장 정보 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_plymind_address` RESTRICT;


-- 결제 정보 테이블
CREATE TABLE `plymind_db`.`tbl_plymind_application` (
  `application_srl`         BIGINT          NOT NULL COMMENT '상담 시리얼 넘버',
  `application_group`       INT             NOT NULL COMMENT '상담 그룹',
  `application_number`      INT             NOT NULL COMMENT '상담 회차',
  `application_status`      INT             NOT NULL COMMENT '상담 진행 상태',
  `member_srl`              BIGINT          NOT NULL COMMENT '고객 시리얼 넘버',
  `product_srl`             BIGINT          NOT NULL COMMENT '상품 시리얼 넘버',
  `advisor_srl`             BIGINT                   COMMENT '상담사 시리얼 넘버',
  `start_date`              VARCHAR(16)              COMMENT '상담 시작일',
  `end_date`                VARCHAR(16)              COMMENT '상담 종료일',
  `push_date`               VARCHAR(16)              COMMENT 'PUSH 날짜',
  `push_time`               VARCHAR(8)               COMMENT 'PUSH 시간',
  `c_date`                  INT             NOT NULL COMMENT '신청일',
  `u_date`                  INT             NOT NULL COMMENT '수정일'
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '상담 정보 테이블';

ALTER TABLE `plymind_db`.`tbl_plymind_application`
ADD CONSTRAINT `PK_tbl_plymind_application` -- 사전검사 분류 기본키
PRIMARY KEY (
    `application_srl` -- 분류 시리얼 넘버
  );

CREATE INDEX `IX_tbl_plymind_application1`
ON `plymind_db`.`tbl_plymind_application`(
  `application_number` ASC
);

CREATE INDEX `IX_tbl_plymind_application2`
ON `plymind_db`.`tbl_plymind_application`(
  `member_srl` ASC
);

CREATE INDEX `IX_tbl_plymind_application3`
ON `plymind_db`.`tbl_plymind_application`(
  `advisor_srl` ASC
);

ALTER TABLE `plymind_db`.`tbl_plymind_application`
MODIFY COLUMN `application_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '상담 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_plymind_application`
AUTO_INCREMENT = 1;


-- 결제 정보 테이블
CREATE TABLE `plymind_db`.`tbl_plymind_payment` (
  `payment_srl`         BIGINT          NOT NULL  COMMENT '결제 시리얼 넘버',
  `member_srl`          BIGINT          NOT NULL  COMMENT '고객 시리얼 넘버',
  `product_srl`         BIGINT          NOT NULL  COMMENT '컨텐츠 시리얼 넘버',
  `application_group`   INT             NOT NULL  COMMENT '신청 시리얼 넘버',
  `payment_name`        VARCHAR(32)     NOT NULL  COMMENT '입금자명',
  `payment_phone`       VARCHAR(16)     NOT NULL  COMMENT '입금자 휴대폰번호',
  `price`               INT             NOT NULL  COMMENT '가격',
  `receipt_kind`        INT             NOT NULL  COMMENT '영수증',
  `receipt_phone`       VARCHAR(16)               COMMENT '영수증',
  `payment_status`      INT             NOT NULL  COMMENT '결제 상태',
  `refund_bank`         VARCHAR(32)               COMMENT '환불은행',
  `refund_account`      VARCHAR(32)               COMMENT '환불계좌',
  `refund_name`         VARCHAR(32)               COMMENT '환불계좌명',
  `reporting_date`      INT             NOT NULL  COMMENT '신청일',
  `cancel_date`         INT                       COMMENT '취소일',
  `payment_date`        INT                       COMMENT '결제일',
  `refund_req_date`     INT                       COMMENT '환불요청일',
  `refund_date`         INT                       COMMENT '환불일'
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '결제 정보 테이블';

ALTER TABLE `plymind_db`.`tbl_plymind_payment`
ADD CONSTRAINT `PK_tbl_plymind_payment` -- 사전검사 분류 기본키
PRIMARY KEY (
    `payment_srl` -- 분류 시리얼 넘버
  );

CREATE INDEX `IX_tbl_plymind_payment1`
ON `plymind_db`.`tbl_plymind_payment`(
  `member_srl` ASC
);

ALTER TABLE `plymind_db`.`tbl_plymind_payment`
MODIFY COLUMN `payment_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '결제 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_plymind_payment`
AUTO_INCREMENT = 1;


-- 예약 정보 테이블
CREATE TABLE `plymind_db`.`tbl_plymind_appointment` (
  `appointment_srl`     BIGINT          NOT NULL COMMENT '예약 시리얼 넘버',
  `member_srl`          BIGINT          NOT NULL COMMENT '고객 시리얼 넘버',
  `advisor_srl`         BIGINT          NOT NULL COMMENT '상담사 시리얼 넘버',
  `application_srl`     BIGINT          NOT NULL COMMENT '상담 시리얼 넘버',
  `appointment_date`    VARCHAR(16)     NOT NULL COMMENT '예약 날짜',
  `appointment_time`    VARCHAR(16)     NOT NULL COMMENT '예약 시간',
  `appointment_status`  INT             NOT NULL COMMENT '상태',
  `c_date`              INT             NOT NULL COMMENT '생성일',
  `u_date`              INT             NOT NULL COMMENT '수정일'
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '예약 정보 테이블';

ALTER TABLE `plymind_db`.`tbl_plymind_appointment`
ADD CONSTRAINT `PK_tbl_plymind_appointment`
PRIMARY KEY (
    `appointment_srl`
  );

CREATE INDEX `IX_tbl_plymind_appointment1`
ON `plymind_db`.`tbl_plymind_appointment`(
  `member_srl` ASC
);

CREATE INDEX `IX_tbl_plymind_appointment2`
ON `plymind_db`.`tbl_plymind_appointment`(
  `advisor_srl` ASC
);

ALTER TABLE `plymind_db`.`tbl_plymind_appointment`
MODIFY COLUMN `appointment_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '예약 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_plymind_appointment`
AUTO_INCREMENT = 1;

-- 싸이케어세라피 / 커플케어세라피 수령지 주소 저장 정보 테이블
CREATE TABLE `plymind_db`.`tbl_plymind_address` (
  `address_srl`         BIGINT        NOT NULL COMMENT '수령지 주소 시리얼 넘버',
  `application_group`   INT           NOT NULL COMMENT '상담 그룹',
  `receive_name`        VARCHAR(16)   NOT NULL COMMENT '수령인 이름',
  `receive_phone`       VARCHAR(16)   NOT NULL COMMENT '수령인 폰번호',
  `receive_address`     VARCHAR(128)  NOT NULL COMMENT '수령지 주소',
  `c_date`              INT           NOT NULL COMMENT '고객 시리얼 넘버',
  `u_date`              INT           NOT NULL COMMENT '상품 시리얼 넘버'
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '수령지 정보 테이블';

ALTER TABLE `plymind_db`.`tbl_plymind_address`
ADD CONSTRAINT `PK_tbl_plymind_address` -- 사전검사 분류 기본키
PRIMARY KEY (
    `address_srl` -- 분류 시리얼 넘버
  );

CREATE INDEX `IX_tbl_plymind_address1`
ON `plymind_db`.`tbl_plymind_address`(
  `application_group` ASC
);

ALTER TABLE `plymind_db`.`tbl_plymind_address`
MODIFY COLUMN `address_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '수령지 주소 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_plymind_address`
AUTO_INCREMENT = 1;




