import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './resources/auth/auth.module';
import { ConfigModule } from '@nestjs/config';
import { AuthMiddleware } from './middlewares/auth/auth.middleware';
import { HostsModule } from './resources/hosts/hosts.module';
import { KeysModule } from './resources/keys/keys.module';

@Module({
  imports: [ConfigModule.forRoot({ isGlobal: true }), AuthModule, HostsModule, KeysModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(AuthMiddleware)
      .exclude('/auth/(login|sign-up)')
      .forRoutes('*');
  }
}
