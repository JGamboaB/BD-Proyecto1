package com.mw.api.controller;

import com.mw.api.model.PaymentAttemps;
import com.mw.api.service.PaymentAttempsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.awt.event.PaintEvent;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.StringJoiner;

@RestController
@RequestMapping("/api")
public class PaymentAttempsController {

    @Autowired
    private PaymentAttempsService paymentAttempsService;

    @GetMapping("/getPayments")
    public ArrayList<PaymentAttemps> obtenerPaymentAttemps(){
        return paymentAttempsService.obtenerPaymentAttemps();
    }

    /*
    @RequestMapping(value="/paymentAttemps/register", method=RequestMethod.POST)
    public List<?> registerPayment(String pClientUserName, String pMerchantName, BigDecimal pAmount,
                                   String pPaymentStatus) {
        String pC;
        String pM;
        BigDecimal pA;
        List<?> l = paymentAttempsService.registerPayment(pClientUserName, pMerchantName, pAmount, pPaymentStatus);
        return l;
    }
*/

}
