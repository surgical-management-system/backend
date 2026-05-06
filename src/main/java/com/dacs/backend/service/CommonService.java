package com.dacs.backend.service;

import java.util.List;
import java.util.Optional;

/**
 * Interfaz mínima para servicios genéricos.
 * Aplica el principio de Interface Segregation (ISP): solo métodos esenciales.
 * Implementaciones específicas pueden heredar de esta y agregar métodos adicionales.
 */
public interface CommonService<E> {
	
	Optional<E> getById(Long id);
	
	Boolean existById(Long id);
	
	void delete(Long id);
	
	E save(E entity);

	List<E> getAll();

}
