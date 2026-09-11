import withSerwistInit from "@serwist/next";

const withSerwist = withSerwistInit({
  swSrc: "src/app/sw.ts",
  swDest: "public/sw.js",
  additionalPrecacheEntries: [{ url: "/~offline", revision: crypto.randomUUID() }],
  disable: process.env.NODE_ENV === "development",
});

export default withSerwist({
  images: {
    // L'optimisation Vercel renvoyait 402 (OPTIMIZED_IMAGE_REQUEST_PAYMENT_REQUIRED) :
    // le quota du plan est épuisé. Les photos déjà en cache continuaient de s'afficher,
    // mais toute source neuve échouait — d'où les portraits manquants de Villepin et
    // Dupont-Aignan. Les fichiers sont donc servis directement depuis Supabase.
    // Contrepartie : ils sont livrés à leur taille d'origine (90 à 330 Ko pour un rendu
    // de 260 px). Les redimensionner en amont (~500 px de large) rendrait ce réglage
    // indolore.
    unoptimized: true,
    remotePatterns: [
      {
        protocol: "https",
        hostname: "gqaymlbxwlvxcvbunuxp.supabase.co",
        pathname: "/storage/v1/object/public/photos/**",
      },
    ],
  },
  async headers() {
    return [
      {
        source: "/(.*)",
        headers: [
          { key: "X-Frame-Options", value: "DENY" },
          { key: "X-Content-Type-Options", value: "nosniff" },
          { key: "Referrer-Policy", value: "strict-origin-when-cross-origin" },
          { key: "Permissions-Policy", value: "camera=(), microphone=(), geolocation=()" },
          { key: "Strict-Transport-Security", value: "max-age=63072000; includeSubDomains; preload" },
          { key: "X-XSS-Protection", value: "1; mode=block" },
          {
            key: "Content-Security-Policy",
            value: [
              "default-src 'self'",
              "script-src 'self' 'unsafe-inline' 'unsafe-eval'",
              "style-src 'self' 'unsafe-inline'",
              "img-src 'self' https://gqaymlbxwlvxcvbunuxp.supabase.co data: blob:",
              "font-src 'self'",
              "connect-src 'self' https://gqaymlbxwlvxcvbunuxp.supabase.co",
              "frame-ancestors 'none'",
              "base-uri 'self'",
              "form-action 'self'",
            ].join("; "),
          },
        ],
      },
    ];
  },
});
