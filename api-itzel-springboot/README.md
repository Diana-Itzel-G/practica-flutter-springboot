# API Itzel (Spring Boot + MySQL) - 5 tablas con relaciones

## Pasos
1. En MySQL Workbench ejecuta `database/schema.sql` (crea `practica_con_relacion`, 5 tablas, 15 registros cada una).
2. Copia la carpeta `src` de este zip sobre la carpeta `src` de tu proyecto (reemplaza `application.properties`).
   NO borres tu `ApiApplication.java` (queda en com/itzel/api).
3. En `application.properties` revisa usuario y contraseña de MySQL.
4. Verifica en `pom.xml` las dependencias: spring-boot-starter-data-jpa, spring-boot-starter-webmvc (Spring Web),
   mysql-connector-j y lombok.
5. Ejecuta: `.\mvnw.cmd clean spring-boot:run`

## Endpoints (GET) - http://localhost:8080
/api/carreras, /api/profesores, /api/materias, /api/estudiantes, /api/inscripciones (y /{id} en cada una)
/api/estudiantes/carrera/{carreraId}
/api/inscripciones/estudiante/{estudianteId}
