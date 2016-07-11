-- 게시물 댓글 테이블
ALTER TABLE `plymind_db`.`tbl_document_comment`
        ADD CONSTRAINT `FK_tbl_app_TO_tbl_document_comment` -- 서비스하는 앱 -> 게시물 댓글 테이블
                FOREIGN KEY (
                        `app_srl` -- 앱 시리얼 넘버
                )
                REFERENCES `plymind_db`.`tbl_app` ( -- 서비스하는 앱
                        `app_srl` -- 앱 시리얼 넘버
                )
                ON DELETE CASCADE,
        ADD INDEX `FK_tbl_app_TO_tbl_document_comment` (
                `app_srl` ASC -- 앱 시리얼 넘버
        );

-- 게시물 댓글 테이블
ALTER TABLE `plymind_db`.`tbl_document_comment`
        ADD CONSTRAINT `FK_tbl_document_board_TO_tbl_document_comment` -- 게시판 테이블 -> 게시물 댓글 테이블
                FOREIGN KEY (
                        `board_srl` -- 게시판 시리얼 넘버
                )
                REFERENCES `plymind_db`.`tbl_document_board` ( -- 게시판 테이블
                        `board_srl` -- 게시판 시리얼 넘버
                )
                ON DELETE CASCADE,
        ADD INDEX `FK_tbl_document_board_TO_tbl_document_comment` (
                `board_srl` ASC -- 게시판 시리얼 넘버
        );

-- 게시물 댓글 테이블
ALTER TABLE `plymind_db`.`tbl_document_comment`
        ADD CONSTRAINT `FK_tbl_document_category_TO_tbl_document_comment` -- 게시판 카테고리 테이블 -> 게시물 댓글 테이블
                FOREIGN KEY (
                        `category_srl` -- 카테고리 시리얼 넘버
                )
                REFERENCES `plymind_db`.`tbl_document_category` ( -- 게시판 카테고리 테이블
                        `category_srl` -- 카테고리 시리얼 넘버
                )
                ON DELETE CASCADE,
        ADD INDEX `FK_tbl_document_category_TO_tbl_document_comment` (
                `category_srl` ASC -- 카테고리 시리얼 넘버
        );

-- 게시물 댓글 테이블
ALTER TABLE `plymind_db`.`tbl_document_comment`
        ADD CONSTRAINT `FK_tbl_document_TO_tbl_document_comment` -- 게시물 테이블 -> 게시물 댓글 테이블
                FOREIGN KEY (
                        `document_srl` -- 게시물 시리얼 넘버
                )
                REFERENCES `plymind_db`.`tbl_document` ( -- 게시물 테이블
                        `document_srl` -- 게시물 시리얼 넘버
                )
                ON DELETE CASCADE,
        ADD INDEX `FK_tbl_document_TO_tbl_document_comment` (
                `document_srl` ASC -- 게시물 시리얼 넘버
        );