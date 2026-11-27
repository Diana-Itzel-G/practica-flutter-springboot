package com.itzel.api.controller;

import com.itzel.api.dto.CarreraDTO;
import com.itzel.api.service.CarreraService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/carreras")
public class CarreraController {

    private final CarreraService service;

    public CarreraController(CarreraService service) {
        this.service = service;
    }

    @GetMapping
    public List<CarreraDTO> listar() {
        return service.listar();
    }

    @GetMapping("/{id}")
    public ResponseEntity<CarreraDTO> porId(@PathVariable Integer id) {
        return service.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<CarreraDTO> crear(@RequestBody CarreraDTO body) {
        return ResponseEntity.status(201).body(service.guardar(body));
    }

    @PutMapping("/{id}")
    public ResponseEntity<CarreraDTO> actualizar(@PathVariable Integer id,
                                                 @RequestBody CarreraDTO body) {
        return service.actualizar(id, body)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        return service.eliminar(id)
                ? ResponseEntity.noContent().build()
                : ResponseEntity.notFound().build();
    }
}
