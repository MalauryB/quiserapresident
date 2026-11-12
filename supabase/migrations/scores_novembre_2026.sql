-- ============================================
-- Migration: Points de départ — sondages de mi-novembre 2026
-- Date: 2026-11-12
-- Description: Recale start_agrege / start_personnalise sur les dernières vagues
--              (Ifop LCI 3 nov., Odoxa). Total normalisé = 100,0.
--   * Le Pen      34,5 → 36   (35-37 %)
--   * Mélenchon   17,5 → 18   (17,5-18 %)
--   * Philippe    14,5 → 10   (9,5 % quand Attal se maintient, ce qui est le cas du modèle)
--   * Glucksmann  12,6 → 11   (10-13 %)
--   * Lisnard      6,7 → 8,5  (7-9 %, devant Retailleau de 2,5 à 3 points)
--   * Retailleau   5,6 → 6    (~6 %)
--   * Attal        4,7 → 6,5  (probablement sous-estimé ; 8 % dans un scénario complet antérieur)
--   * Zemmour      3,9 → 4    (3-5 %, pas de donnée récente)
--
-- Ré-exécutable sans effet de bord.
-- ============================================

BEGIN;

UPDATE candidat SET start_agrege = 36,  start_personnalise = 36  WHERE nom = 'Marine Le Pen';
UPDATE candidat SET start_agrege = 18,  start_personnalise = 18  WHERE nom = 'Jean-Luc Mélenchon';
UPDATE candidat SET start_agrege = 11,  start_personnalise = 11  WHERE nom = 'Raphaël Glucksmann';
UPDATE candidat SET start_agrege = 10,  start_personnalise = 10  WHERE nom = 'Édouard Philippe';
UPDATE candidat SET start_agrege = 8.5, start_personnalise = 8.5 WHERE nom = 'David Lisnard';
UPDATE candidat SET start_agrege = 6.5, start_personnalise = 6.5 WHERE nom = 'Gabriel Attal';
UPDATE candidat SET start_agrege = 6,   start_personnalise = 6   WHERE nom = 'Bruno Retailleau';
UPDATE candidat SET start_agrege = 4,   start_personnalise = 4   WHERE nom = 'Éric Zemmour';

COMMIT;

-- ============================================
-- Vérification post-migration
-- ============================================
-- 8 lignes attendues, total exactement 100,0
-- SELECT c.nom, c.start_personnalise FROM candidat c
--   JOIN parti p ON p.tag = c.parti_tag
--  WHERE p.actif AND c.indice_variante = 0 ORDER BY c.start_personnalise DESC;
