-- ============================================
-- Migration: Retrait des suppléants LFI
-- Date: 2026-09-11
-- Description: Jean-Luc Mélenchon ayant annoncé sa candidature à la
--              présidentielle, les variantes de repli LFI (Mathilde Panot,
--              Clémence Guetté, Manuel Bompard) n'ont plus lieu d'être.
--              Suppression ciblée : aucune table ne référence candidat(id),
--              les simulations enregistrées ne sont pas impactées.
-- ============================================

-- Vérification préalable (doit retourner les 3 lignes à supprimer, et elles seules)
-- SELECT id, nom FROM candidat
-- WHERE parti_tag = 'LFI' AND nom IN ('Mathilde Panot', 'Clémence Guetté', 'Manuel Bompard');

DELETE FROM candidat
WHERE parti_tag = 'LFI'
  AND nom IN ('Mathilde Panot', 'Clémence Guetté', 'Manuel Bompard');
