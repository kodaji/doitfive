DROP TABLE IF EXISTS `plymind_db`.`tbl_plymind_advicedomain` RESTRICT;

-- 상담사 영역 정보 테이블
CREATE TABLE `plymind_db`.`tbl_plymind_advicedomain` (
  `advicedomain_srl`    BIGINT    NOT NULL COMMENT '상담영역 시리얼 넘버',
  `advicedomain_type`   INT       NOT NULL COMMENT '상담영역 타입',
  `member_srl`          BIGINT    NOT NULL COMMENT '상담사 시리얼 넘버',
  `advice_domain`        INT       NOT NULL COMMENT '상담 영역'
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '상담사 영역 정보 테이블';

ALTER TABLE `plymind_db`.`tbl_plymind_advicedomain`
ADD CONSTRAINT `PK_tbl_plymind_advicedomain`
PRIMARY KEY (
    `advicedomain_srl`
  );

CREATE INDEX `IX_tbl_plymind_advicedomain1`
ON `plymind_db`.`tbl_plymind_advicedomain`(
  `member_srl` ASC
);

CREATE INDEX `IX_tbl_plymind_advicedomain2`
ON `plymind_db`.`tbl_plymind_advicedomain`(
  `advice_domain` ASC
);

ALTER TABLE `plymind_db`.`tbl_plymind_advicedomain`
MODIFY COLUMN `advicedomain_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '상담사영역 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_plymind_advicedomain`
AUTO_INCREMENT = 1;




insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 7, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 7, 2);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 7, 3);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 7, 4);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 8, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 8, 2);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 8, 3);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 8, 4);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 9, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 9, 2);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 9, 3);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 9, 4);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 10, 2);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 11, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 11, 2);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 11, 3);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 11, 4);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 12, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 12, 2);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 12, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 13, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 13, 2);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 13, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 14, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 14, 2);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 14, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 15, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 15, 2);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 15, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 16, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 16, 2);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 16, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 17, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 17, 2);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 17, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 18, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 18, 2);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 18, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 19, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 19, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 20, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 20, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 21, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 21, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 22, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 22, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 23, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 23, 2);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 24, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 24, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 25, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 25, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 26, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 26, 2);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 27, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 27, 2);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 28, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 28, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 29, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 29, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 30, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 30, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 31, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 31, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 32, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 32, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 33, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 33, 3);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 34, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 34, 2);

insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 35, 1);
insert into `plymind_db`.`tbl_plymind_advicedomain`(advicedomain_type, member_srl, advice_domain) values(2, 35, 3);
