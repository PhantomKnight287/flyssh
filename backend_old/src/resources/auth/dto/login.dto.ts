import { IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class LoginDTO {
  @ApiProperty({})
  @IsString()
  username: string;

  @IsString()
  @ApiProperty({})
  password: string;

  @ApiProperty({
    description: 'The masterkey generated during register.',
  })
  @IsString()
  masterkey: string;
}
