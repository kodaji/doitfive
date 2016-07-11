-- 심리검사 및 심리상담 정보 저장 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_plymind_contents` RESTRICT;
-- 심리검사 및 심리상담 상품 정보 저장 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_plymind_product` RESTRICT;


-- 심리검사 및 심리상담 정보 저장 테이블
CREATE TABLE `plymind_db`.`tbl_plymind_contents` (
  `contents_srl`    BIGINT        NOT NULL COMMENT '켄텐츠 시리얼 넘버',
  `kind`            INT           NOT NULL COMMENT '구분',
  `title`           VARCHAR(64)   NOT NULL COMMENT '컨텐츠명',
  `description`     VARCHAR(512)  COMMENT '컨텐츠 설명',
  `contents`        VARCHAR(128)  COMMENT '상담 내용',
  `advice_time`     VARCHAR(64)   COMMENT '상담 시간',
  `method`          VARCHAR(128)  COMMENT '상담 방법',
  `c_date`          INT           NOT NULL COMMENT '생성일',
  `u_date`          INT           NOT NULL COMMENT '수정일'
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '컨텐츠 정보 테이블';

ALTER TABLE `plymind_db`.`tbl_plymind_contents`
ADD CONSTRAINT `PK_tbl_plymind_contents`
PRIMARY KEY (
    `contents_srl`
  );

ALTER TABLE `plymind_db`.`tbl_plymind_contents`
MODIFY COLUMN `contents_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '켄텐츠 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_plymind_contents`
AUTO_INCREMENT = 1;


-- 심리검사 및 심리상담 상품 정보 저장 테이블
CREATE TABLE `plymind_db`.`tbl_plymind_product` (
  `product_srl`     BIGINT        NOT NULL COMMENT '상품 시리얼 넘버',
  `contents_srl`    BIGINT        NOT NULL COMMENT '켄텐츠 시리얼 넘버',
  `advice_type`     INT           NOT NULL COMMENT '상담 유형',
  `advice_period`   INT           NOT NULL COMMENT '상담 기간',
  `advice_number`   INT           NOT NULL COMMENT '상담 횟수',
  `advice_price`    INT           NOT NULL COMMENT '상담 가격',
  `benefit`         VARCHAR(512)           COMMENT '혜택',
  `c_date`          INT           NOT NULL COMMENT '생성일',
  `u_date`          INT           NOT NULL COMMENT '수정일'
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '상품 정보 테이블';

ALTER TABLE `plymind_db`.`tbl_plymind_product`
ADD CONSTRAINT `PK_tbl_plymind_product` -- 사전검사 분류 기본키
PRIMARY KEY (
    `product_srl` -- 분류 시리얼 넘버
  );

ALTER TABLE `plymind_db`.`tbl_plymind_product`
MODIFY COLUMN `product_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '상품 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_plymind_product`
AUTO_INCREMENT = 1;


--  컨텐츠 정보 등록
INSERT INTO `plymind_db`.`tbl_plymind_contents` (
    contents_srl, kind, title, description, advice_time, method, c_date, u_date
) VALUES (
    1, 1, '싸이케어테라피', '', '', '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  컨텐츠 정보 등록
INSERT INTO `plymind_db`.`tbl_plymind_contents` (
    contents_srl, kind, title, description, advice_time, method, c_date, u_date
) VALUES (
    2, 1, '커플싸이케어테라피', '', '', '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  컨텐츠 정보 등록
INSERT INTO `plymind_db`.`tbl_plymind_contents` (
    contents_srl, kind, title, description, contents, advice_time, method, c_date, u_date
) VALUES (
    3, 1, '스카이프케어테라피', '', '스카이프상담 1회', '09:00~18:00 상담 1회 시간은 45분', '평일 업무시간 내에 언제든지 전화상담 가능함', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  컨텐츠 정보 등록
INSERT INTO `plymind_db`.`tbl_plymind_contents` (
    contents_srl, kind, title, description, contents, advice_time, method, c_date, u_date
) VALUES (
    4, 1, '텍스트케어테라피', '', '텍스트상담 1회', '1회 45분씩 소요', '내담자와 상담사는 지정된 시간에 1:1 카카오톡 대화를 통해 고민상담 및 문제해결 방안 모색', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  컨텐츠 정보 등록
INSERT INTO `plymind_db`.`tbl_plymind_contents` (
    contents_srl, kind, title, description, contents, advice_time, method, c_date, u_date
) VALUES (
    5, 1, '컨텐츠케어테라피', '', '평일 일 4회씩 토/일 일 1회씩 1주간 진행', '1회 5~20분씩 소요', '-유형별 컨텐츠 제공\n 1. 하루 4개의 컨텐츠 제공(월~금)\n 2. 인문학에 대한 봉닌의 생각을 정리할 수 있는 문구 제공(토~일)', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  컨텐츠 정보 등록
INSERT INTO `plymind_db`.`tbl_plymind_contents` (
    contents_srl, kind, title, description, contents, advice_time, method, c_date, u_date
) VALUES (
    6, 2, '스트레스와 적응', '지금 당신이 문제라고 생각되는 것은 환경이 주는 다양한 스트레스가 원인입니다.\n 어떤 원인이 문제를 발생하게 만들었는지 아는 것 만으로도 현재 가진 문제를 해결할 실마리를 찾을 수 있습니다.\n 또한 사람마다 스트레스를 극복하고 환경에 적응하는 과정은 조금씩 달라서 나의 스트레스 원인을 파악하고 대처하는 방법을 알 수 있다면 사전에 예방하거나 문제가 생겨도 빨리 해결할 수 있습니다.', '', '', '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  컨텐츠 정보 등록
INSERT INTO `plymind_db`.`tbl_plymind_contents` (
    contents_srl, kind, title, description, contents, advice_time, method, c_date, u_date
) VALUES (
    7, 2, '학습', '무언가를 배우고 익히는 학습의 과정은 개인에 따라 다릅니다.\n 어떤 개인은 조용히 반복적으로 연습하여 배우고자 할 수 있고, 또 다른 누군가는 자신만의 독특한 학습법이 있을 수 있습니다.\n 완벽한 학습 방법은 없지만 나의 학습법의 취약성을 확인하고 보완점을 찾을 수는 있습니다.\n 또한 학습방법은 항상 동일하지 않아서 무엇을 새롭게 익히려 하느냐에 따라 사용하는 방법은 달라져야 합니다.\n 마치 무엇을 먹느냐에 따라 사용하는 도구가 달라지는 것과 같습니다.', '', '', '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  컨텐츠 정보 등록
INSERT INTO `plymind_db`.`tbl_plymind_contents` (
    contents_srl, kind, title, description, contents, advice_time, method, c_date, u_date
) VALUES (
    8, 2, '창의성', '미래사회에 적응하기 위한 전략으로 많은 사람들은 창의성이 있어야 한다고 합니다.\n 또한 창의성을 증진하기 위한 다양한 방법들을 찾고 싶어합니다.\n 창의성은 몇 가지 영역에서 다르게 나타날 수 있으며 내가 어떤 분야에 더 창의적인 능력을 가지고 있는지 사람마다 다릅니다.\n 내가 어떤 영역에서 보다 창의적인지 파악하게 되면 자신에게 맞는 특화된 창의성을 발휘하는 것이 가능하게 될 수 있습니다.', '', '', '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  컨텐츠 정보 등록
INSERT INTO `plymind_db`.`tbl_plymind_contents` (
    contents_srl, kind, title, description, contents, advice_time, method, c_date, u_date
) VALUES (
    9, 2, '회복탄력성', '가중된 스트레스 상황에서 사람들 마다 이를 해결하고 이겨내는 데 걸리는 시간이나 회복할 수 있는 시점이 다릅니다.\n 사람들이 본인의 회복탄력성을 증진하기 위해 많은 전략들을 활용하지만 더 긍정적인 방법을 찾는데 어려움을 겪곤합니다.\n 회복탄력성은 사람마다 다르게 나타날 수 있으며 그 시점 또한 매우 상이합니다.\n 따라서 나의 회복탄력성의 정도와 발휘할 수 있는 전략들을 파악하게 되면 보다 긍정적인 적응능력을 증진하는 것이 가능하게 될 수 있습니다.', '', '', '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);


--  상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    1, 1, 0, 12, 12, 450000, '- 1회 가장 스카이프케어테라피(텍스트 케어테라피 중 선택 가능)', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    2, 1, 0, 24, 24, 800000, '- 1회 으뜸 스카이프케어테라피(텍스트 케어테라피 중 선택 가능)', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    3, 1, 0, 52, 52, 1200000, '- 1회 한마루 스카이프케어테라피(텍스트 케어테라피 중 선택 가능) \n - 1회 심리콘서트 초대 \n - 1회 한의사와 함께하는 마음톡톡', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    4, 2, 0, 12, 12, 800000, '- 1회 가장 텔레케어케어테라피(텍스트 케어테라피 중 선택 가능)', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    5, 2, 0, 24, 24, 1500000, '- 1회 으뜸 커플 텔레케어케어테라피(텍스트 케어테라피 중 선택 가능)', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    6, 2, 0, 52, 52, 2900000, '- 1회 한마루 커플 텔레케어케어테라피(텍스트 케어테라피 중 선택 가능) \n - 1회 커플 심리콘서트 초대 \n - 1회 커플 한의사와 함께하는 마음톡톡', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    7, 3, 1, 0, 1, 45000, '10회 이상 진행하면 사전사후 검사를 통해서 마음리포트를 제공받으실 수 있습니다.', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    8, 3, 1, 0, 10, 450000, '10회 이상 진행하면 사전사후 검사를 통해서 마음리포트를 제공받으실 수 있습니다.', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    9, 3, 2, 0, 1, 90000, '10회 이상 진행하면 사전사후 검사를 통해서 마음리포트를 제공받으실 수 있습니다.', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    10, 3, 2, 0, 10, 900000, '10회 이상 진행하면 사전사후 검사를 통해서 마음리포트를 제공받으실 수 있습니다.', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    11, 3, 3, 0, 1, 135000, '10회 이상 진행하면 사전사후 검사를 통해서 마음리포트를 제공받으실 수 있습니다.', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    12, 3, 3, 0, 10, 1350000, '10회 이상 진행하면 사전사후 검사를 통해서 마음리포트를 제공받으실 수 있습니다.', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    13, 4, 1, 0, 1, 40000, '10회 이상 진행하면 사전사후 검사를 통해서 마음리포트를 제공받으실 수 있습니다.', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    14, 4, 1, 0, 10, 400000, '10회 이상 진행하면 사전사후 검사를 통해서 마음리포트를 제공받으실 수 있습니다.', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    15, 4, 2, 0, 1, 80000, '10회 이상 진행하면 사전사후 검사를 통해서 마음리포트를 제공받으실 수 있습니다.', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    16, 4, 2, 0, 10, 800000, '10회 이상 진행하면 사전사후 검사를 통해서 마음리포트를 제공받으실 수 있습니다.', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    17, 4, 3, 0, 1, 120000, '10회 이상 진행하면 사전사후 검사를 통해서 마음리포트를 제공받으실 수 있습니다.', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    18, 4, 3, 0, 10, 1200000, '10회 이상 진행하면 사전사후 검사를 통해서 마음리포트를 제공받으실 수 있습니다.', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    19, 5, 0, 1, 22, 30000, '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    20, 5, 0, 4, 88, 100000, '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    21, 5, 0, 12, 264, 200000, '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    22, 6, 0, 1, 1, 10000, '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    23, 7, 0, 1, 1, 10000, '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    24, 8, 0, 1, 1, 10000, '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 상품 등록
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    25, 9, 0, 1, 1, 10000, '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);


-- 추가상품 ( 싸이케어테라피 4주 1개월 150,000원 )
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    26, 1, 0, 4, 4, 150000, '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 추가상품 ( 커플싸이케어테라피 4주 1개월 300,000원 )
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    27, 2, 0, 4, 4, 300000, '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

-- 추가상품 ( 컨텐츠케어테라피 1일 5,000원 )
INSERT INTO `plymind_db`.`tbl_plymind_product` (
    product_srl, contents_srl, advice_type, advice_period, advice_number, advice_price, benefit, c_date, u_date
) VALUES (
    28, 5, 0, 1, 4, 5000, '', UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);