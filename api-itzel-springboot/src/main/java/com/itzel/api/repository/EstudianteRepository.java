package com.itzel.api.repository;

import com.itzel.api.model.Estudiante;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EstudianteRepository extends JpaRepository<Estudiante, Integer> {
    List<Estudiante> findByCarreraId(Integer carreraId);
}
