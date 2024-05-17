import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { VitePWA } from "vite-plugin-pwa";

// https://vitejs.dev/config/
export default defineConfig({
  base: "./",
  plugins: [
    react(),
    VitePWA({
      registerType: "autoUpdate",
      workbox: {
        globPatterns: ['**/*.{js,css,html,ico,png,svg,otf}'],
        maximumFileSizeToCacheInBytes: 5000000,
      },
      manifest: {
        name: "Sound Bath",
        short_name: "Sound Bath",
        description: "Sound Bath (2024) by Steven Yi.",
        start_url: "./index.html",
        display: "standalone",
        background_color: "#FED7AA",
        theme_color: "#000000",
        icons: [
          {
            src: "./icons/icon-192x192.png",
            sizes: "192x192",
            type: "image/png",
          },
          {
            src: "./icons/icon-512x512.png",
            sizes: "512x512",
            type: "image/png",
          },
        ],
      },
    }),
  ],
});
