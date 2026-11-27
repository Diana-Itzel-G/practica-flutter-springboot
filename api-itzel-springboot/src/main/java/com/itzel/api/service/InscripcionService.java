package com.itzel.api.service;

import com.itzel.api.dto.InscripcionDTO;
import com.itzel.api.model.Inscripcion;
import com.itzel.api.repository.InscripcionRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
public class InscripcionService {

    private final InscripcionRepository repo;

    public InscripcionService(InscripcionRepository repo) {
        this.repo = repo;
    }

    public List<InscripcionDTO> listar() {
        return repo.findAll().stream().map(this::aDTO).toList();
    }

    public Optional<InscripcionDTO> buscarPorId(Integer id) {
        return repo.findById(id).map(this::aDTO);
    }

    public List<InscripcionDTO> porEstudiante(Integer estudianteId) {
        return repo.findByEstudianteId(estudianteId).stream().map(this::aDTO).toList();
    }

    private InscripcionDTO aDTO(Inscripcion i) {
        return new InscripcionDTO(i.getId(),
                i.getEstudiante().getId(),
                i.getEstudiante().getNombre() + " " + i.getEstudiante().getApellidos(),
                i.getMateria().getId(),
                i.getMateria().getNombre(),
                i.getPeriodo(), i.getCalificacion());
    }
}
