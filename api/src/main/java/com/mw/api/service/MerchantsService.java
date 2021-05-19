package com.mw.api.service;

import com.mw.api.model.wk_merchants;
import com.mw.api.repository.MerchantRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class MerchantsService {

    @Autowired
    MerchantRepository merchantRepository;

    public ArrayList<wk_merchants> obtenerMerchants(){
        return (ArrayList<wk_merchants>) merchantRepository.findAll();
    }
}
