package com.itzel.api.dto;

import java.time.LocalDate;

public record EstudianteDTO(Integer id, String nombre, String apellidos,
                            LocalDate fechaNacimiento, String telefono,
                            String correo, String ciudad,
                            Integer carreraId, String carrera) {}
