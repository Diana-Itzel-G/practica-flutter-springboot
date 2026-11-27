package com.itzel.api.service;

import com.itzel.api.dto.CarreraDTO;
import com.itzel.api.model.Carrera;
import com.itzel.api.model.Estudiante;
import com.itzel.api.repository.CarreraRepository;
import com.itzel.api.repository.EstudianteRepository;
import com.itzel.api.repository.InscripcionRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
public class CarreraService {

    private final CarreraRepository repo;
    private final EstudianteRepository estudianteRepo;
    private final InscripcionRepository inscripcionRepo;

    public CarreraService(CarreraRepository repo, EstudianteRepository estudianteRepo,
                          InscripcionRepository inscripcionRepo) {
        this.repo = repo;
        this.estudianteRepo = estudianteRepo;
        this.inscripcionRepo = inscripcionRepo;
    }

    public List<CarreraDTO> listar() {
        return repo.findAll().stream().map(this::aDTO).toList();
    }

    public Optional<CarreraDTO> buscarPorId(Integer id) {
        return repo.findById(id).map(this::aDTO);
    }

    @Transactional
    public CarreraDTO guardar(CarreraDTO dto) {
        Carrera c = new Carrera();
        copiar(dto, c);
        return aDTO(repo.save(c));
    }

    @Transactional
    public Optional<CarreraDTO> actualizar(Integer id, CarreraDTO dto) {
        return repo.findById(id).map(c -> {
            copiar(dto, c);
            return aDTO(repo.save(c));
        });
    }

    @Transactional
    public boolean eliminar(Integer id) {
        if (!repo.existsById(id)) return false;
        // carrera_id es NOT NULL con llave foránea: primero se borran las
        // inscripciones y los estudiantes de la carrera, luego la carrera.
        List<Estudiante> estudiantes = estudianteRepo.findByCarreraId(id);
        for (Estudiante e : estudiantes) {
            inscripcionRepo.deleteAll(inscripcionRepo.findByEstudianteId(e.getId()));
        }
        inscripcionRepo.flush();
        estudianteRepo.deleteAll(estudiantes);
        estudianteRepo.flush();
        repo.deleteById(id);
        return true;
    }

    private void copiar(CarreraDTO dto, Carrera c) {
        c.setNombre(dto.nombre());
        c.setDuracionSemestres(dto.duracionSemestres());
        c.setModalidad(dto.modalidad());
    }

    private CarreraDTO aDTO(Carrera c) {
        return new CarreraDTO(c.getId(), c.getNombre(), c.getDuracionSemestres(),
                c.getModalidad());
    }
}
