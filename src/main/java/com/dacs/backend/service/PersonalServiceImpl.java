package com.dacs.backend.service;

import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.dacs.backend.dto.PaginacionDto;
import com.dacs.backend.dto.PersonalDto;
import com.dacs.backend.model.entity.Personal;
import com.dacs.backend.model.repository.PersonalRepository;

import jakarta.transaction.Transactional;

@Service
public class PersonalServiceImpl implements PersonalService {

    private static final java.util.regex.Pattern DNI_PATTERN = java.util.regex.Pattern.compile("^\\d{7,10}$");
    private static final java.util.regex.Pattern TELEFONO_PATTERN = java.util.regex.Pattern.compile("^[+]?\\d{8,15}$");

    @Autowired
    private PersonalRepository personalRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    @Transactional
    public PersonalDto.Response create(PersonalDto.Create request) {
        sanitizeCreateRequest(request);
        validateRequiredAndFormatOnCreate(request);
        validateDuplicatesOnCreate(request);
        Personal entity = modelMapper.map(request, Personal.class);
        Personal saved = personalRepository.save(entity);
        return modelMapper.map(saved, PersonalDto.Response.class);
    }

    @Override
    @Transactional
    public PersonalDto.Response update(Long id, PersonalDto.Update request) {
        Personal existingPersonal = personalRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Personal not found with id: " + id));

        sanitizeUpdateRequest(request);
        validateRequiredAndFormatOnUpdate(request);
        validateDuplicatesOnUpdate(id, request);

        modelMapper.map(request, existingPersonal);
        Personal updatedPersonal = personalRepository.save(existingPersonal);
        return modelMapper.map(updatedPersonal, PersonalDto.Response.class);
    }

    @Override
    @Transactional
    public void delete(Long id) {
        Personal existingPersonal = personalRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Personal not found with id: " + id));
        personalRepository.delete(existingPersonal);
    }

   @Override
   public PaginacionDto<PersonalDto.Response> getAll(int page, int size, String search) {
       return getAll(page, size, search, null);
   }

   @Override
   public PaginacionDto<PersonalDto.Response> getAll(int page, int size, String search, String role) {
       Pageable pageable = PageRequest.of(page, size);
       Page<Personal> personalPage;

       String normalizedSearch = search == null ? null : search.trim();
       if (normalizedSearch != null && normalizedSearch.isEmpty()) {
           normalizedSearch = null;
       }

       String normalizedRole = role == null ? null : role.replace('_', ' ').trim().toLowerCase();
       if (normalizedRole != null && normalizedRole.isEmpty()) {
           normalizedRole = null;
       }

       if (normalizedSearch != null && normalizedRole != null) {
           personalPage = personalRepository.findByNombreOrLegajoContainingIgnoreCaseAndNormalizedRol(
                   normalizedSearch,
                   normalizedRole,
                   pageable);
       } else if (normalizedSearch != null) {
           personalPage = personalRepository.findByNombreOrLegajoContainingIgnoreCase(normalizedSearch, pageable);
       } else if (normalizedRole != null) {
           personalPage = personalRepository.findByNormalizedRol(normalizedRole, pageable);
       } else {
           personalPage = personalRepository.findAll(pageable);
       }

       List<PersonalDto.Response> content = personalPage.getContent().stream()
               .map(personal -> modelMapper.map(personal, PersonalDto.Response.class))
               .toList();
       
       PaginacionDto.Response<PersonalDto.Response> response = new PaginacionDto.Response<>();
       response.setContenido(content);
       response.setTotalElementos(personalPage.getTotalElements());
       response.setTotalPaginas(personalPage.getTotalPages());
       response.setPagina(personalPage.getNumber());
       response.setTamaño(personalPage.getSize());
       
       return response;
   }

   @Override
   public boolean existsByLegajo(String legajo) {
       if (legajo == null || legajo.isBlank()) {
           return false;
       }
       return personalRepository.existsByLegajoIgnoreCase(legajo.trim());
   }

    @Override
    public PersonalDto.Response getById(Long id) {
        Personal existingPersonal = personalRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Personal no encontrado con id: " + id));
        return modelMapper.map(existingPersonal, PersonalDto.Response.class);
    }

   private void validateDuplicatesOnCreate(PersonalDto.Create request) {
       if (request == null) {
           throw new IllegalArgumentException("El request de personal no puede ser null");
       }

       String legajo = normalize(request.getLegajo());
       String dni = normalize(request.getDni());
       String telefono = normalize(request.getTelefono());

       if (legajo != null && personalRepository.existsByLegajoIgnoreCase(legajo)) {
           throw new IllegalArgumentException("Ya existe un personal con legajo=" + legajo);
       }
       if (dni != null && personalRepository.existsByDniIgnoreCase(dni)) {
           throw new IllegalArgumentException("Ya existe un personal con dni=" + dni);
       }
       if (telefono != null && personalRepository.existsByTelefonoIgnoreCase(telefono)) {
           throw new IllegalArgumentException("Ya existe un personal con telefono=" + telefono);
       }
   }

   private void validateDuplicatesOnUpdate(Long id, PersonalDto.Update request) {
       if (request == null) {
           throw new IllegalArgumentException("El request de personal no puede ser null");
       }

       String legajo = normalize(request.getLegajo());
       String dni = normalize(request.getDni());
       String telefono = normalize(request.getTelefono());

       if (legajo != null && personalRepository.existsByLegajoIgnoreCaseAndIdNot(legajo, id)) {
           throw new IllegalArgumentException("Ya existe un personal con legajo=" + legajo);
       }
       if (dni != null && personalRepository.existsByDniIgnoreCaseAndIdNot(dni, id)) {
           throw new IllegalArgumentException("Ya existe un personal con dni=" + dni);
       }
       if (telefono != null && personalRepository.existsByTelefonoIgnoreCaseAndIdNot(telefono, id)) {
           throw new IllegalArgumentException("Ya existe un personal con telefono=" + telefono);
       }
   }

   private String normalize(String value) {
       if (value == null) {
           return null;
       }
       String trimmed = value.trim();
       return trimmed.isEmpty() ? null : trimmed;
   }

   private void sanitizeCreateRequest(PersonalDto.Create request) {
       if (request == null) {
           return;
       }
       request.setLegajo(normalize(request.getLegajo()));
       request.setNombre(normalize(request.getNombre()));
       request.setApellido(normalize(request.getApellido()));
       request.setEspecialidad(normalize(request.getEspecialidad()));
       request.setDni(normalize(request.getDni()));
       request.setRol(normalize(request.getRol()));
       request.setEstado(normalize(request.getEstado()));
       request.setTelefono(normalize(request.getTelefono()));
   }

   private void sanitizeUpdateRequest(PersonalDto.Update request) {
       if (request == null) {
           return;
       }
       request.setLegajo(normalize(request.getLegajo()));
       request.setNombre(normalize(request.getNombre()));
       request.setApellido(normalize(request.getApellido()));
       request.setEspecialidad(normalize(request.getEspecialidad()));
       request.setDni(normalize(request.getDni()));
       request.setRol(normalize(request.getRol()));
       request.setEstado(normalize(request.getEstado()));
       request.setTelefono(normalize(request.getTelefono()));
   }

   private void validateRequiredAndFormatOnCreate(PersonalDto.Create request) {
       if (request == null) {
           throw new IllegalArgumentException("El request de personal no puede ser null");
       }

       requireField(request.getLegajo(), "legajo");
       requireField(request.getNombre(), "nombre");
       requireField(request.getApellido(), "apellido");
       requireField(request.getEspecialidad(), "especialidad");
       requireField(request.getDni(), "dni");
       requireField(request.getRol(), "rol");
       requireField(request.getEstado(), "estado");
       requireField(request.getTelefono(), "telefono");

       validateDni(request.getDni());
       validateTelefono(request.getTelefono());
   }

   private void validateRequiredAndFormatOnUpdate(PersonalDto.Update request) {
       if (request == null) {
           throw new IllegalArgumentException("El request de personal no puede ser null");
       }

       requireField(request.getLegajo(), "legajo");
       requireField(request.getNombre(), "nombre");
       requireField(request.getApellido(), "apellido");
       requireField(request.getEspecialidad(), "especialidad");
       requireField(request.getDni(), "dni");
       requireField(request.getRol(), "rol");
       requireField(request.getEstado(), "estado");
       requireField(request.getTelefono(), "telefono");

       validateDni(request.getDni());
       validateTelefono(request.getTelefono());
   }

   private void requireField(String value, String fieldName) {
       if (value == null || value.isBlank()) {
           throw new IllegalArgumentException("El campo " + fieldName + " es obligatorio");
       }
   }

   private void validateDni(String dni) {
       if (!DNI_PATTERN.matcher(dni).matches()) {
           throw new IllegalArgumentException("El dni debe tener solo dígitos (7 a 10 caracteres)");
       }
   }

   private void validateTelefono(String telefono) {
       if (!TELEFONO_PATTERN.matcher(telefono).matches()) {
           throw new IllegalArgumentException("El telefono debe tener solo dígitos, opcional '+' inicial (8 a 15 caracteres)");
       }
   }
}