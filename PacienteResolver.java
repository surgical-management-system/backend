package com.dacs.backend.graphql.resolver;

import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.MutationMapping;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;
import lombok.RequiredArgsConstructor;

import com.dacs.backend.model.entity.Paciente;
import com.dacs.backend.service.PacienteService;
import com.dacs.backend.graphql.input.CreatePacienteInput;
import com.dacs.backend.graphql.input.UpdatePacienteInput;
import com.dacs.backend.graphql.input.TransferPacienteInput;

/**
 * GraphQL Resolver for Paciente.
 * Handles Query and Mutation root types for patient-related operations.
 * 
 * GraphQL Schema reference (queries-paciente.graphqls):
 * 
 * type Query {
 *   paciente(id: ID!): Paciente
 *   pacientes(page: Int = 0, limit: Int = 20): PacientesConnection!
 * }
 * 
 * type Mutation {
 *   createPaciente(input: CreatePacienteInput!): Paciente!
 *   updatePaciente(input: UpdatePacienteInput!): Paciente!
 *   deletePaciente(id: ID!): Boolean!
 *   transferPaciente(input: TransferPacienteInput!): Paciente!
 * }
 */
@Controller
@RequiredArgsConstructor
public class PacienteResolver {
    
    private final PacienteService pacienteService;
    
    // ============ QUERIES ============
    
    /**
     * Query: Get a single patient by ID
     * 
     * Usage:
     * {
     *   paciente(id: "1") {
     *     id
     *     nombre
     *     apellido
     *     dni
     *     fechaNacimiento
     *     urgencias { id estado }
     *   }
     * }
     */
    @QueryMapping
    public Paciente paciente(@Argument Long id) {
        return pacienteService.findById(id);
    }
    
    /**
     * Query: Get paginated list of patients with optional filters
     * 
     * Usage:
     * {
     *   pacientes(page: 0, limit: 20) {
     *     content {
     *       id
     *       nombre
     *       apellido
     *     }
     *     totalElements
     *     totalPages
     *     currentPage
     *     hasNextPage
     *   }
     * }
     */
    @QueryMapping
    public PacientesConnection pacientes(
            @Argument(defaultValue = "0") int page,
            @Argument(defaultValue = "20") int limit) {
        return pacienteService.findPaginated(page, limit);
    }
    
    // ============ MUTATIONS ============
    
    /**
     * Mutation: Create a new patient
     * 
     * Usage:
     * mutation {
     *   createPaciente(input: {
     *     nombre: "Juan"
     *     apellido: "Pérez"
     *     dni: "12345678"
     *     fechaNacimiento: "1985-03-15"
     *     altura: 1.75
     *     peso: 80.5
     *     direccion: "Calle Principal 123"
     *     telefono: "+541234567890"
     *   }) {
     *     id
     *     nombre
     *     apellido
     *   }
     * }
     */
    @MutationMapping
    public Paciente createPaciente(@Argument CreatePacienteInput input) {
        return pacienteService.create(input);
    }
    
    /**
     * Mutation: Update an existing patient
     * ONLY the fields specified in the input are updated.
     * This is a PARTIAL update - fields not included remain unchanged.
     * 
     * Usage:
     * mutation {
     *   updatePaciente(input: {
     *     id: "1"
     *     peso: 82.0
     *     telefono: "+549876543210"
     *   }) {
     *     id
     *     peso
     *     telefono
     *     updatedAt
     *   }
     * }
     */
    @MutationMapping
    public Paciente updatePaciente(@Argument UpdatePacienteInput input) {
        return pacienteService.update(input);
    }
    
    /**
     * Mutation: Delete a patient
     * 
     * Usage:
     * mutation {
     *   deletePaciente(id: "1")
     * }
     */
    @MutationMapping
    public boolean deletePaciente(@Argument Long id) {
        pacienteService.delete(id);
        return true;
    }
    
    /**
     * Mutation: Business-specific action - Transfer patient between services
     * This is a SEMANTIC mutation - it clearly represents a business operation.
     * NOT a generic update, but a specific action with its own input requirements.
     * 
     * Usage:
     * mutation {
     *   transferPaciente(input: {
     *     pacienteId: "1"
     *     nuevoServicioId: "3"
     *     razon: "Mejora clínica, derivación a tratamiento ambulatorio"
     *     notas: "Paciente estable, seguimiento en consulta externa"
     *   }) {
     *     id
     *     nombre
     *     apellido
     *   }
     * }
     * 
     * Benefits:
     * - Clear intent: This is a TRANSFER, not just an update
     * - Required metadata: Reason and notes are explicitly captured
     * - Audit trail: Service can log this semantic action
     * - Type safety: Compiler ensures all required fields are present
     * - Evolution: If transfer logic changes, input is self-documenting
     */
    @MutationMapping
    public Paciente transferPaciente(@Argument TransferPacienteInput input) {
        return pacienteService.transferToService(
            input.getPacienteId(),
            input.getNuevoServicioId(),
            input.getRazon(),
            input.getNotas()
        );
    }
}
