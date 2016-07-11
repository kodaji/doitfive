DROP TABLE IF EXISTS `plymind_db`.`tbl_plymind_holiday` RESTRICT;

-- 휴일 및 상담사 일정 정보 테이블
CREATE TABLE `plymind_db`.`tbl_plymind_holiday` (
  `holiday_srl`       BIGINT        NOT NULL COMMENT '휴일 시리얼 넘버',
  `member_srl`        BIGINT           NOT NULL COMMENT '상담사 시리얼 넘버',
  `holiday_title`     VARCHAR(64)   NOT NULL COMMENT '휴일 명',
  `holiday_date`      VARCHAR(16)   NOT NULL COMMENT '휴일 날짜',
  `holiday_time`      VARCHAR(16)   NOT NULL COMMENT '휴일 시간',
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


