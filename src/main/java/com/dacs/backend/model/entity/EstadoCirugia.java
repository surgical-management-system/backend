package com.dacs.backend.model.entity;

public enum EstadoCirugia {
    PENDIENTE {
        @Override
        public EstadoCirugia inicializar() {
            return EN_CURSO;
        }

        @Override
        public EstadoCirugia finalizar() {
            throw new IllegalStateException("No se puede finalizar una cirugía pendiente");
        }
    },
    PROGRAMADA {
        @Override
        public EstadoCirugia inicializar() {
            return EN_CURSO;
        }

        @Override
        public EstadoCirugia finalizar() {
            throw new IllegalStateException("No se puede finalizar una cirugía programada sin inicializar");
        }
    },
    EN_CURSO {
        @Override
        public EstadoCirugia inicializar() {
            throw new IllegalStateException("La cirugía ya está en curso");
        }

        @Override
        public EstadoCirugia finalizar() {
            return FINALIZADA;
        }
    },
    FINALIZADA {
        @Override
        public EstadoCirugia inicializar() {
            throw new IllegalStateException("No se puede inicializar una cirugía finalizada");
        }

        @Override
        public EstadoCirugia finalizar() {
            throw new IllegalStateException("La cirugía ya está finalizada");
        }
    },
    CANCELADA {
        @Override
        public EstadoCirugia inicializar() {
            throw new IllegalStateException("No se puede inicializar una cirugía cancelada");
        }

        @Override
        public EstadoCirugia finalizar() {
            throw new IllegalStateException("No se puede finalizar una cirugía cancelada");
        }
    };

    public EstadoCirugia cancelar() {
        return CANCELADA;
    }

    public abstract EstadoCirugia inicializar();

    public abstract EstadoCirugia finalizar();
}
