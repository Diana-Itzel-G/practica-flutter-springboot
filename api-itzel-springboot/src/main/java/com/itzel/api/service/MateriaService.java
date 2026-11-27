package com.itzel.api.service;

import com.itzel.api.dto.MateriaDTO;
import com.itzel.api.model.Materia;
import com.itzel.api.repository.MateriaRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
public class MateriaService {

    private final MateriaRepository repo;

    public MateriaService(MateriaRepository repo) {
        this.repo = repo;
    }

    public List<MateriaDTO> listar() {
        return repo.findAll().stream().map(this::aDTO).toList();
    }

    public Optional<MateriaDTO> buscarPorId(Integer id) {
        return repo.findById(id).map(this::aDTO);
    }

    private MateriaDTO aDTO(Materia m) {
        return new MateriaDTO(m.getId(), m.getNombre(), m.getCreditos(), m.getSemestre(),
                m.getProfesor().getId(),
                m.getProfesor().getNombre() + " " + m.getProfesor().getApellidos());
    }
}
