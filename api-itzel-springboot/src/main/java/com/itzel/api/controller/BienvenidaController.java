package com.itzel.api.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin(origins = "*")
public class BienvenidaController {

    @GetMapping("/")
    public String bienvenida() {
        return "Bienvenido a la API";
    }
}
