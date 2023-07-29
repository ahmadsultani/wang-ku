# WangKu

![Preview](/docs/logo.jpeg)

Aplikasi ini adalah aplikasi yang bertujuan untuk membantu dan mempermudah UMKM dalam menjalankan dan mengembangkan usaha yang mereka miliki. Produk ini dibuat agar pelaku usaha bisa mengembangkan usahanya dengan mengajukan pinjaman jika mengalami kesulitan finansial maupun kekurangan modal

## Documentation

- [ERD](https://dbdocs.io/excalios/WangKu?view=relationships)
- [Figma](https://www.figma.com/file/Q214mmmVj7PisjIyodltR0/Kampus-Ayam---WangKu?type=design&node-id=6%3A2124&mode=design&t=2HxYzRBAZ4KxIHSI-1)

## Requirement

### Packages

- [Git](https://git-scm.com/)
- [Nodejs](https://nodejs.org/en)
- [pnpm](https://pnpm.io/)
- [flutter](https://docs.flutter.dev/get-started/install)
- [Docker Compose](https://docs.docker.com/compose/)

## Tech Stack

- [Nx](https://nx.dev/)
- [React](https://react.dev/)
- [Fastify](https://www.fastify.io/)
- [Flutter](https://flutter.dev/)

## Setup Project

1. Git clone the project using `git clone ....`
2. run `pnpm install`
3. run `pnpm set-up api`
   This might not work if you're using windows due to how windows process commands. You will need to setup manually using git bash with:
4. run `docker-compose up`
5. run `./scripts/migrate latest`
6. run `nx serve api` to run the backend API
   You can check the swagger documentation at `http://127.0.0.1:9000/docs`
7. run `nx serve wang-ku` to run the landing page website
8. run `pnpm mobile get mobile` and `pnpm mobile get shared` to `pub get` for flutter packages
9. create a `.env` in `apps/mobile/.env` and fill it with

```.env
API_URL="http://10.0.2.2:9000/api/v1" # if you are using emulator

API_URL="http://{Local IP4}:9000/api/v1" # if you are using physical device replacing {Local IP4} with your device local network ip4 that is running the API
```

8. run `nx run mobile:run` to run the mobile application or you could just vs code flutter extension

## Backend Section

### Create New Library Or Application

Let's say we want to create new library/application for new feature, we can do that with this command:

```sh
# this will create new application in path apps/new-app
pnpm exec nx g @nrwl/node:app new-app

# this will create new library in path libs/api/features/new-lib
pnpm exec nx g @nrwl/node:lib new-lib --directory=api/features
```

### Delete Library

Let's say we just created new library/application, make sure targeted folder is not depended to other lib/app
we can delete those new folder with this command:

```sh
# deleting app
pnpm exec nx g @nrwl/workspace:remove new-app

# when deleting lib, path is included
pnpm exec nx g @nrwl/workspace:remove api-features-new-lib
```

### Handling the Migration

1. Create your database migration file, e.g.:

```sh
# Make sure to use underscore instead of space for table name
pnpm migrate create <name_of_table>

pnpm migrate create user_role
```

2. Migrate latest migrations to your local database

```sh
pnpm migrate latest
```

3. Rollback your local database migrations

```sh
pnpm migrate rollback
```

### Refresh the Database

To refresh the database without terminate the docker container, we can use:

```sh
pnpm migrate refresh
```

## Schemas Section

Everytime we create schema for API, it will be converted to dart model with [quicktype](https://quicktype.io/)

### Creating schema

Generate new lib schema with:

```sh
pnpm exec nx g @nrwl/node:lib schema/new-schema --directory=api/shared
```

after that you can create new shared schema like example `libs/api/shared/schema/user/src/lib/user.schema.ts`, you can generate it automatically with

```sh
pnpm nx build generate-dart-models && node dist/apps/generate-dart-models/main.js
```

and it will generate the dart models to `apps/mobile/lib/src/generated_models`
