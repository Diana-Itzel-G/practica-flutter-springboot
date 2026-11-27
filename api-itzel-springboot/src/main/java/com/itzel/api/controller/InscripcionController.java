package com.itzel.api.controller;

import com.itzel.api.dto.InscripcionDTO;
import com.itzel.api.service.InscripcionService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/inscripciones")
public class InscripcionController {

    private final InscripcionService service;

    public InscripcionController(InscripcionService service) {
        this.service = service;
    }

    @GetMapping
    public List<InscripcionDTO> listar() {
        return service.listar();
    }

    @GetMapping("/{id}")
    public ResponseEntity<InscripcionDTO> porId(@PathVariable Integer id) {
        return service.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/estudiante/{estudianteId}")
    public List<InscripcionDTO> porEstudiante(@PathVariable Integer estudianteId) {
        return service.porEstudiante(estudianteId);
    }
}
