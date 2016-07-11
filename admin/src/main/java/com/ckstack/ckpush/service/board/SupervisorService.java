package com.ckstack.ckpush.service.board;

import com.ckstack.ckpush.domain.board.DocumentEntity;

import java.util.Map;

/**
 * Created by kodaji on 2016. 1. 31..
 */
public interface SupervisorService {
    Map<String, Object> getJsonTemplateExtra(DocumentEntity documentEntity);

}
