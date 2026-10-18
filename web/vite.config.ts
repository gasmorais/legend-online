import { defineConfig } from 'vite';
import { fileURLToPath } from 'node:url';

const GAME_SERVER = 'http://127.0.0.1:8787';
const proxied = '^/(config\\.xml|xml/|code_md5\\.dat|res_md5\\.dat|debug/|cdn/|messagebroker|loginselectlist|login2?(\\?|$)|updateplayernovice|visualizeregister|nicknamecheck|flashversionservlet)';

export default defineConfig({
  resolve: { alias: { '@': fileURLToPath(new URL('./src', import.meta.url)) } },
  server: {
    port: 5173,
    host: true,
    fs: { strict: false },
    proxy: {
      [proxied]: { target: GAME_SERVER, changeOrigin: true },
      '/socket': { target: GAME_SERVER, ws: true, changeOrigin: true },
    },
  },
  build: { copyPublicDir: process.env.LG_COPY_PUBLIC !== '0', chunkSizeWarningLimit: 4096 },
  preserveSymlinks: false,
});
