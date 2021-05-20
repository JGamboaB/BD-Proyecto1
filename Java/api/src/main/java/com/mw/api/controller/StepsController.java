package com.mw.api.controller;

import com.mw.api.model.Steps;
import com.mw.api.service.StepsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

@RestController
@RequestMapping("/api")
public class StepsController {

    @Autowired
    StepsService stepsService;

    @GetMapping("/getSteps")
    public ArrayList<Steps> obtenerSteps(){
        return stepsService.obtenerSteps();
    }


}
