import sitemap from '@astrojs/sitemap';
import react from '@astrojs/react';
import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://krba.vercel.app',
  integrations: [react(), sitemap()]
});
