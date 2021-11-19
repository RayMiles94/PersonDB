import { NestFactory } from '@nestjs/core';
import { NestExpressApplication } from '@nestjs/platform-express';
import { join } from 'path';
import { AppModule } from './app.module';
import * as hbs from 'hbs';
// let layout = require('handlebars-layouts');
// let handlerbars = require('handlebars');


async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);
  app.setViewEngine('hbs');
  app.useStaticAssets(join(__dirname, '..', 'public'));
  app.setBaseViewsDir(join(__dirname, '..', 'views'));
  //  hbs.registerHelper(layout(handlerbars));
  hbs.registerPartials(join(__dirname, '..', '/views/partials'));
  await app.listen(4500);
}

bootstrap();
