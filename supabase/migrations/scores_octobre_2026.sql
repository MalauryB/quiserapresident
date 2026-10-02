-- ============================================
-- Migration: Points de départ — estimations d'octobre 2026
-- Date: 2026-10-02
-- Description: Met à jour start_agrege et start_personnalise sur les
--              11 candidats du champ retenu (somme = 100,0). start_debiaise est laissé tel
--              quel (colonne non lue par l'application : POLL_SOURCES ne
--              contient plus que la source « custom »).
--
-- Ré-exécutable sans effet de bord.
-- ============================================

BEGIN;

UPDATE candidat SET start_agrege = 29.6, start_personnalise = 29.6 WHERE nom = 'Marine Le Pen';
UPDATE candidat SET start_agrege = 18.2, start_personnalise = 18.2 WHERE nom = 'Jean-Luc Mélenchon';
UPDATE candidat SET start_agrege = 15.3, start_personnalise = 15.3 WHERE nom = 'Édouard Philippe';
UPDATE candidat SET start_agrege = 11.5, start_personnalise = 11.5 WHERE nom = 'Raphaël Glucksmann';
UPDATE candidat SET start_agrege =  7.2, start_personnalise =  7.2 WHERE nom = 'Bruno Retailleau';
UPDATE candidat SET start_agrege =  4.8, start_personnalise =  4.8 WHERE nom = 'Gabriel Attal';
UPDATE candidat SET start_agrege =  3.3, start_personnalise =  3.3 WHERE nom = 'Éric Zemmour';
UPDATE candidat SET start_agrege =  2.9, start_personnalise =  2.9 WHERE nom = 'Dominique de Villepin';
UPDATE candidat SET start_agrege =  2.9, start_personnalise =  2.9 WHERE nom = 'Nicolas Dupont-Aignan';
UPDATE candidat SET start_agrege =  2.4, start_personnalise =  2.4 WHERE nom = 'Marine Tondelier';
UPDATE candidat SET start_agrege =  1.9, start_personnalise =  1.9 WHERE nom = 'Fabien Roussel';

COMMIT;

-- ============================================
-- Vérification post-migration
-- ============================================
-- Total attendu des 11 candidats actifs : exactement 100,0
-- SELECT c.nom, c.start_personnalise FROM candidat c
--   JOIN parti p ON p.tag = c.parti_tag
--  WHERE p.actif AND c.indice_variante = 0 ORDER BY c.start_personnalise DESC;
