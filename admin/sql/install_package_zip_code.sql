CREATE TABLE `plymind_db`.`tbl_zipcode` (
`zipcode_srl` bigint(11)  COMMENT '우편번호 시리얼넘버', -- 우편번호 시리얼넘버
 `zipcode`		VARCHAR(8)	COMMENT '우편번호', -- 우편번호
 `sido`		VARCHAR(32)	COMMENT '시 도', -- 시 도
 `sigungu`		VARCHAR(32)	COMMENT '시 군 구', -- 시 군 구
 `dong`		VARCHAR(32)	COMMENT '읍 면', -- 읍 면
 `doromyung`		VARCHAR(128)	COMMENT	'도로명', -- 도로명
 `konmulbunho_bonbun`	VARCHAR(8)	COMMENT '건물번호 본번', -- 건물번호 본번
 `konmulbunho_bubun`	VARCHAR(8)	COMMENT	'건물번호 부번', -- 건물번호 부번
 `konmul_myung`	VARCHAR(256)	COMMENT '시군구용 건물명', -- 시군구용 건물명
 `bubjungdong`	VARCHAR(32)	COMMENT '법정 동명', -- 법정 동명
 `ri`             VARCHAR(32) COMMENT '리명', -- 리명
 `hangjungdong`	VARCHAR(64)	COMMENT '행정 동명', -- 행정 동명
 `jibunbonbun`	VARCHAR(4)	COMMENT '지번 본번', -- 지번 본번
 `jibunbubun`	VARCHAR(4)	COMMENT '지번 부번' -- 지번 부번
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = MyISAM
  COMMENT '우편번호 정보 테이블';

-- 유저
ALTER TABLE `plymind_db`.`tbl_zipcode`
ADD CONSTRAINT `PK_tbl_zipcode` -- 기본키
PRIMARY KEY (
    `zipcode_srl` -- 우편번호 시리얼넘버
  );

alter table `plymind_db`.`tbl_zipcode` modify `zipcode_srl` bigint(11) NOT NULL AUTO_INCREMENT;
