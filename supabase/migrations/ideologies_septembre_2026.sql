-- ============================================
-- Migration: Vecteurs idéologiques — septembre 2026
-- Date: 2026-09-11
-- Description: Nouveaux poids gauche/centre/droite des 11 candidats.
--              Profils nettement moins caricaturaux qu'auparavant : plus
--              aucun candidat n'est à 1,0 sur un seul axe.
--
-- Les trois poids somment à 1,00 pour chacun — condition importante, car le
-- modèle les utilise de deux façons : la similarité cosinus est normalisée,
-- mais rho = gamma_ED × droite + gamma_EG × gauche est une forme linéaire
-- brute, et les poids servent aussi de chargements factoriels au premier
-- tour. Une somme ≠ 1 introduirait une pénalité et une volatilité liées à
-- la seule magnitude du vecteur. C'est aussi l'invariant que TriSlider
-- impose dès qu'un visiteur déplace un curseur, et celui du Ideo de
-- référence de Model.R.
--
-- Ré-exécutable sans effet de bord.
-- ============================================

BEGIN;

UPDATE candidat SET ideologie_gauche = 0.92, ideologie_centre = 0.08, ideologie_droite = 0.00 WHERE nom = 'Jean-Luc Mélenchon';
UPDATE candidat SET ideologie_gauche = 0.82, ideologie_centre = 0.10, ideologie_droite = 0.08 WHERE nom = 'Fabien Roussel';
UPDATE candidat SET ideologie_gauche = 0.78, ideologie_centre = 0.20, ideologie_droite = 0.02 WHERE nom = 'Marine Tondelier';
UPDATE candidat SET ideologie_gauche = 0.58, ideologie_centre = 0.38, ideologie_droite = 0.04 WHERE nom = 'Raphaël Glucksmann';
UPDATE candidat SET ideologie_gauche = 0.20, ideologie_centre = 0.58, ideologie_droite = 0.22 WHERE nom = 'Gabriel Attal';
UPDATE candidat SET ideologie_gauche = 0.18, ideologie_centre = 0.50, ideologie_droite = 0.32 WHERE nom = 'Dominique de Villepin';
UPDATE candidat SET ideologie_gauche = 0.10, ideologie_centre = 0.55, ideologie_droite = 0.35 WHERE nom = 'Édouard Philippe';
UPDATE candidat SET ideologie_gauche = 0.02, ideologie_centre = 0.22, ideologie_droite = 0.76 WHERE nom = 'Bruno Retailleau';
UPDATE candidat SET ideologie_gauche = 0.03, ideologie_centre = 0.12, ideologie_droite = 0.85 WHERE nom = 'Nicolas Dupont-Aignan';
UPDATE candidat SET ideologie_gauche = 0.08, ideologie_centre = 0.10, ideologie_droite = 0.82 WHERE nom = 'Marine Le Pen';
UPDATE candidat SET ideologie_gauche = 0.00, ideologie_centre = 0.03, ideologie_droite = 0.97 WHERE nom = 'Éric Zemmour';

COMMIT;

-- ============================================
-- Vérification post-migration
-- ============================================
-- Toutes les sommes doivent valoir 1,00 :
-- SELECT nom, ideologie_gauche + ideologie_centre + ideologie_droite AS somme
-- FROM candidat ORDER BY somme DESC;
