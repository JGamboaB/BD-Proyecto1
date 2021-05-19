package com.mw.api.controller;


import com.mw.api.model.wk_merchants;
import com.mw.api.service.MerchantsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;

@RestController
@RequestMapping("/merchants")
public class MerchantsController {

    @Autowired
    MerchantsService merchantsService;

    @GetMapping()
    public ArrayList<wk_merchants> obtenerMerchants(){
        return merchantsService.obtenerMerchants();
    }

}
