package com.itzel.api.service;

import com.itzel.api.dto.EstudianteDTO;
import com.itzel.api.model.Estudiante;
import com.itzel.api.repository.EstudianteRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
public class EstudianteService {

    private final EstudianteRepository repo;

    public EstudianteService(EstudianteRepository repo) {
        this.repo = repo;
    }

    public List<EstudianteDTO> listar() {
        return repo.findAll().stream().map(this::aDTO).toList();
    }

    public Optional<EstudianteDTO> buscarPorId(Integer id) {
        return repo.findById(id).map(this::aDTO);
    }

    public List<EstudianteDTO> porCarrera(Integer carreraId) {
        return repo.findByCarreraId(carreraId).stream().map(this::aDTO).toList();
    }

    private EstudianteDTO aDTO(Estudiante e) {
        return new EstudianteDTO(e.getId(), e.getNombre(), e.getApellidos(),
                e.getFechaNacimiento(), e.getTelefono(), e.getCorreo(), e.getCiudad(),
                e.getCarrera().getId(), e.getCarrera().getNombre());
    }
}
