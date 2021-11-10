import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { Page1Module } from './Page1/page1.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import TablesORM from './enitites/index.enitity';


@Module({
  imports: [Page1Module,
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: 'localhost',
      port: 3306,
      username: 'root',
      password: 'onepeice',
      database: 'persondb',
      entities: TablesORM,
      synchronize: true
    })
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
