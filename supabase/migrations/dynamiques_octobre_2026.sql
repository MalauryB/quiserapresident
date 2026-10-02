-- ============================================
-- Migration: Dynamiques des candidats — octobre 2026
-- Date: 2026-10-02
-- Description: Réajuste le delta (dynamique) au vu des sondages d'octobre.
--              Les dynamiques contredites par l'évolution sept → oct sont
--              ramenées vers 0 (Attal, Le Pen, Philippe, Villepin, Zemmour,
--              Retailleau). Les dynamiques confirmées ne sont pas renforcées,
--              la hausse étant déjà intégrée aux nouveaux points de départ
--              (scores_octobre_2026.sql).
--
-- Ré-exécutable sans effet de bord.
-- ============================================

BEGIN;

UPDATE candidat SET dynamique =  0.4 WHERE nom = 'Jean-Luc Mélenchon';
UPDATE candidat SET dynamique =  0.3 WHERE nom = 'Raphaël Glucksmann';
UPDATE candidat SET dynamique =  0.0 WHERE nom = 'Marine Le Pen';
UPDATE candidat SET dynamique =  0.0 WHERE nom = 'Édouard Philippe';
UPDATE candidat SET dynamique =  0.0 WHERE nom = 'Dominique de Villepin';
UPDATE candidat SET dynamique = -0.1 WHERE nom = 'Éric Zemmour';
UPDATE candidat SET dynamique = -0.1 WHERE nom = 'Nicolas Dupont-Aignan';
UPDATE candidat SET dynamique = -0.2 WHERE nom = 'Gabriel Attal';
UPDATE candidat SET dynamique = -0.2 WHERE nom = 'Bruno Retailleau';
UPDATE candidat SET dynamique = -0.2 WHERE nom = 'Fabien Roussel';
UPDATE candidat SET dynamique = -0.4 WHERE nom = 'Marine Tondelier';

COMMIT;

-- ============================================
-- Vérification post-migration
-- ============================================
-- SELECT nom, dynamique FROM candidat ORDER BY dynamique DESC;
