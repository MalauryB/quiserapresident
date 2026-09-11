-- ============================================
-- SimuPresident - Données initiales (seed)
-- À exécuter dans Supabase APRÈS schema.sql
-- ============================================

-- 0. Compatibilité : s'assure que les colonnes ajoutées par migration existent
--    (bases créées avant l'ajout de nom_court)
ALTER TABLE candidat ADD COLUMN IF NOT EXISTS nom_court VARCHAR;
ALTER TABLE candidat ADD COLUMN IF NOT EXISTS dynamique FLOAT DEFAULT 0;

-- 1. Nettoyage (candidats d'abord à cause de la FK vers parti)
DELETE FROM candidat;
DELETE FROM parti;
DELETE FROM source_sondage;

-- 1. Partis politiques (11 blocs)
INSERT INTO parti (tag, nom, actif, couleur_fond, couleur_texte, couleur_accent, couleur_graphique) VALUES
  ('LFI',  'La France Insoumise',         true, '#CC2443', '#FFFFFF', '#E63946', '#E63946'),
  ('PCF',  'Parti Communiste Français',   true, '#DD0000', '#FFFFFF', '#BB0000', '#DD0000'),
  ('EELV', 'Les Écologistes',             true, '#00A86B', '#FFFFFF', '#008C57', '#00A86B'),
  ('PS',   'PS / Place Publique',        true, '#FF6B9D', '#FFFFFF', '#E0476E', '#FF6B9D'),
  ('REN',  'Renaissance',                true, '#FFD600', '#1a1a1a', '#FFB800', '#FFB800'),
  ('HOR',  'Horizons',                   true, '#E07B39', '#1a1a1a', '#A85A1E', '#E07B39'),
  ('DVD',  'Divers droite',              true, '#7B5EA7', '#FFFFFF', '#5E4682', '#7B5EA7'),
  ('LR',   'Les Républicains',       true, '#0066CC', '#FFFFFF', '#004A99', '#0066CC'),
  ('DLF',  'Debout la France',           true, '#3F6B8A', '#FFFFFF', '#2E5068', '#3F6B8A'),
  ('RN',   'Rassemblement National', true, '#1B2A4A', '#EEEDFF', '#002395', '#002395'),
  ('REC',  'Reconquête',             true, '#1a1a2e', '#FFFFFF', '#2D2D5E', '#2D2D5E');

-- 3. Candidats (variantes) — valeurs alignées sur le modèle R v3
INSERT INTO candidat (id, parti_tag, indice_variante, nom, nom_court, initiales, sonde_individuellement, groupe_sondage, attractivite, tendance, ideologie_gauche, ideologie_centre, ideologie_droite, taux_barrage, start_agrege, start_debiaise, start_personnalise, photo_url) VALUES
  -- LFI  (R: Ideo=(1,0,0), delta=0.5, psi=1, v0=0.12)
  ('lfi-0',  'LFI',  0, 'Jean-Luc Mélenchon', 'Mélenchon',   'JLM', true,  NULL,                       1.0,  1.0,  0.92,  0.08,  0.00,  0.35, 14.8, 13, 14.8, NULL),
  -- PCF  (absent des seeds antérieurs : le bloc ne vivait que dans constants.ts)
  ('pcf-0',  'PCF',  0, 'Fabien Roussel',     'Roussel',     'FRo', false, NULL,                 0.2,  0.3,  0.82,  0.10,  0.08,  0.15,  1.8,  2,  1.8, NULL),
  -- EELV (R: Ideo=(0.8,0.2,0), delta=0, psi=0, v0=0.09)
  ('eelv-0', 'EELV', 0, 'Marine Tondelier',   'Tondelier',   'MT',  false, 'Les Écologistes',           0.0,  0.5,  0.78,  0.20,  0.02,  0.1,   2.7,  9,  2.7, NULL),
  -- PS   (R: Ideo=(0.5,0.5,0), delta=0, psi=0.5, v0=0.135)
  ('ps-0',   'PS',   0, 'Raphaël Glucksmann', 'Glucksmann',  'RG',  true,  'Place Publique',            0.5,  0.5,  0.58,  0.38,  0.04,  0.08, 9.7, 14, 9.7, NULL),
  -- REN  (R: Ideo=(0,1,0), delta=-0.5, psi=0, v0=0.17)
  ('ren-0',  'REN',  0, 'Gabriel Attal',      'Attal',       'GA',  true,  'Renaissance',               0.0,  0.0,  0.20,  0.58,  0.22,  0.0,  10, 15, 10, NULL),
  -- HOR  (Édouard Philippe se présente séparément d'Attal)
  ('hor-0',  'HOR',  0, 'Édouard Philippe',   'Philippe',    'ÉP',  true,  'Horizons',                  0.1,  0.1,  0.10,  0.55,  0.35,  0.0,  14.6, 17, 14.6, NULL),
  -- LR   (R: Ideo=(0,0.3,0.7), delta=0.2, psi=0.5, v0=0.08)
  ('lr-0',   'LR',   0, 'Bruno Retailleau',   'Retailleau',  'BR',  true,  NULL,                        0.5,  0.7,  0.02,  0.22,  0.76,  0.25,  7,  9,  7, NULL),
  -- DVD  (Villepin, sans parti — gaulliste)
  ('dvd-0',  'DVD',  0, 'Dominique de Villepin', 'Villepin', 'DdV', false, NULL,                 0.4,  0.45, 0.18,  0.50,  0.32,  0.1,   3.2, 3.5, 3.2, NULL),
  -- DLF  (droite=0.75 et non 0.9 : à 0.9 le cosinus avec le RN vaut 1)
  ('dlf-0',  'DLF',  0, 'Nicolas Dupont-Aignan', 'Dupont-Aignan', 'NDA', false, NULL,            0.3,  0.3,  0.03,  0.12,  0.85,  0.3,   2.7,  3,  2.7, NULL),
  -- RN   (R: Ideo=(0,0,1), delta=-0.2, psi=0, v0=0.35)
  ('rn-0',   'RN',   0, 'Marine Le Pen',      'Le Pen',      'MLP', true,  NULL,                        0.1,  0.35, 0.08,  0.10,  0.82,  0.5,  30.8, 33, 30.8, NULL),
  -- REC  (R: Ideo=(0,0,1), delta=0, psi=0, v0=0.055)
  ('rec-0',  'REC',  0, 'Éric Zemmour',       'Zemmour',     'ÉZ',  true,  NULL,                        0.0,  0.5,  0.00,  0.03,  0.97,  0.5,  2.7, 5, 2.7, NULL);

-- 3b. Dynamique (delta du modèle). Colonne distincte de tendance, qui porte
--     une autre grandeur du modèle R et n'est pas modifiée ici.
UPDATE candidat SET dynamique =  0.5 WHERE nom = 'Gabriel Attal';
UPDATE candidat SET dynamique =  0.4 WHERE nom = 'Jean-Luc Mélenchon';
UPDATE candidat SET dynamique =  0.3 WHERE nom = 'Raphaël Glucksmann';
UPDATE candidat SET dynamique =  0.2 WHERE nom = 'Marine Le Pen';
UPDATE candidat SET dynamique =  0.2 WHERE nom = 'Dominique de Villepin';
UPDATE candidat SET dynamique = -0.1 WHERE nom = 'Nicolas Dupont-Aignan';
UPDATE candidat SET dynamique = -0.2 WHERE nom = 'Fabien Roussel';
UPDATE candidat SET dynamique = -0.3 WHERE nom = 'Bruno Retailleau';
UPDATE candidat SET dynamique = -0.3 WHERE nom = 'Édouard Philippe';
UPDATE candidat SET dynamique = -0.3 WHERE nom = 'Éric Zemmour';
UPDATE candidat SET dynamique = -0.4 WHERE nom = 'Marine Tondelier';

-- 4. Sources de sondage
INSERT INTO source_sondage (type, libelle, description, icone) VALUES
  ('agrege',   'Sondage agrégé',   'Moyenne pondérée des derniers sondages publiés par les instituts majeurs.', '📊'),
  ('debiaise', 'Sondage débiaisé', 'Sondages corrigés des biais historiques des instituts (house effects).',    '🎯'),
  ('custom',   'Personnalisable',  'Définissez librement les points de départ de chaque candidat.',             '✏️');
