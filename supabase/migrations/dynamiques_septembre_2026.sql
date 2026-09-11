-- ============================================
-- Migration: Dynamiques des candidats — septembre 2026
-- Date: 2026-09-11
-- Description: Met à jour le delta (dynamique) des 11 candidats.
--
-- La colonne dynamique n'existait pas dans schema.sql : seule tendance était
-- déclarée, annotée « legacy, mapped to dynamique » dans src/types/database.ts.
-- Or les deux ne portent pas la même grandeur — tendance vaut par exemple 1.0
-- pour Mélenchon là où sa dynamique vaut 0.4. L'API lisant
-- « c.dynamique ?? c.tendance », elle retombait silencieusement sur une valeur
-- qui n'était pas la bonne. On crée donc la colonne au lieu d'écraser l'autre.
--
-- Sans effet visible tant que constants.ts fait foi côté front, mais la base
-- cesse de porter une valeur trompeuse.
--
-- Ré-exécutable sans effet de bord.
-- ============================================

ALTER TABLE candidat ADD COLUMN IF NOT EXISTS dynamique FLOAT DEFAULT 0;

BEGIN;

UPDATE candidat SET dynamique =  0.5 WHERE nom = 'Gabriel Attal';
UPDATE candidat SET dynamique =  0.4 WHERE nom = 'Jean-Luc Mélenchon';
UPDATE candidat SET dynamique =  0.3 WHERE nom = 'Raphaël Glucksmann';
UPDATE candidat SET dynamique =  0.2 WHERE nom = 'Marine Le Pen';
UPDATE candidat SET dynamique =  0.2 WHERE nom = 'Dominique de Villepin';
UPDATE candidat SET dynamique = -0.1 WHERE nom = 'Nicolas Dupont-Aignan';
UPDATE candidat SET dynamique = -0.2 WHERE nom = 'Fabien Roussel';
UPDATE candidat SET dynamique = -0.3 WHERE nom = 'Bruno Retailleau';
UPDATE candidat SET dynamique = -0.3 WHERE nom = 'Édouard Philippe';
UPDATE candidat SET dynamique = -0.3 WHERE nom = 'Éric Zemmour';
UPDATE candidat SET dynamique = -0.4 WHERE nom = 'Marine Tondelier';

COMMIT;

-- ============================================
-- Vérification post-migration
-- ============================================
-- SELECT nom, dynamique, tendance FROM candidat ORDER BY dynamique DESC;
