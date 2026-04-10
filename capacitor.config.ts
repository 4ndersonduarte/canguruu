import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'br.com.canguruu.admin',
  appName: 'Canguruu Admin',
  webDir: 'out',
  server: {
    url: 'https://canguruu.com.br/admin',
    cleartext: false,
    allowNavigation: ['canguruu.com.br', 'www.canguruu.com.br']
  }
};

export default config;
