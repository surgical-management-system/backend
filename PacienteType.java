package com.dacs.backend.graphql.type;

import org.springframework.graphql.data.method.annotation.SchemaMapping;
import org.springframework.stereotype.Controller;
import com.dacs.backend.model.entity.*;
import java.time.LocalDateTime;
import java.time.LocalDate;

/**
 * GraphQL ObjectType for Patient.
 * Single representation of Paciente entity with all possible fields and relationships.
 * Clients request only what they need.
 */
@Controller
public class PacienteType {
    
    // This would be generated as GraphQL type based on the schema file
    // schema/paciente.graphqls:
    // 
    // type Paciente {
    //   id: ID!
    //   nombre: String!
    //   apellido: String!
    //   dni: String!
    //   fechaNacimiento: LocalDate!
    //   altura: Float!
    //   peso: Float!
    //   direccion: String!
    //   telefono: String!
    //   active: Boolean!
    //   urgencias: [Urgencia!]!
    //   cirugias: [Cirugia!]!
    //   turnos: [Turno!]!
    //   edad: Int!  # computed field
    //   createdAt: LocalDateTime!
    //   updatedAt: LocalDateTime!
    // }
    
    /**
     * Computed field: Calculate age from birth date
     */
    @SchemaMapping(typeName = "Paciente", field = "edad")
    public int edad(Paciente paciente) {
        LocalDate today = LocalDate.now();
        LocalDate birthDate = paciente.getFecha_nacimiento().toLocalDate();
        return today.getYear() - birthDate.getYear() 
            - (today.isBefore(birthDate.withYear(today.getYear())) ? 1 : 0);
    }
}
