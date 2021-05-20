package com.mw.api.service;

import com.mw.api.model.Steps;
import com.mw.api.repository.StepsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.*;
import java.util.ArrayList;

@Service
public class StepsService {
    @Autowired
    StepsRepository stepsRepository;

    public ArrayList<Steps> obtenerSteps(){
        return (ArrayList<Steps>) stepsRepository.findAll();
    }

}



