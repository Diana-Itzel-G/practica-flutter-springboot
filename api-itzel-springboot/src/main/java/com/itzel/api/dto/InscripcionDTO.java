package com.itzel.api.dto;

public record InscripcionDTO(Integer id, Integer estudianteId, String estudiante,
                             Integer materiaId, String materia,
                             String periodo, Double calificacion) {}
