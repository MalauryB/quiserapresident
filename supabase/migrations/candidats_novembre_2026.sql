-- ============================================
-- Migration: Champ de candidats — sondages de novembre 2026
-- Date: 2026-11-04
-- Description:
--   * Retrait des candidats sous 3 % de moyenne : Marine Tondelier (2,4),
--     Fabien Roussel (1,8), Nicolas Dupont-Aignan (1,8), Dominique de Villepin.
--     Les blocs EELV, PCF et DLF sont désactivés (actif = false) plutôt que
--     supprimés : leurs couleurs restent disponibles en cas de retour.
--   * Entrée de David Lisnard (Nouvelle Énergie) dans le bloc DVD, à la place
--     de Villepin (le tag DVD est conservé pour ne pas toucher aux couleurs).
--   * Points de départ = moyennes normalisées sur les 8 candidats (somme 100,0).
--
-- Ré-exécutable sans effet de bord. Aucune table ne référence candidat(id) :
-- les simulations enregistrées ne sont pas impactées.
-- ============================================

BEGIN;

-- 0. La colonne dynamique manquait en production (ajoutée par seed.sql seulement) :
--    sans elle l'API retombait sur tendance, qui porte une autre grandeur du modèle R.
ALTER TABLE candidat ADD COLUMN IF NOT EXISTS dynamique FLOAT DEFAULT 0;
ALTER TABLE candidat ADD COLUMN IF NOT EXISTS nom_court VARCHAR;

-- 1. Candidats retirés
DELETE FROM candidat
WHERE nom IN ('Marine Tondelier', 'Fabien Roussel', 'Nicolas Dupont-Aignan', 'Dominique de Villepin');

UPDATE parti SET actif = false WHERE tag IN ('EELV', 'PCF', 'DLF');

-- 2. David Lisnard dans le bloc DVD
--    Upsert : le bloc DVD n'existait pas en production (ajout_blocs.sql non joué).
INSERT INTO parti (tag, nom, actif, couleur_fond, couleur_texte, couleur_accent, couleur_graphique)
VALUES ('DVD', 'Nouvelle Énergie', true, '#7B5EA7', '#FFFFFF', '#5E4682', '#7B5EA7')
ON CONFLICT (tag) DO UPDATE SET nom = EXCLUDED.nom, actif = true;

INSERT INTO candidat (id, parti_tag, indice_variante, nom, nom_court, initiales, sonde_individuellement, groupe_sondage, attractivite, tendance, ideologie_gauche, ideologie_centre, ideologie_droite, taux_barrage, start_agrege, start_debiaise, start_personnalise, photo_url, dynamique)
VALUES ('dvd-0', 'DVD', 0, 'David Lisnard', 'Lisnard', 'DL', true, 'Nouvelle Énergie', 0.4, 0.5, 0.04, 0.36, 0.60, 0.2, 6.7, 6.7, 6.7, 'https://gqaymlbxwlvxcvbunuxp.supabase.co/storage/v1/object/public/photos/david-lisnard.jpg', 0.2)
ON CONFLICT (id) DO UPDATE SET
  parti_tag = EXCLUDED.parti_tag, indice_variante = EXCLUDED.indice_variante,
  nom = EXCLUDED.nom, nom_court = EXCLUDED.nom_court, initiales = EXCLUDED.initiales,
  sonde_individuellement = EXCLUDED.sonde_individuellement, groupe_sondage = EXCLUDED.groupe_sondage,
  ideologie_gauche = EXCLUDED.ideologie_gauche, ideologie_centre = EXCLUDED.ideologie_centre,
  ideologie_droite = EXCLUDED.ideologie_droite, taux_barrage = EXCLUDED.taux_barrage,
  start_agrege = EXCLUDED.start_agrege, start_personnalise = EXCLUDED.start_personnalise,
  photo_url = EXCLUDED.photo_url, dynamique = EXCLUDED.dynamique;

-- 3. Points de départ (moyennes normalisées)
UPDATE candidat SET start_agrege = 34.5, start_personnalise = 34.5 WHERE nom = 'Marine Le Pen';
UPDATE candidat SET start_agrege = 17.5, start_personnalise = 17.5 WHERE nom = 'Jean-Luc Mélenchon';
UPDATE candidat SET start_agrege = 14.5, start_personnalise = 14.5 WHERE nom = 'Édouard Philippe';
UPDATE candidat SET start_agrege = 12.6, start_personnalise = 12.6 WHERE nom = 'Raphaël Glucksmann';
UPDATE candidat SET start_agrege =  5.6, start_personnalise =  5.6 WHERE nom = 'Bruno Retailleau';
UPDATE candidat SET start_agrege =  4.7, start_personnalise =  4.7 WHERE nom = 'Gabriel Attal';
UPDATE candidat SET start_agrege =  3.9, start_personnalise =  3.9 WHERE nom = 'Éric Zemmour';

-- 4. Dynamiques (valeurs de dynamiques_octobre_2026.sql, jamais appliquées faute
--    de colonne ; Lisnard est déjà renseigné par l'INSERT ci-dessus)
UPDATE candidat SET dynamique =  0.4 WHERE nom = 'Jean-Luc Mélenchon';
UPDATE candidat SET dynamique =  0.3 WHERE nom = 'Raphaël Glucksmann';
UPDATE candidat SET dynamique =  0.0 WHERE nom = 'Marine Le Pen';
UPDATE candidat SET dynamique =  0.0 WHERE nom = 'Édouard Philippe';
UPDATE candidat SET dynamique = -0.1 WHERE nom = 'Éric Zemmour';
UPDATE candidat SET dynamique = -0.2 WHERE nom = 'Gabriel Attal';
UPDATE candidat SET dynamique = -0.2 WHERE nom = 'Bruno Retailleau';

COMMIT;

-- ============================================
-- Vérification post-migration
-- ============================================
-- 8 lignes attendues, total exactement 100,0
-- SELECT c.nom, c.start_personnalise FROM candidat c
--   JOIN parti p ON p.tag = c.parti_tag
--  WHERE p.actif AND c.indice_variante = 0 ORDER BY c.start_personnalise DESC;
