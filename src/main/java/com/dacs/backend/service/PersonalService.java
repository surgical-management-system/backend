package com.dacs.backend.service;

import com.dacs.backend.dto.PaginacionDto;
import com.dacs.backend.dto.PersonalDto;

public interface PersonalService {
    PersonalDto.Response create(PersonalDto.Create request);

    PersonalDto.Response update(Long id, PersonalDto.Update request);

    void delete(Long id);

    PaginacionDto<PersonalDto.Response> getAll(int page, int size, String search);

    PaginacionDto<PersonalDto.Response> getAll(int page, int size, String search, String role);

    boolean existsByLegajo(String legajo);

    PersonalDto.Response getById(Long id);


}
