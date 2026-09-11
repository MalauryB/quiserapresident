-- ============================================
-- Migration: Réorganisation des blocs de gauche
-- Date: 2026-09-11
-- Description:
--   * La « primaire union de la gauche » est dissoute : EELV redevient
--     « Les Écologistes », avec Marine Tondelier seule.
--   * Le bloc PS ne présente plus que Raphaël Glucksmann (son nom
--     « PS / Place Publique » est inchangé).
--   * Retrait de Ruffin, Autain, Vallaud, BadMulch, Hollande et Faure.
--
-- Note : aucune table ne référence candidat(id) — les simulations
-- enregistrées ne sont pas impactées.
--
-- Ré-exécutable sans effet de bord.
-- ============================================

BEGIN;

-- 1. EELV n'est plus le bloc de la primaire d'union
UPDATE parti SET nom = 'Les Écologistes' WHERE tag = 'EELV';

-- 2. Filet de sécurité : une version antérieure de ce script créait un bloc
--    « Divers gauche » pour y placer Hollande. Il n'a plus lieu d'être.
--    Le CASCADE sur parti_tag emporte ses éventuels candidats.
DELETE FROM parti WHERE tag = 'DVG';

-- 3. Candidats retirés de la simulation
DELETE FROM candidat
WHERE nom IN (
  'François Ruffin', 'Clémentine Autain', 'Boris Vallaud', 'BadMulch',
  'François Hollande', 'Olivier Faure', 'Ségolène Royal'
);

-- 4. Tondelier et Glucksmann reprennent l'indice 0 de leur bloc.
--    Purement cosmétique : l'ordre d'affichage vient de constants.ts, pas de
--    la base. Le garde NOT EXISTS évite qu'un candidat non listé ici (Jadot,
--    Rousseau…) occupant déjà l'indice 0 fasse échouer la transaction sur
--    UNIQUE (parti_tag, indice_variante).
UPDATE candidat c SET indice_variante = 0
WHERE c.nom IN ('Marine Tondelier', 'Raphaël Glucksmann')
  AND c.indice_variante <> 0
  AND NOT EXISTS (
    SELECT 1 FROM candidat o
    WHERE o.parti_tag = c.parti_tag AND o.indice_variante = 0 AND o.id <> c.id
  );

COMMIT;

-- ============================================
-- Vérification post-migration
-- ============================================
-- Doit retourner : EELV/Tondelier ; PS/Glucksmann
-- SELECT parti_tag, indice_variante, nom FROM candidat
-- WHERE parti_tag IN ('EELV', 'PS') ORDER BY parti_tag, indice_variante;

-- Reliquats éventuels : anciens candidats EELV/PS non nommés par cette
-- migration. Ils ne sont plus affichés (constants.ts fait foi côté front)
-- — à examiner puis supprimer manuellement si besoin.
-- SELECT parti_tag, indice_variante, nom FROM candidat
-- WHERE parti_tag IN ('EELV', 'PS') AND nom NOT IN ('Marine Tondelier', 'Raphaël Glucksmann');
