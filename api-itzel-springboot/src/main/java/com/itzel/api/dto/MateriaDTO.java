package com.itzel.api.dto;

public record MateriaDTO(Integer id, String nombre, Integer creditos,
                         Integer semestre, Integer profesorId, String profesor) {}
