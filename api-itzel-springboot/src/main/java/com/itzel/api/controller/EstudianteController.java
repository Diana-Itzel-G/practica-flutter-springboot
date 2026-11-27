package com.itzel.api.controller;

import com.itzel.api.dto.EstudianteDTO;
import com.itzel.api.service.EstudianteService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/estudiantes")
public class EstudianteController {

    private final EstudianteService service;

    public EstudianteController(EstudianteService service) {
        this.service = service;
    }

    @GetMapping
    public List<EstudianteDTO> listar() {
        return service.listar();
    }

    @GetMapping("/{id}")
    public ResponseEntity<EstudianteDTO> porId(@PathVariable Integer id) {
        return service.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/carrera/{carreraId}")
    public List<EstudianteDTO> porCarrera(@PathVariable Integer carreraId) {
        return service.porCarrera(carreraId);
    }
}
