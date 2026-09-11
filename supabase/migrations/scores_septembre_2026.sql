-- ============================================
-- Migration: Points de départ — estimations de septembre 2026
-- Date: 2026-09-11
-- Description: Met à jour start_agrege et start_personnalise sur les
--              11 candidats du champ retenu (somme = 100,0). start_debiaise est laissé tel
--              quel (colonne non lue par l'application : POLL_SOURCES ne
--              contient plus que la source « custom »).
--
-- Ré-exécutable sans effet de bord.
-- ============================================

BEGIN;

UPDATE candidat SET start_agrege = 30.8, start_personnalise = 30.8 WHERE nom = 'Marine Le Pen';
UPDATE candidat SET start_agrege = 14.8, start_personnalise = 14.8 WHERE nom = 'Jean-Luc Mélenchon';
UPDATE candidat SET start_agrege = 14.6, start_personnalise = 14.6 WHERE nom = 'Édouard Philippe';
UPDATE candidat SET start_agrege = 10.0, start_personnalise = 10.0 WHERE nom = 'Gabriel Attal';
UPDATE candidat SET start_agrege =  9.7, start_personnalise =  9.7 WHERE nom = 'Raphaël Glucksmann';
UPDATE candidat SET start_agrege =  7.0, start_personnalise =  7.0 WHERE nom = 'Bruno Retailleau';
UPDATE candidat SET start_agrege =  2.7, start_personnalise =  2.7 WHERE nom = 'Marine Tondelier';
UPDATE candidat SET start_agrege =  2.7, start_personnalise =  2.7 WHERE nom = 'Éric Zemmour';

-- PCF (bloc créé par ajout_blocs.sql)
UPDATE candidat SET start_agrege =  1.8, start_personnalise =  1.8 WHERE nom = 'Fabien Roussel';


COMMIT;

-- ============================================
-- Vérification post-migration
-- ============================================
-- Total attendu des 11 candidats actifs : exactement 100,0
-- SELECT c.nom, c.start_personnalise FROM candidat c
--   JOIN parti p ON p.tag = c.parti_tag
--  WHERE p.actif AND c.indice_variante = 0 ORDER BY c.start_personnalise DESC;
