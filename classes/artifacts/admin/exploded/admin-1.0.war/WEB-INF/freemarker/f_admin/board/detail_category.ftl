<#assign _page_id="detail-category">
<#assign _page_parent_name="게시판 관리">
<#assign _page_current_name="카테고리 수정">

<@am.page_simple_depth icon="fa-puzzle-piece" parent="${_page_parent_name}" current="${_page_current_name}"
        canMoveParent=true />

<@am.page_desc title="도움말" id="${_page_id}-helper">
<p>
    등록된 카테고리 정보를 확인하고 수정하는 페이지 입니다. 수정할 항목의 내용을 클릭하고 내용을 변경하면 곧바로 변경 됩니다. 상위 페이지인
    게시판 관리로 이동 하고 싶으면 카테고리 정보 위젯 하단의 게시판 관리 버튼을 클릭 하면 게시판 관리로 이동 됩니다.
</p>
<p>
    카테고리 공개 여부는 게시물의 권한 문제로 인해서 생성된 값에서 다른 값으로 변경이 불가능 합니다.
    또한 카테고리 종류도 게시물 종류의 구분으로 인해서 생성된 값에서 다른 값으로 변경 불가능 합니다.
</p>
</@am.page_desc>

<#-- widget grid -->
<section id="widget-grid" class="">
    <#-- row -->
    <div class="row">
        <#-- NEW WIDGET START -->
        <article class="col-sm-12 col-md-12 col-lg-12">
            <#-- Widget ID (each widget will need unique ID)-->
            <div class="jarviswidget" id="wid-${_page_id}-0" data-widget-colorbutton="false" data-widget-editbutton="false"
                     data-widget-deletebutton="false">
                <@am.widget_title icon="fa-eye">${documentCategoryEntity.category_name}</@am.widget_title>

                <#-- widget div-->
                <div>
                    <#-- widget edit box -->
                    <div class="jarviswidget-editbox"><#-- This area used as dropdown edit box --></div>
                    <#-- end widget edit box -->

                    <#-- widget content -->
                    <div class="widget-body">
                        <table id="user" class="table table-bordered table-striped" style="clear: both">
                            <tbody>
                                <tr>
                                    <td style="width:30%;"><strong>카테고리 시리얼 넘버</strong></td>
                                    <td style="width:70%">${documentCategoryEntity.category_srl}</td>
                                </tr>
                                <tr>
                                    <td><strong>앱</strong></td>
                                    <td>${appEntity.app_name}</td>
                                </tr>
                                <tr>
                                    <td><strong>게시판</strong></td>
                                    <td>
                                        <a id="board_srl" class="my-x-editable-pointer" data-type="select2" data-pk="1" data-select-search="true"
                                           data-value="${documentCategoryEntity.board_srl}" data-trick-value="${documentBoardEntity.board_name}"
                                           data-trick-ready="" data-original-title="카테고리 소유 게시판을 변경 합니까?">
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>카테고리 이름</strong></td>
                                    <td><a id="category_name" class="my-x-editable-pointer" data-type="text" data-pk="1" data-original-title="카테고리 이름을 수정 합니까?" data-placeholder="이름을 입력 하세요">${documentCategoryEntity.category_name}</a></td>
                                </tr>
                                <tr>
                                    <td><strong>카테고리 설명</strong></td>
                                    <td><a id="category_description" class="my-x-editable-pointer" data-type="text" data-pk="1" data-original-title="카테고리 설명을 수정 합니까?" data-placeholder="설명을 입력 하세요">${documentCategoryEntity.category_description}</a></td>
                                </tr>
                                <tr>
                                    <td><strong>카테고리 종류</strong></td>
                                    <td>
                                        <#if documentCategoryEntity.category_type == link_category_type>
                                            링크 카테고리
                                        <#else>
                                            일반 카테고리
                                        </#if>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>활성 여부</strong></td>
                                    <td><a id="enabled" class="my-x-editable-pointer" data-type="select" data-pk="1" data-value="${documentCategoryEntity.enabled}" data-original-title="활성 여부를 변경 합니까?"></a></td>
                                </tr>
                                <tr>
                                    <td><strong>공개 여부</strong></td>
                                    <td>
                                        <#if documentCategoryEntity.open_type == mdv_public>
                                            공개 (접근을 위해 로그인 필요 없음)
                                        <#else>
                                            비공개 (접근을 위해 로그인 필요)
                                        </#if>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>생성일</strong></td>
                                    <td>${(documentCategoryEntity.c_date * 1000)?number_to_date?string("yyyy.MM.dd HH:mm:ss")}</td>
                                </tr>
                                <tr>
                                    <td><strong>수정일</strong></td>
                                    <td>${(documentCategoryEntity.u_date * 1000)?number_to_date?string("yyyy.MM.dd HH:mm:ss")}</td>
                                </tr>
                            </tbody>
                        </table>
                        <form>
                            <div class="form-actions">
                                <div class="btn-group">
                                    <button id="btn-delete" class="btn btn-sm btn-danger" type="button">
                                        <i class="fa fa-trash-o"></i> 카테고리 삭제
                                    </button>
                                </div>
                                <div class="btn-group pull-left">
                                    <button class="btn btn-sm btn-info btn-prev-page" type="button">
                                        <i class="fa fa-chevron-left"></i> 카테고리 관리
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <#-- end widget content -->
                </div>
                <#-- end widget div -->
            </div>
            <#-- end widget -->
        </article>
        <#-- WIDGET END -->
    </div>
    <#-- end row -->
</section>
<#-- end widget grid -->

<#-- SCRIPTS ON PAGE EVENT -->
<script type="text/javascript">
    pageSetUp();

    var pagefunction = function() {
        <#-- session time out 시간을 표시 한다. -->
        my.fn.showSessionTime(${sessionRestSec});

        <#-- 페이지 도움말 영역 visible, invisible 처리 -->
        my.fn.initPageHelper('${_page_id}-helper');

        drawBreadCrumb(['${documentCategoryEntity.category_name?js_string}']);

        <#-- x-editable board_srl -->
        <@am.jsxeditable id="board_srl" uri="${Request.contextPath}/admin/board/category/${documentCategoryEntity.category_srl}/t/"
                type="select2" select2id="board_srl" select2uri="${Request.contextPath}/admin/board/list/app/${documentCategoryEntity.app_srl}/select2/t/"
                minimumInputLength=2 isselect2tag=false select2showkey="board_name">
            function(value) {
                value = parseInt($.trim(value));
                if(value <= 0)   return '게시판 선택은 필수 입니다.';
            }
        </@am.jsxeditable>

        <#-- x-editable category_name -->
        <@am.jsxeditable id="category_name" uri="${Request.contextPath}/admin/board/category/${documentCategoryEntity.category_srl}/t/">
            function(value) {
                value = $.trim(value);
                if(value.length <= 0)               return '카테고리 이름은 필수값 입니다.';
                if(my.fn.byteLength(value) > 64)    return '카테고리 이름은 64byte 이하 입니다.';
            }
        </@am.jsxeditable>

        <#-- x-editable category_description -->
        <@am.jsxeditable id="category_description" uri="${Request.contextPath}/admin/board/category/${documentCategoryEntity.category_srl}/t/">
            function(value) {
                value = $.trim(value);
                if(my.fn.byteLength(value) > 256)    return '카테고리 설명은 256byte 이하 입니다.';
            }
        </@am.jsxeditable>

        <#-- x-editable enabled -->
        <@am.jsxeditable id="enabled" uri="${Request.contextPath}/admin/board/category/${documentCategoryEntity.category_srl}/t/" type="select">
            [{value: ${mdv_yes}, text: '활성'}, {value: ${mdv_no}, text: '비활성'}]
        </@am.jsxeditable>

        <#-- 게시판 관리로 이동 -->
        $('.btn-prev-page').click(function(e){
            <@am.jsevent_prevent />
            my.fn.pmove('#${Request.contextPath}/admin/board/manage');
        });

        <#-- 카테고리 삭제 -->
        $('#btn-delete').click(function(e){
            <@am.jsevent_prevent />

            var $this = $(this);
            var reqData = {l_keys: [${documentCategoryEntity.category_srl}]};
            var successText = '${documentCategoryEntity.category_name?js_string} 을 삭제 했습니다.';
            var process = function() {
                $this.addClass('disabled').html('<span><i class="fa fa-gear fa-spin"></i> 삭제중</span>');
                <@am.jsajax_request submituri="${Request.contextPath}/admin/board/category/t/"
                        method="DELETE" errortitle="카테고리 삭제 실패" ; job >
                <#if job == "success_job">
                    <#-- 삭제 성공시 리스트 페이지로 이동 -->
                    <@am.jsnoti title="카테고리 삭제 완료" content="successText" boxtype="success" />
                    <#-- 헐...이거 click 반응으로 사용자 반응 이후 호출 되는 곳 말고, 자동으로 시나리오 타고 오는 경우
                         my.fn.pmove 를 바로 호출 하니 message box 에 문제 생긴다. 약간의 딜레이를 준다 -->
                    setTimeout(function(){
                        my.fn.pmove('#${Request.contextPath}/admin/board/manage');
                    }, 300);

                <#elseif job == "common_job">
                    $this.removeClass('disabled').html('<i class="fa fa-trash-o"></i> 카테고리 삭제');
                </#if>
                </@am.jsajax_request>
            };

            my.fn.showUserConfirm('카테고리 삭제',
                    "${documentCategoryEntity.category_name?js_string} 을 삭제 합니다.<br/>삭제를 원하면 \'삭제\'를 입력 후 \'네\' 버튼을 클릭 하세요.",
                    '삭제를 입력하세요',
                    '네', '삭제', process, '카테고리 삭제 실패', '삭제를 입력하지 않았습니다.');
        });
    };

    var pagedestroy = function(){
        $('#board_srl').editable('destroy');
        $('#category_name').editable('destroy');
        $('#category_description').editable('destroy');
        $('#enabled').editable('destroy');
    };

    loadScript("${Request.resPath}js/plugin/x-editable/moment.min.js", function() {
        loadScript("${Request.resPath}js/plugin/x-editable/jquery.mockjax.min.js", function() {
            loadScript("${Request.resPath}js/plugin/x-editable/x-editable.min.js", function() {
                loadScript("${Request.resPath}js/plugin/typeahead/typeahead.min.js", function() {
                    loadScript("${Request.resPath}js/plugin/typeahead/typeaheadjs.min.js", function() {
                        loadScript("${Request.resPath}js/plugin/jquery-blockui/jquery.blockUI.js", function () {
                            loadScript("${Request.resPath}js/plugin/datatables/jquery.dataTables.min.js", function () {
                                loadScript("${Request.resPath}js/plugin/datatables/dataTables.colVis.min.js", function () {
                                    loadScript("${Request.resPath}js/plugin/datatables/dataTables.tableTools.min.js", function () {
                                        loadScript("${Request.resPath}js/plugin/datatables/dataTables.bootstrap.min.js", function () {
                                            loadScript("${Request.resPath}js/plugin/datatable-responsive/datatables.responsive.min.js", function () {
                                                loadScript("${Request.resPath}js/ckpush/md5.js", pagefunction);
                                            })
                                        });
                                    });
                                });
                            });
                        });
                    });
                });
            });
        });
    });
</script>