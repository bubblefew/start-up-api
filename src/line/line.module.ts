import { Module } from '@nestjs/common';
import { LineController } from './line.controller';
import { LineService } from './providers/line.service';

@Module({
  controllers: [LineController],
  providers: [LineService]
})
export class LineModule {}
