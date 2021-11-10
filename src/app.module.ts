import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { Page1Module } from './Page1/page1.module';

@Module({
  imports: [Page1Module],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
