-- ============================================
-- Migration: Réorganisation des blocs de droite
-- Date: 2026-09-11
-- Description:
--   * Attal et Édouard Philippe se présentent chacun de leur côté : le bloc
--     « Renaissance / Horizons » est scindé en REN (Attal) et HOR (Philippe).
--   * Laurent Wauquiez a renoncé : il est retiré de la simulation.
--   * Sarah Knafo est retirée : REC ne présente plus que Zemmour.
--   * Jordan Bardella renonce : Marine Le Pen est la candidate du RN.
--
-- Pas de décalage d'indices nécessaire ici : HOR est un bloc neuf, l'indice 0
-- y est donc libre pour Philippe.
--
-- Ce script est ré-exécutable sans effet de bord (INSERT ON CONFLICT, DELETE
-- et UPDATE tous idempotents).
--
-- Note : aucune table ne référence candidat(id) — les simulations
-- enregistrées ne sont pas impactées.
-- ============================================

BEGIN;

-- 1. Bloc Horizons (doit exister avant d'y déplacer Philippe)
INSERT INTO parti (tag, nom, actif, couleur_fond, couleur_texte, couleur_accent, couleur_graphique)
VALUES ('HOR', 'Horizons', true, '#E07B39', '#1a1a1a', '#A85A1E', '#E07B39')
ON CONFLICT (tag) DO UPDATE
  SET nom = EXCLUDED.nom, actif = true;

-- 2. REN ne couvre plus qu'Attal
UPDATE parti SET nom = 'Renaissance' WHERE tag = 'REN';

-- 3. Candidats retirés
DELETE FROM candidat WHERE nom IN ('Laurent Wauquiez', 'Sarah Knafo', 'Jordan Bardella');

-- 4. Édouard Philippe rejoint son propre bloc
UPDATE candidat
SET parti_tag = 'HOR', indice_variante = 0, groupe_sondage = 'Horizons'
WHERE nom = 'Édouard Philippe';

-- 5. Attal, Retailleau, Zemmour et Le Pen reprennent l'indice 0 de leur bloc.
--    Purement cosmétique : l'ordre d'affichage vient de constants.ts, pas de la
--    base. Le garde NOT EXISTS évite qu'un candidat non listé ici (Borne,
--    Bayrou, Bertrand…) occupant déjà l'indice 0 fasse échouer la transaction
--    sur UNIQUE (parti_tag, indice_variante).
UPDATE candidat c SET indice_variante = 0
WHERE c.nom IN ('Gabriel Attal', 'Bruno Retailleau', 'Éric Zemmour', 'Marine Le Pen')
  AND c.indice_variante <> 0
  AND NOT EXISTS (
    SELECT 1 FROM candidat o
    WHERE o.parti_tag = c.parti_tag AND o.indice_variante = 0 AND o.id <> c.id
  );

COMMIT;

-- ============================================
-- Vérification post-migration
-- ============================================
-- Doit retourner : HOR/Philippe ; LR/Retailleau ; REC/Zemmour ; REN/Attal ; RN/Le Pen
-- SELECT parti_tag, indice_variante, nom FROM candidat
-- WHERE parti_tag IN ('REN', 'HOR', 'LR', 'REC', 'RN') ORDER BY parti_tag, indice_variante;
