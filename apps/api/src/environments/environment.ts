export const environment = {
  production: false,
  port: 9000,
  host: '0.0.0.0',
  appEnv: process.env['APP_ENV'] ?? 'dev',
  databaseUrl: process.env['DATABASE_URL'],
  saltRounds: +(process.env['SALT_ROUNDS'] ?? 0),
  secret: process.env['SECRET'] ?? '',
};
