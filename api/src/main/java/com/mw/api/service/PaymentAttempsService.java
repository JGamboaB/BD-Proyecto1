package com.mw.api.service;

import com.mw.api.model.PaymentAttemps;
import com.mw.api.repository.PaymentAttempsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.transaction.Transactional;

import java.util.ArrayList;


@Transactional
@Service
public class PaymentAttempsService {
    @Autowired
    PaymentAttempsRepository paymentAttempsRepository;

    public ArrayList<PaymentAttemps> obtenerPaymentAttemps(){
        return (ArrayList<PaymentAttemps>) paymentAttempsRepository.findAll();
    }



    /*
    public boolean register(String pClienUserName, String pMerchantName, BigDecimal pAmount, String pPaymentStatus){

        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("wk_registerPayment");

        query.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(3, BigDecimal.class, ParameterMode.IN);
        query.registerStoredProcedureParameter(4, String.class, ParameterMode.OUT);

        query.setParameter(1, pClienUserName);
        query.setParameter(2, pMerchantName);
        query.setParameter(3, pAmount);

        query.execute();

        String status = (String) query.getOutputParameterValue(4);
        System.out.println(status);

        return true;


    }
*/

}
