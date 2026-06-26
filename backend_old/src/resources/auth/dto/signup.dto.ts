import { IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class SignupDTO {
  @IsString()
  @ApiProperty()
  username: string;

  @IsString()
  @ApiProperty()
  password: string;

  @IsString()
  @ApiProperty()
  name: string;
}
