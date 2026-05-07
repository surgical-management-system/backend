-- Make 'prioridad' nullable to match recent code removal
ALTER TABLE urgencia ALTER COLUMN prioridad DROP NOT NULL;
ALTER TABLE IF EXISTS intervencion ALTER COLUMN cirugia_id DROP NOT NULL;
ALTER TABLE IF EXISTS intervencion ALTER COLUMN id_urgencia DROP NOT NULL;

-- Add active flag to paciente for soft-delete (default true)
ALTER TABLE IF EXISTS paciente ADD COLUMN IF NOT EXISTS active boolean DEFAULT true;