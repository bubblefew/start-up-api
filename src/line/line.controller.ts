import { Controller, Get } from '@nestjs/common';
import { LineService } from './providers/line.service';

@Controller('line')
export class LineController {
  constructor(private readonly lineService: LineService) {}

  @Get('hello')
  getHello(): string {
    return this.lineService.getHello();
  }
}
