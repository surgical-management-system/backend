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

    @Autowired
    private PersonalRepository personalRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Override
    @Transactional
    public PersonalDto.Response create(PersonalDto.Create request) {
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
       Pageable pageable = PageRequest.of(page, size);
       Page<Personal> personalPage;
       
       if (search != null && !search.trim().isEmpty()) {
           personalPage = personalRepository.findByNombreContainingIgnoreCase(search, pageable);
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
}