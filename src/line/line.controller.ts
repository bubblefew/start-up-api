import { Controller, Get, Post, Req, Res, HttpStatus } from '@nestjs/common';
import { LineService } from './providers/line.service';
import { Request, Response } from 'express';
@Controller('line')
export class LineController {
  constructor(private readonly lineService: LineService) {}

  @Get('hello')
  getHello(): string {
    return this.lineService.getHello();
  }

  @Get('accessToken')
  getLineAccessToken(): string {
    return this.lineService.getLineAccessToken();
  }

  @Get('channelSecret')
  getLineChannelSecret(): string {
    return this.lineService.getLineChannelSecret();
  }

  @Post('webhook')
  async handleWebhook(@Req() req: Request, @Res() res: Response): Promise<any> {
    const events = req.body.events;

    // Process each event received from LINE
    for (const event of events) {
      await this.lineService.handleWebhookEvent(event);
    }

    // Send a success response to LINE's server
    return res.status(HttpStatus.OK).json({
      message: 'Webhook received',
    });
  }
}
