package com.itzel.api.service;

import com.itzel.api.dto.ProfesorDTO;
import com.itzel.api.model.Profesor;
import com.itzel.api.repository.ProfesorRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
public class ProfesorService {

    private final ProfesorRepository repo;

    public ProfesorService(ProfesorRepository repo) {
        this.repo = repo;
    }

    public List<ProfesorDTO> listar() {
        return repo.findAll().stream().map(this::aDTO).toList();
    }

    public Optional<ProfesorDTO> buscarPorId(Integer id) {
        return repo.findById(id).map(this::aDTO);
    }

    private ProfesorDTO aDTO(Profesor p) {
        return new ProfesorDTO(p.getId(), p.getNombre(), p.getApellidos(),
                p.getCorreo(), p.getTelefono(), p.getEspecialidad());
    }
}
