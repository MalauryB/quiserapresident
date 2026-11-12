-- ============================================
-- Migration: Points de départ — correction mi-novembre 2026
-- Date: 2026-11-12
-- Description: Remplace scores_novembre_2026.sql. Les candidats de gauche sous
--              5 % absents de la liste n'étaient pas redistribués, ce qui
--              surestimait la droite. Leurs voix sont désormais reportées sur
--              les candidats de gauche restants. Total = 100,0.
--
-- Ré-exécutable sans effet de bord.
-- ============================================

BEGIN;

UPDATE candidat SET start_agrege = 35.2, start_personnalise = 35.2 WHERE nom = 'Marine Le Pen';
UPDATE candidat SET start_agrege = 21.2, start_personnalise = 21.2 WHERE nom = 'Jean-Luc Mélenchon';
UPDATE candidat SET start_agrege = 13.9, start_personnalise = 13.9 WHERE nom = 'Raphaël Glucksmann';
UPDATE candidat SET start_agrege =  9.6, start_personnalise =  9.6 WHERE nom = 'Édouard Philippe';
UPDATE candidat SET start_agrege =  6.7, start_personnalise =  6.7 WHERE nom = 'David Lisnard';
UPDATE candidat SET start_agrege =  5.5, start_personnalise =  5.5 WHERE nom = 'Gabriel Attal';
UPDATE candidat SET start_agrege =  4.2, start_personnalise =  4.2 WHERE nom = 'Bruno Retailleau';
UPDATE candidat SET start_agrege =  3.7, start_personnalise =  3.7 WHERE nom = 'Éric Zemmour';

COMMIT;

-- ============================================
-- Vérification post-migration
-- ============================================
-- 8 lignes attendues, total exactement 100,0
-- SELECT c.nom, c.start_personnalise FROM candidat c
--   JOIN parti p ON p.tag = c.parti_tag
--  WHERE p.actif AND c.indice_variante = 0 ORDER BY c.start_personnalise DESC;
