-- ============================================
-- Migration: Vecteurs idéologiques — septembre 2026
-- Date: 2026-09-11
-- Description: Nouveaux poids gauche/centre/droite des 11 candidats.
--
-- ATTENTION : ces vecteurs ne somment plus à 1 (de 1,00 pour Mélenchon et
-- Zemmour à 1,55 pour Attal). Le modèle les utilise de deux façons :
--   * la similarité cosinus est normalisée — la magnitude n'a aucun effet ;
--   * rho = gamma_ED × droite + gamma_EG × gauche est une forme linéaire
--     BRUTE — un vecteur de norme plus grande alourdit mécaniquement la
--     pénalité de second tour, indépendamment du positionnement.
-- Attal en fait les frais : rho 4,80 au lieu de 3,10 s'il était normalisé.
-- Voir le commentaire dans src/lib/constants.ts.
--
-- Ré-exécutable sans effet de bord.
-- ============================================

BEGIN;

UPDATE candidat SET ideologie_gauche = 0.95, ideologie_centre = 0.05, ideologie_droite = 0.00 WHERE nom = 'Jean-Luc Mélenchon';
UPDATE candidat SET ideologie_gauche = 0.90, ideologie_centre = 0.10, ideologie_droite = 0.10 WHERE nom = 'Fabien Roussel';
UPDATE candidat SET ideologie_gauche = 0.85, ideologie_centre = 0.20, ideologie_droite = 0.00 WHERE nom = 'Marine Tondelier';
UPDATE candidat SET ideologie_gauche = 0.70, ideologie_centre = 0.45, ideologie_droite = 0.05 WHERE nom = 'Raphaël Glucksmann';
UPDATE candidat SET ideologie_gauche = 0.30, ideologie_centre = 0.85, ideologie_droite = 0.40 WHERE nom = 'Gabriel Attal';
UPDATE candidat SET ideologie_gauche = 0.25, ideologie_centre = 0.60, ideologie_droite = 0.50 WHERE nom = 'Dominique de Villepin';
UPDATE candidat SET ideologie_gauche = 0.15, ideologie_centre = 0.70, ideologie_droite = 0.55 WHERE nom = 'Édouard Philippe';
UPDATE candidat SET ideologie_gauche = 0.00, ideologie_centre = 0.30, ideologie_droite = 0.85 WHERE nom = 'Bruno Retailleau';
UPDATE candidat SET ideologie_gauche = 0.05, ideologie_centre = 0.15, ideologie_droite = 0.85 WHERE nom = 'Nicolas Dupont-Aignan';
UPDATE candidat SET ideologie_gauche = 0.10, ideologie_centre = 0.10, ideologie_droite = 0.90 WHERE nom = 'Marine Le Pen';
UPDATE candidat SET ideologie_gauche = 0.00, ideologie_centre = 0.00, ideologie_droite = 1.00 WHERE nom = 'Éric Zemmour';

COMMIT;

-- ============================================
-- Vérification post-migration
-- ============================================
-- SELECT nom, ideologie_gauche + ideologie_centre + ideologie_droite AS somme
-- FROM candidat ORDER BY somme DESC;
