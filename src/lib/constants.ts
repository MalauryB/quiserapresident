import type { PartyColors, PartyData, PollSource } from "@/types/simulation";

const PHOTO_BASE = "https://gqaymlbxwlvxcvbunuxp.supabase.co/storage/v1/object/public/photos/";

export const PARTY_COLORS: Record<string, PartyColors> = {
  LFI: { bg: "#CC2443", fg: "#FFFFFF", accent: "#E63946", chart: "#E63946" },
  EELV: { bg: "#00A86B", fg: "#FFFFFF", accent: "#008C57", chart: "#00A86B" },
  PS: { bg: "#FF6B9D", fg: "#FFFFFF", accent: "#E0476E", chart: "#FF6B9D" },
  REN: { bg: "#FFD600", fg: "#1a1a1a", accent: "#B38600", chart: "#D4A017" },
  LR: { bg: "#0066CC", fg: "#FFFFFF", accent: "#004A99", chart: "#0066CC" },
  RN: { bg: "#1B2A4A", fg: "#EEEDFF", accent: "#002395", chart: "#002395" },
  REC: { bg: "#1a1a2e", fg: "#FFFFFF", accent: "#2D2D5E", chart: "#2D2D5E" },
  PCF: { bg: "#DD0000", fg: "#FFFFFF", accent: "#BB0000", chart: "#DD0000" },
  HOR: { bg: "#E07B39", fg: "#1a1a1a", accent: "#A85A1E", chart: "#E07B39" },
  DVD: { bg: "#7B5EA7", fg: "#FFFFFF", accent: "#5E4682", chart: "#7B5EA7" },
  DLF: { bg: "#3F6B8A", fg: "#FFFFFF", accent: "#2E5068", chart: "#3F6B8A" },
};

export const DEFAULT_PARTIES: PartyData[] = [
  {
    tag: "LFI", party: "La France Insoumise", active: true, selectedIdx: 0,
    variants: [
      { name: "Jean-Luc Mélenchon", shortName: "Mélenchon", initials: "Mélenchon", polled: true, pollGroup: null, dynamique: 0.4, left: 0.92, center: 0.08, right: 0, startAgrege: 14.8, startCustom: 14.8, photoUrl: `${PHOTO_BASE}jean-luc-melenchon.jpg` },
    ],
  },
  {
    tag: "PCF", party: "Parti Communiste Français", active: true, selectedIdx: 0,
    variants: [
      { name: "Fabien Roussel", shortName: "Roussel", initials: "Roussel", polled: false, pollGroup: null, dynamique: -0.2, left: 0.82, center: 0.1, right: 0.08, startAgrege: 1.8, startCustom: 1.8, photoUrl: `${PHOTO_BASE}fabien-roussel.jpg` },
    ],
  },
  {
    tag: "EELV", party: "Les Écologistes", active: true, selectedIdx: 0,
    variants: [
      { name: "Marine Tondelier", shortName: "Tondelier", initials: "Tondelier", polled: false, pollGroup: "Les Écologistes", dynamique: -0.4, left: 0.78, center: 0.2, right: 0.02, startAgrege: 2.7, startCustom: 2.7, photoUrl: `${PHOTO_BASE}marine-tondelier.jpg` },
    ],
  },
  {
    tag: "PS", party: "PS / Place Publique", active: true, selectedIdx: 0,
    variants: [
      { name: "Raphaël Glucksmann", shortName: "Glucksmann", initials: "Glucksmann", polled: true, pollGroup: "Place Publique", dynamique: 0.3, left: 0.58, center: 0.38, right: 0.04, startAgrege: 9.7, startCustom: 9.7, photoUrl: `${PHOTO_BASE}raphael-glucksmann.jpg` },
    ],
  },
  {
    tag: "REN", party: "Renaissance", active: true, selectedIdx: 0,
    variants: [
      { name: "Gabriel Attal", shortName: "Attal", initials: "Attal", polled: true, pollGroup: "Renaissance", dynamique: 0.5, left: 0.2, center: 0.58, right: 0.22, startAgrege: 10, startCustom: 10, photoUrl: `${PHOTO_BASE}gabriel-attal.jpg` },
    ],
  },
  {
    tag: "HOR", party: "Horizons", active: true, selectedIdx: 0,
    variants: [
      { name: "Édouard Philippe", shortName: "Philippe", initials: "Philippe", polled: true, pollGroup: "Horizons", dynamique: -0.3, left: 0.1, center: 0.55, right: 0.35, startAgrege: 14.6, startCustom: 14.6, photoUrl: `${PHOTO_BASE}edouard-philippe.jpg` },
    ],
  },
  {
    tag: "DVD", party: "Divers droite", active: true, selectedIdx: 0,
    variants: [
      { name: "Dominique de Villepin", shortName: "Villepin", initials: "Villepin", polled: false, pollGroup: null, dynamique: 0.2, left: 0.18, center: 0.5, right: 0.32, startAgrege: 3.2, startCustom: 3.2, photoUrl: `${PHOTO_BASE}dominique-de-villepin.jpg` },
    ],
  },
  {
    tag: "LR", party: "Les Républicains", active: true, selectedIdx: 0,
    variants: [
      { name: "Bruno Retailleau", shortName: "Retailleau", initials: "Retailleau", polled: true, pollGroup: null, dynamique: -0.3, left: 0.02, center: 0.22, right: 0.76, startAgrege: 7, startCustom: 7, photoUrl: `${PHOTO_BASE}bruno-retailleau.jpg` },
    ],
  },
  {
    // center/right à 0.25/0.75 et non 0.1/0.9 : avec les valeurs du RN le cosinus
    // vaut exactement 1, le modèle traiterait les deux comme interchangeables.
    tag: "DLF", party: "Debout la France", active: true, selectedIdx: 0,
    variants: [
      { name: "Nicolas Dupont-Aignan", shortName: "Dupont-Aignan", initials: "Dupont-Aignan", polled: false, pollGroup: null, dynamique: -0.1, left: 0.03, center: 0.12, right: 0.85, startAgrege: 2.7, startCustom: 2.7, photoUrl: `${PHOTO_BASE}nicolas-dupont-aignan.jpg` },
    ],
  },
  {
    tag: "RN", party: "Rassemblement National", active: true, selectedIdx: 0,
    variants: [
      { name: "Marine Le Pen", shortName: "Le Pen", initials: "Le Pen", polled: true, pollGroup: null, dynamique: 0.2, left: 0.08, center: 0.1, right: 0.82, startAgrege: 30.8, startCustom: 30.8, photoUrl: `${PHOTO_BASE}marine-le-pen.jpg` },
    ],
  },
  {
    tag: "REC", party: "Reconquête", active: true, selectedIdx: 0,
    variants: [
      { name: "Éric Zemmour", shortName: "Zemmour", initials: "Zemmour", polled: true, pollGroup: null, dynamique: -0.3, left: 0, center: 0.03, right: 0.97, startAgrege: 2.7, startCustom: 2.7, photoUrl: `${PHOTO_BASE}eric-zemmour.jpg` },
    ],
  },
];

export const POLL_SOURCES: PollSource[] = [
  { id: "custom", label: "Points de départ", desc: "Les valeurs par défaut sont basées sur les derniers sondages.", icon: "📊" },
];

export const WIZARD_STEPS = ["Candidats", "Paramètres", "Point de départ", "Barrage"];

export const ALLIANCE_PRESETS = [
  { id: "all", label: "Tous séparés", desc: "Chaque parti présente son candidat", inactive: [] as string[] },
  { id: "union-gauche", label: "Union de la gauche", desc: "EELV se retire au profit de LFI", inactive: ["EELV"] },
  { id: "centre-gauche", label: "Union centre-gauche", desc: "PS se retire au profit de Renaissance", inactive: ["PS"] },
  { id: "union-droites", label: "Union des droites", desc: "Reconquête se retire au profit du RN", inactive: ["REC"] },
];

export const DEFAULT_COLORS: PartyColors = { bg: "#556C96", fg: "#FFFFFF", accent: "#556C96", chart: "#556C96" };

export const ELECTION_DATE = new Date(2027, 3, 10); // 10 avril 2027


// Nombre de tirages Monte-Carlo. Source unique : simulation.ts l'importe pour
// DEFAULT_CONFIG.S, les pages d'affichage l'importent pour le texte « N simulations ».
// À 500, le bruit d'échantillonnage atteignait 7 points sur P(victoire) ; à 1500
// il retombe à 2,7. Au-delà le gain devient marginal (2,3 à S=3000) pour un coût double.
export const SIM_COUNT = 1500;

// Intensité du barrage au second tour, par extrême : rho = ED × droite + EG × gauche.
// Ce sont les valeurs de référence du modèle R d'origine (Model.R, parms$sec_t),
// où l'extrême droite est nettement plus rejetée que la gauche radicale.
//
// Source unique : simulation.ts les prend comme défaut de DEFAULT_CONFIG, et
// simulation-context.tsx comme état initial des curseurs de l'étape « Barrage »
// (bornes 0–10, pas de 0,1) — ce ne sont donc que des points de départ, le
// visiteur reste libre de les régler.
//
// Elles étaient auparavant dupliquées entre ces deux fichiers et avaient divergé :
// 4.909898 côté modèle, 4.909881 côté contexte. C'est cette dernière qui
// l'emportait en pratique, le contexte passant toujours ses valeurs à
// generateSimData — soit une erreur de transcription de la référence R.
export const GAMMA_REJET_ED = 4.909898;
export const GAMMA_REJET_EG = 2.240084;
