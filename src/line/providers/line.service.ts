import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { firstValueFrom } from 'rxjs';
import { HttpService } from '@nestjs/axios';

@Injectable()
export class LineService {
  private readonly lineApiUrl: string;
  private readonly headers: Record<string, string>;

  // Inject ConfigService and HttpService
  constructor(
    private configService: ConfigService,
    private httpService: HttpService, // Inject HttpService here
  ) {
    // Fetch the access token and set up headers
    const accessToken = this.configService.get<string>(
      'LINE_CHANNEL_ACCESS_TOKEN',
    );

    this.lineApiUrl = 'https://api.line.me/v2/bot/message/reply';
    this.headers = {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${accessToken}`,
    };
  }

  // Simple hello method for testing
  getHello(): string {
    return 'Hello from LINE API!';
  }

  // Example for accessing LINE access token
  getLineAccessToken(): string {
    return (
      this.configService.get<string>('LINE_CHANNEL_ACCESS_TOKEN') ||
      'No access token found'
    );
  }

  // Example for accessing LINE channel secret
  getLineChannelSecret(): string {
    return (
      this.configService.get<string>('LINE_CHANNEL_SECRET') ||
      'No channel secret found'
    );
  }

  // Handle Webhook Event from LINE
  async handleWebhookEvent(event: any): Promise<void> {
    const { replyToken, message } = event;

    if (message && message.type === 'text') {
      // Simple response to a text message
      await this.replyMessage(replyToken, `You said: ${message.text}`);
    }
  }

  // Reply to the user using LINE's reply API
  async replyMessage(replyToken: string, message: string): Promise<void> {
    const body = {
      replyToken,
      messages: [
        {
          type: 'text',
          text: message,
        },
      ],
    };

    // Use this.httpService instead of this.HttpService
    await firstValueFrom(
      this.httpService.post(this.lineApiUrl, body, {
        headers: this.headers,
      }),
    );
  }
}
