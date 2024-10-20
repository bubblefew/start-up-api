import { Module } from '@nestjs/common';
import { LineController } from './line.controller';
import { LineService } from './providers/line.service';
import { HttpModule } from '@nestjs/axios';
@Module({
  imports: [HttpModule],
  controllers: [LineController],
  providers: [LineService],
})
export class LineModule {}
