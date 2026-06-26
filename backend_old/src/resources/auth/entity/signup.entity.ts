import { LoginEntity } from './login.entity';
import { ApiProperty } from '@nestjs/swagger';

export class SignupEntity extends LoginEntity {
  @ApiProperty()
  masterkey: string;
}
