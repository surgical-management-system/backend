-- Make 'prioridad' nullable to match recent code removal
ALTER TABLE urgencia ALTER COLUMN prioridad DROP NOT NULL;
ALTER TABLE IF EXISTS intervencion ALTER COLUMN cirugia_id DROP NOT NULL;
ALTER TABLE IF EXISTS intervencion ALTER COLUMN id_urgencia DROP NOT NULL;