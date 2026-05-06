package com.dacs.backend.model.entity;

public enum EstadoUrgencia {
    PENDIENTE {
        @Override
        public EstadoUrgencia inicializar() {
            return EN_CURSO;
        }

        @Override
        public EstadoUrgencia finalizar() {
            throw new IllegalStateException("No se puede finalizar una urgencia pendiente");
        }
    },
    PROGRAMADA {
        @Override
        public EstadoUrgencia inicializar() {
            return EN_CURSO;
        }

        @Override
        public EstadoUrgencia finalizar() {
            throw new IllegalStateException("No se puede finalizar una urgencia programada sin inicializar");
        }
    },
    EN_CURSO {
        @Override
        public EstadoUrgencia inicializar() {
            throw new IllegalStateException("La urgencia ya está en curso");
        }

        @Override
        public EstadoUrgencia finalizar() {
            return FINALIZADA;
        }
    },
    FINALIZADA {
        @Override
        public EstadoUrgencia inicializar() {
            throw new IllegalStateException("No se puede inicializar una urgencia finalizada");
        }

        @Override
        public EstadoUrgencia finalizar() {
            throw new IllegalStateException("La urgencia ya está finalizada");
        }
    },
    CANCELADA {
        @Override
        public EstadoUrgencia inicializar() {
            throw new IllegalStateException("No se puede inicializar una urgencia cancelada");
        }

        @Override
        public EstadoUrgencia finalizar() {
            throw new IllegalStateException("No se puede finalizar una urgencia cancelada");
        }
    };

    public EstadoUrgencia cancelar() {
        return CANCELADA;
    }

    public abstract EstadoUrgencia inicializar();

    public abstract EstadoUrgencia finalizar();
}