const config = {
  appId: 'com.scrollslayer.app',
  appName: 'ScrollSlayer',
  webDir: 'dist',
  server: {
    androidScheme: 'https',
  },
};

if (process.env.SCROLLSLAYER_LIVE_RELOAD === '1') {
  config.server = {
    ...config.server,
    cleartext: true,
    url: 'http://localhost:5173',
    allowNavigation: ['localhost', '127.0.0.1'],
  };
}

module.exports = config;
