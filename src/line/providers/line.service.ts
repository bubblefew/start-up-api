import { Injectable } from '@nestjs/common';

@Injectable()
export class LineService {
  public getHello() {
    return 'FEWFEWF World!';
  }
}
