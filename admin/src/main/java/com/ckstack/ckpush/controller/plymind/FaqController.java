package com.ckstack.ckpush.controller.plymind;

import com.ckstack.ckpush.common.MDV;
import com.ckstack.ckpush.domain.board.DocumentEntity;
import com.ckstack.ckpush.service.accessory.WebUtilService;
import com.ckstack.ckpush.service.app.AppService;
import com.ckstack.ckpush.service.board.DocumentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;
import java.util.Properties;

/**
 * Created by kas0610 on 16. 1. 15.
 */
@Controller
@RequestMapping("/user/faq")
public class FaqController {
    private final static Logger LOG = LoggerFactory.getLogger(FaqController.class);

    @Autowired
    private AppService appService;
    @Autowired
    private DocumentService documentService;
    @Autowired
    private WebUtilService webUtilService;
    @Autowired
    protected Properties confCommon;
    @Autowired
    protected Properties confAdmin;


    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listForm(Model model) {

        String strCategorySrl = confAdmin.getProperty("plymind.faq.category.srl");
        int categorySrl = Integer.valueOf(strCategorySrl);

        // 검색 칼럼과 검색값을 구한다.
        //Map<String, String> searchFilter = webUtilService.getSearchFilter(columnValue, extraValue);
        //searchFilter.put("category_srl", strCategorySrl);

        //List<Map<String, Object>> table = new ArrayList<>();
        //long totalRows, filterRows;

        List<DocumentEntity> documentEntities = documentService.getDocument(MDV.NUSE, MDV.NUSE, categorySrl, null, MDV.NUSE,
                null, MDV.NO, MDV.NUSE, MDV.NUSE, MDV.NUSE, null, null, null, null, MDV.NUSE, MDV.NUSE);
        //List<DocumentEntity> documentEntities = documentService.getDocument(searchFilter, null, sortValue, offset, limit);

        model.addAttribute("faqEntities", documentEntities);

        return "f_service/plymind/faq/faq_list";
    }


}