-- 사전검사 문의사항 저장 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_pretesting_question` RESTRICT;
-- 사전검사 분류 저장 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_pretesting_kind` RESTRICT;
-- 사전검사 항목 저장 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_pretesting_item` RESTRICT;
-- 사전검사 신청 테이블
DROP TABLE IF EXISTS `plymind_db`.`tbl_pretesting_application` RESTRICT;

-- 사전검사 문의사항 저장 테이블
CREATE TABLE `plymind_db`.`tbl_pretesting_question` (
  `question_srl`  BIGINT        NOT NULL COMMENT '문의사항 시리얼 넘버',
  `question`      VARCHAR(256)  NOT NULL COMMENT '문의사항',
  `sort`          INT           NOT NULL COMMENT '순서',
  `c_date`        INT           NOT NULL COMMENT '생성일', -- 생성일
  `u_date`        INT           NOT NULL COMMENT '수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '사전검사 문의사항 테이블';

ALTER TABLE `plymind_db`.`tbl_pretesting_question`
ADD CONSTRAINT `PK_tbl_pretesting_question` -- 사전검사 문의사항 기본키
PRIMARY KEY (
    `question_srl` -- 사전검사 문의사항 시리얼 넘버
  );

ALTER TABLE `plymind_db`.`tbl_pretesting_question`
MODIFY COLUMN `question_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '문의사항 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_pretesting_question`
AUTO_INCREMENT = 1;


-- 사전검사 분류 저장 테이블
CREATE TABLE `plymind_db`.`tbl_pretesting_kind` (
  `kind_srl`    BIGINT      NOT NULL COMMENT '분류 시리얼 넘버',
  `kind`        VARCHAR(64) NOT NULL COMMENT '분류',
  `sort`        INT         NOT NULL COMMENT '순서',
  `c_date`      INT         NOT NULL COMMENT '생성일', -- 생성일
  `u_date`      INT         NOT NULL COMMENT '수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '사전검사 분류 테이블';

ALTER TABLE `plymind_db`.`tbl_pretesting_kind`
ADD CONSTRAINT `PK_tbl_pretesting_kind` -- 사전검사 분류 기본키
PRIMARY KEY (
    `kind_srl` -- 분류 시리얼 넘버
  );

ALTER TABLE `plymind_db`.`tbl_pretesting_kind`
MODIFY COLUMN `kind_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '분류 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_pretesting_kind`
AUTO_INCREMENT = 0;


-- 사전검사 항목 저장 테이블
CREATE TABLE `plymind_db`.`tbl_pretesting_item` (
  `item_srl`      BIGINT        NOT NULL COMMENT '항목 시리얼 넘버',
  `question_srl`  BIGINT        NOT NULL COMMENT '문의사항 시리얼 넘버',
  `kind_srl`      BIGINT        NOT NULL COMMENT '분류 시리얼 넘버',
  `item`          VARCHAR(64)   NOT NULL COMMENT '항목',
  `sort`          INT           NOT NULL COMMENT '순서',
  `c_date`        INT           NOT NULL COMMENT '생성일', -- 생성일
  `u_date`        INT           NOT NULL COMMENT '수정일' -- 수정일
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '사전검사 항목 테이블';

ALTER TABLE `plymind_db`.`tbl_pretesting_item`
ADD CONSTRAINT `PK_tbl_pretesting_item` -- 사전검사 문의사항 기본키
PRIMARY KEY (
    `item_srl` -- 문의사항 시리얼 넘버
  );

-- 디바이스 관리 인덱스
CREATE INDEX `IX_tbl_pretesting_item1`
ON `plymind_db`.`tbl_pretesting_item`(
  `question_srl` ASC
);

-- 디바이스 관리 인덱스
CREATE INDEX `IX_tbl_pretesting_item2`
ON `plymind_db`.`tbl_pretesting_item`(
  `kind_srl` ASC
);

ALTER TABLE `plymind_db`.`tbl_pretesting_item`
MODIFY COLUMN `item_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '항목 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_pretesting_item`
AUTO_INCREMENT = 1;


-- 사전검사 신청 테이블
CREATE TABLE `plymind_db`.`tbl_pretesting_application` (
  `application_srl`   BIGINT        NOT NULL COMMENT '신청 시리얼 넘버',
  `member_srl`        BIGINT        NOT NULL COMMENT '고객 시리얼 넘버',
  `question_srl`      BIGINT        NOT NULL COMMENT '문의사항 시리얼 넘버',
  `kind_srl`          BIGINT        NOT NULL COMMENT '분류 시리얼 넘버',
  `item_srl`          BIGINT        NOT NULL COMMENT '항목 시리얼 넘버',
  `contents`          VARCHAR(256)  NOT NULL COMMENT '직접 입력 사항',
  `c_date`            INT           NOT NULL COMMENT '생성일'
)
  DEFAULT CHARACTER SET = 'utf8'
  DEFAULT COLLATE = 'utf8_general_ci'
  ENGINE = InnoDB
  COMMENT '사전검사 신청 테이블';

ALTER TABLE `plymind_db`.`tbl_pretesting_application`
ADD CONSTRAINT `PK_tbl_pretesting_application` -- 사전검사 분류 기본키
PRIMARY KEY (
    `application_srl` -- 분류 시리얼 넘버
  );

ALTER TABLE `plymind_db`.`tbl_pretesting_application`
MODIFY COLUMN `application_srl` BIGINT NOT NULL AUTO_INCREMENT COMMENT '신청 시리얼 넘버';

ALTER TABLE `plymind_db`.`tbl_pretesting_application`
AUTO_INCREMENT = 0;


--  사전검사 문의사항 등록
INSERT INTO `plymind_db`.`tbl_pretesting_question` (
    question_srl, question, sort, c_date, u_date
) VALUES (
    1, '아래의 내용 중 당신이 문제라고 지각하는 부분이 있다면 무엇인가요? 무엇이 가장 큰 고민인지 3가지만 골라서 순서대로 작성해 주십시오.', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 문의사항 등록
INSERT INTO `plymind_db`.`tbl_pretesting_question` (
    question_srl, question, sort, c_date, u_date
) VALUES (
    2, '다음의 26까지의 특징들 중 자신을 설명하기에 적합한 것들을 골라주십시오. 너무 오래 생각하지 말고 떠오르는 대로 바로 선택해 주시면 됩니다. 있는 대로 모두 고르시면 됩니다.', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 문의사항 등록
INSERT INTO `plymind_db`.`tbl_pretesting_question` (
    question_srl, question, sort, c_date, u_date
) VALUES (
    3, '플리마인드에서 케어테라피서비스를 제공받고 달라진 모습을 기대한다면 어떻게 달라질 수 있을 것 같은지 내 삶의 모습을 자유롭게 기술해 주시기 바랍니다.', 3, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);


--  사전검사 분류 등록
INSERT INTO `plymind_db`.`tbl_pretesting_kind` (
    kind_srl, kind, sort, c_date, u_date
) VALUES (
    1, '정서 스트레스', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 분류 등록
INSERT INTO `plymind_db`.`tbl_pretesting_kind` (
    kind_srl, kind, sort, c_date, u_date
) VALUES (
    2, '개인영역', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 분류 등록
INSERT INTO `plymind_db`.`tbl_pretesting_kind` (
    kind_srl, kind, sort, c_date, u_date
) VALUES (
    3, '가정영역', 3, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 분류 등록
INSERT INTO `plymind_db`.`tbl_pretesting_kind` (
    kind_srl, kind, sort, c_date, u_date
) VALUES (
    4, '대인관계', 4, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 분류 등록
INSERT INTO `plymind_db`.`tbl_pretesting_kind` (
    kind_srl, kind, sort, c_date, u_date
) VALUES (
    5, '학교 및 직업', 5, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 분류 등록
INSERT INTO `plymind_db`.`tbl_pretesting_kind` (
    kind_srl, kind, sort, c_date, u_date
) VALUES (
    6, '중독영역', 6, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 분류 등록
INSERT INTO `plymind_db`.`tbl_pretesting_kind` (
    kind_srl, kind, sort, c_date, u_date
) VALUES (
    7, '기타', 7, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 분류 등록
INSERT INTO `plymind_db`.`tbl_pretesting_kind` (
    kind_srl, kind, sort, c_date, u_date
) VALUES (
    998, '분류없음', 8, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 분류 등록
INSERT INTO `plymind_db`.`tbl_pretesting_kind` (
    kind_srl, kind, sort, c_date, u_date
) VALUES (
    999, '직접입력', 9, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    1, 1, 1,'스트레스 / 압박감', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    2, 1, 1,'특이한 생각 / 행동', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    3, 1, 1,'두통 / 통증', 3, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    4, 1, 1,'체중 증가 / 감소', 4, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    5, 1, 1,'불면증', 5, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    6, 1, 1,'분노 / 화', 6, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    7, 1, 1,'우울감 / 무기력', 7, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    8, 1, 1,'불안 / 초조', 8, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    9, 1, 1,'충동성', 9, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    10, 1, 1,'환청 등 기괴한 경험', 10, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    11, 1, 2,'폭력', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    12, 1, 2,'외모', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    13, 1, 2,'자신감 부족', 3, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    14, 1, 2,'의사결정', 4, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    15, 1, 2,'성', 5, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    16, 1, 2,'빚', 6, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    17, 1, 3,'부모와의 관계', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    18, 1, 3,'부부관계', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    19, 1, 3,'자녀관계', 3, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    20, 1, 3,'가정 내 폭력 및 폭언', 4, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    21, 1, 3,'형제자매와의 관계', 5, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    22, 1, 4,'이성교제', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    23, 1, 4,'선생님과의 관계', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    24, 1, 4,'친구(동료) 관계', 3, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    25, 1, 4,'따돌림', 4, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    26, 1, 4,'상사와의 관계', 5, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    27, 1, 5,'진로결정 / 갈등', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    28, 1, 5,'진로 정보 부족', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    29, 1, 5,'성적(성취) 부진 / 하락', 3, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    30, 1, 5,'시험(평가) 불안', 4, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    31, 1, 5,'집중력 부족', 5, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    32, 1, 5,'주의산만', 6, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    33, 1, 6,'흡연 / 음주', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    34, 1, 6,'인터넷 / 게임', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    35, 1, 6,'도박 / 토토 / 경륜 / 경마 / 경정', 3, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    36, 1, 6,'주식', 4, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    37, 1, 7,'비행 / 가출', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    38, 1, 7,'성폭력', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    39, 1, 7,'자해행위', 3, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    40, 1, 7,'자살', 4, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    41, 1, 7,'기타', 5, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    42, 2, 998,'지적 능력이 뛰어난', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    43, 2, 998,'열심히 노력하는 사람', 2, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    44, 2, 998,'학교 성적이 가장 뛰어난 사람', 3, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    45, 2, 998,'순응하기', 4, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    46, 2, 998,'반항적인', 5, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    47, 2, 998,'집안 일 돕기', 6, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    48, 2, 998,'비평적인', 7, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    49, 2, 998,'신중한', 8, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    50, 2, 998,'이기적인', 9, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    51, 2, 998,'민족을 위해 노력하는 사람', 10, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    52, 2, 998,'민감하여 상처받기 쉬운', 11, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    53, 2, 998,'까다로운 기질', 12, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    54, 2, 998,'적극적인', 13, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    55, 2, 998,'가장 친구가 많은', 14, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    56, 2, 998,'가장 응석받이인', 15, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    57, 2, 998,'폭력적인', 16, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    58, 2, 998,'운동을 좋아하는', 17, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    59, 2, 998,'가장 힘센', 18, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    60, 2, 998,'매력적인', 19, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    61, 2, 998,'가장 많이 처벌받는', 20, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    62, 2, 998,'욱하는 성격', 21, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    63, 2, 998,'높은 성취기준', 22, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);


--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    64, 2, 998,'늘 혼자인', 23, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    65, 2, 998,'무기력한', 24, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    66, 2, 998,'물질주의적인', 25, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);

--  사전검사 항목 등록
INSERT INTO `plymind_db`.`tbl_pretesting_item` (
    item_srl, question_srl, kind_srl, item, sort, c_date, u_date
) VALUES (
    67, 3, 999,'직접입력', 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
);
