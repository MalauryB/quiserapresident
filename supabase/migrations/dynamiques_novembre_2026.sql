-- ============================================
-- Migration: Dynamiques des candidats — novembre 2026
-- Date: 2026-11-12
-- Description: Réajuste le delta (dynamique) au vu des sondages de novembre.
--   * Glucksmann  +0.3 → -0.1 : l'effet primaire est retombé (10-13 % contre 12-16 % mi-octobre).
--   * Lisnard     +0.2 → +0.3 : percée confirmée (9 % testé seul, devant Retailleau).
--   * Philippe     0.0 → -0.2 : baisse sensible (9,5 % si Attal se maintient), enquête judiciaire.
--   Inchangés : Mélenchon +0.4, Le Pen 0.0, Zemmour -0.1, Attal -0.2, Retailleau -0.2.
--
-- Ré-exécutable sans effet de bord.
-- ============================================

BEGIN;

UPDATE candidat SET dynamique =  0.4 WHERE nom = 'Jean-Luc Mélenchon';
UPDATE candidat SET dynamique =  0.3 WHERE nom = 'David Lisnard';
UPDATE candidat SET dynamique =  0.0 WHERE nom = 'Marine Le Pen';
UPDATE candidat SET dynamique = -0.1 WHERE nom = 'Raphaël Glucksmann';
UPDATE candidat SET dynamique = -0.1 WHERE nom = 'Éric Zemmour';
UPDATE candidat SET dynamique = -0.2 WHERE nom = 'Édouard Philippe';
UPDATE candidat SET dynamique = -0.2 WHERE nom = 'Gabriel Attal';
UPDATE candidat SET dynamique = -0.2 WHERE nom = 'Bruno Retailleau';

COMMIT;

-- ============================================
-- Vérification post-migration
-- ============================================
-- SELECT nom, dynamique FROM candidat ORDER BY dynamique DESC;
