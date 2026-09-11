-- ============================================
-- Migration: Nouveaux blocs — PCF, Villepin, Dupont-Aignan
-- Date: 2026-09-11
-- Description:
--   * PCF « Parti Communiste Français » → Fabien Roussel (2,0 %).
--     Ce bloc n'a jamais figuré dans seed.sql : il n'existait que dans
--     constants.ts et ne s'affichait que par le fallback du front. Il peut
--     donc être absent de la base, d'où l'INSERT plutôt qu'un UPDATE.
--   * DVD « Divers droite »    → Dominique de Villepin (3,5 %)
--   * DLF « Debout la France » → Nicolas Dupont-Aignan (3,0 %)
--
-- Sur ideologie_droite de Dupont-Aignan : 0.75 et non 0.9. Avec 0.9 son
-- vecteur idéologique serait identique à celui de Marine Le Pen, soit un
-- cosinus de 1.000 — le modèle les traiterait comme parfaitement
-- interchangeables dans le vote utile et le report de second tour.
--
-- Rappel : taux_barrage n'est pas lu par le modèle (rho se calcule depuis
-- gamma_rejet_ED/EG × vecteur idéologique). La colonne est renseignée pour
-- cohérence, elle n'a aucun effet sur la simulation.
--
-- Ré-exécutable sans effet de bord.
-- ============================================

BEGIN;

INSERT INTO parti (tag, nom, actif, couleur_fond, couleur_texte, couleur_accent, couleur_graphique) VALUES
  ('PCF', 'Parti Communiste Français', true, '#DD0000', '#FFFFFF', '#BB0000', '#DD0000'),
  ('DVD', 'Divers droite',             true, '#7B5EA7', '#FFFFFF', '#5E4682', '#7B5EA7'),
  ('DLF', 'Debout la France',          true, '#3F6B8A', '#FFFFFF', '#2E5068', '#3F6B8A')
ON CONFLICT (tag) DO UPDATE
  SET nom = EXCLUDED.nom, actif = true,
      couleur_fond = EXCLUDED.couleur_fond, couleur_texte = EXCLUDED.couleur_texte,
      couleur_accent = EXCLUDED.couleur_accent, couleur_graphique = EXCLUDED.couleur_graphique;

INSERT INTO candidat (
  id, parti_tag, indice_variante, nom, nom_court, initiales,
  sonde_individuellement, groupe_sondage, attractivite, tendance,
  ideologie_gauche, ideologie_centre, ideologie_droite, taux_barrage,
  start_agrege, start_debiaise, start_personnalise, photo_url
) VALUES
  ('pcf-0', 'PCF', 0, 'Fabien Roussel',         'Roussel',       'FRo', false, NULL, 0.2, 0.3,
   0.8,  0.0,  0.2,  0.15, 1.8, 1.8, 1.8, NULL),
  ('dvd-0', 'DVD', 0, 'Dominique de Villepin',  'Villepin',      'DdV', false, NULL, 0.4, 0.45,
   0.0,  0.7,  0.3,  0.1,  3.2, 3.2, 3.2, NULL),
  ('dlf-0', 'DLF', 0, 'Nicolas Dupont-Aignan',  'Dupont-Aignan', 'NDA', false, NULL, 0.3, 0.3,
   0.0,  0.25, 0.75, 0.3,  2.7, 2.7, 2.7, NULL)
ON CONFLICT (id) DO UPDATE
  SET parti_tag = EXCLUDED.parti_tag, indice_variante = EXCLUDED.indice_variante,
      nom_court = EXCLUDED.nom_court,
      ideologie_gauche = EXCLUDED.ideologie_gauche,
      ideologie_centre = EXCLUDED.ideologie_centre,
      ideologie_droite = EXCLUDED.ideologie_droite,
      start_agrege = EXCLUDED.start_agrege,
      start_personnalise = EXCLUDED.start_personnalise;

COMMIT;

-- ============================================
-- Vérification post-migration
-- ============================================
-- SELECT parti_tag, nom, ideologie_centre, ideologie_droite, start_personnalise
-- FROM candidat WHERE parti_tag IN ('PCF', 'DVD', 'DLF');
