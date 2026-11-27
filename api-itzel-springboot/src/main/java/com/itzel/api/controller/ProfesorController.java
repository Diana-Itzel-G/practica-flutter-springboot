package com.itzel.api.controller;

import com.itzel.api.dto.ProfesorDTO;
import com.itzel.api.service.ProfesorService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/profesores")
public class ProfesorController {

    private final ProfesorService service;

    public ProfesorController(ProfesorService service) {
        this.service = service;
    }

    @GetMapping
    public List<ProfesorDTO> listar() {
        return service.listar();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProfesorDTO> porId(@PathVariable Integer id) {
        return service.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}
