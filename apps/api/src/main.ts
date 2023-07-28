import { buildApp } from './app/app';
import { environment } from './environments/environment';

(async () => {
  const app = await buildApp();

  await app.ready();

  app.listen(
    { port: environment.port, host: environment.host },
    (err, address) => {
      if (err) {
        app.log.error(err);
        process.exit(0);
      }

      app.log.info(`App running on: ${address}`);

      if (!environment.production) {
        app.log.info(`Swagger for testing at: ${address}/docs`);
      }
    }
  );
})();
