import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { LineModule } from './line/line.module';
@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: '.env.dev', // Specify the path to your .env.dev file
      isGlobal: true, // Make the configuration global
    }),
    LineModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
