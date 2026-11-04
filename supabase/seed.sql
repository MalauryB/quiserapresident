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

-- 1. Partis politiques (8 blocs)
INSERT INTO parti (tag, nom, actif, couleur_fond, couleur_texte, couleur_accent, couleur_graphique) VALUES
  ('LFI',  'La France Insoumise',         true, '#CC2443', '#FFFFFF', '#E63946', '#E63946'),
  ('PS',   'PS / Place Publique',        true, '#FF6B9D', '#FFFFFF', '#E0476E', '#FF6B9D'),
  ('REN',  'Renaissance',                true, '#FFD600', '#1a1a1a', '#FFB800', '#FFB800'),
  ('HOR',  'Horizons',                   true, '#E07B39', '#1a1a1a', '#A85A1E', '#E07B39'),
  ('DVD',  'Nouvelle Énergie',           true, '#7B5EA7', '#FFFFFF', '#5E4682', '#7B5EA7'),
  ('LR',   'Les Républicains',       true, '#0066CC', '#FFFFFF', '#004A99', '#0066CC'),
  ('RN',   'Rassemblement National', true, '#1B2A4A', '#EEEDFF', '#002395', '#002395'),
  ('REC',  'Reconquête',             true, '#1a1a2e', '#FFFFFF', '#2D2D5E', '#2D2D5E');

-- 3. Candidats (variantes) — valeurs alignées sur le modèle R v3
INSERT INTO candidat (id, parti_tag, indice_variante, nom, nom_court, initiales, sonde_individuellement, groupe_sondage, attractivite, tendance, ideologie_gauche, ideologie_centre, ideologie_droite, taux_barrage, start_agrege, start_debiaise, start_personnalise, photo_url) VALUES
  -- LFI  (R: Ideo=(1,0,0), delta=0.5, psi=1, v0=0.12)
  ('lfi-0',  'LFI',  0, 'Jean-Luc Mélenchon', 'Mélenchon',   'JLM', true,  NULL,                       1.0,  1.0,  0.92,  0.08,  0.00,  0.35, 17.5, 13, 17.5, NULL),
  -- PS   (R: Ideo=(0.5,0.5,0), delta=0, psi=0.5, v0=0.135)
  ('ps-0',   'PS',   0, 'Raphaël Glucksmann', 'Glucksmann',  'RG',  true,  'Place Publique',            0.5,  0.5,  0.58,  0.38,  0.04,  0.08, 12.6, 14, 12.6, NULL),
  -- REN  (R: Ideo=(0,1,0), delta=-0.5, psi=0, v0=0.17)
  ('ren-0',  'REN',  0, 'Gabriel Attal',      'Attal',       'GA',  true,  'Renaissance',               0.0,  0.0,  0.20,  0.58,  0.22,  0.0,  4.7, 15, 4.7, NULL),
  -- HOR  (Édouard Philippe se présente séparément d'Attal)
  ('hor-0',  'HOR',  0, 'Édouard Philippe',   'Philippe',    'ÉP',  true,  'Horizons',                  0.1,  0.1,  0.10,  0.55,  0.35,  0.0,  14.5, 17, 14.5, NULL),
  -- LR   (R: Ideo=(0,0.3,0.7), delta=0.2, psi=0.5, v0=0.08)
  ('lr-0',   'LR',   0, 'Bruno Retailleau',   'Retailleau',  'BR',  true,  NULL,                        0.5,  0.7,  0.02,  0.22,  0.76,  0.25,  5.6,  9,  5.6, NULL),
  -- DVD  (David Lisnard, Nouvelle Énergie — tag DVD conservé pour les couleurs)
  ('dvd-0',  'DVD',  0, 'David Lisnard',      'Lisnard',     'DL',  true,  'Nouvelle Énergie',          0.4,  0.5,  0.04,  0.36,  0.60,  0.2,   6.7,  6.7, 6.7, NULL),
  -- RN   (R: Ideo=(0,0,1), delta=-0.2, psi=0, v0=0.35)
  ('rn-0',   'RN',   0, 'Marine Le Pen',      'Le Pen',      'MLP', true,  NULL,                        0.1,  0.35, 0.08,  0.10,  0.82,  0.5,  34.5, 33, 34.5, NULL),
  -- REC  (R: Ideo=(0,0,1), delta=0, psi=0, v0=0.055)
  ('rec-0',  'REC',  0, 'Éric Zemmour',       'Zemmour',     'ÉZ',  true,  NULL,                        0.0,  0.5,  0.00,  0.03,  0.97,  0.5,  3.9, 5, 3.9, NULL);

-- 3b. Dynamique (delta du modèle). Colonne distincte de tendance, qui porte
--     une autre grandeur du modèle R et n'est pas modifiée ici.
UPDATE candidat SET dynamique = -0.2 WHERE nom = 'Gabriel Attal';
UPDATE candidat SET dynamique =  0.4 WHERE nom = 'Jean-Luc Mélenchon';
UPDATE candidat SET dynamique =  0.3 WHERE nom = 'Raphaël Glucksmann';
UPDATE candidat SET dynamique =  0.0 WHERE nom = 'Marine Le Pen';
UPDATE candidat SET dynamique =  0.2 WHERE nom = 'David Lisnard';
UPDATE candidat SET dynamique = -0.2 WHERE nom = 'Bruno Retailleau';
UPDATE candidat SET dynamique =  0.0 WHERE nom = 'Édouard Philippe';
UPDATE candidat SET dynamique = -0.1 WHERE nom = 'Éric Zemmour';

-- 4. Sources de sondage
INSERT INTO source_sondage (type, libelle, description, icone) VALUES
  ('agrege',   'Sondage agrégé',   'Moyenne pondérée des derniers sondages publiés par les instituts majeurs.', '📊'),
  ('debiaise', 'Sondage débiaisé', 'Sondages corrigés des biais historiques des instituts (house effects).',    '🎯'),
  ('custom',   'Personnalisable',  'Définissez librement les points de départ de chaque candidat.',             '✏️');
