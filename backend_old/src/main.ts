import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

import * as morgan from 'morgan';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { apiReference } from '@scalar/nestjs-api-reference';
import { CustomValidationPipe } from './pipes/validation/validation.pipe';
import { writeFileSync } from 'node:fs';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.use(morgan('dev'));
  app.useGlobalPipes(
    new CustomValidationPipe({
      whitelist: true,
      enableDebugMessages: true,
    }),
  );
  const config = new DocumentBuilder()
    .setTitle('Fly SSH')
    .setDescription('A cross platform SSH client')
    .addBearerAuth(
      {
        type: 'http',
        scheme: 'bearer',
        bearerFormat: 'JWT',
        name: 'JWT',
        description: 'Enter JWT token',
        in: 'header',
        'x-tokenName': 'Token',
      },
      'JWT-auth',
    )
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('docs', app, document);
  writeFileSync('./openapi.spec.json', JSON.stringify(document, undefined, 2));
  app.use(
    '/reference',
    apiReference({
      spec: {
        content: document,
      },
      layout: 'modern',
      isEditable: false,
      metaData: {
        title: 'FlySSH',
        description: 'A cross platform SSH client',
      },
    }),
  );
  await app.listen(3000);
}

bootstrap();
