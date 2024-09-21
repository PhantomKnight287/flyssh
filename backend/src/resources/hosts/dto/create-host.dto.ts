import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsString, ValidateIf } from 'class-validator';

export class CreateHostDto {
  @ApiProperty({})
  @IsString({
    message: 'Label must be a string',
  })
  @IsNotEmpty({
    message: 'Label must not be empty',
  })
  label: string;

  @ApiProperty({
    description: 'Encrypted hostname',
  })
  @IsString({ message: 'Hostname must be a string' })
  @IsNotEmpty({ message: 'Hostname must not be empty' })
  hostname: string;

  @ApiProperty({
    description: 'Encrypted username',
  })
  @IsString({
    message: 'Username must be a string',
  })
  @IsNotEmpty({ message: 'Username must not be empty' })
  username: string;

  @ApiProperty({
    description: 'Encrypted password',
    nullable: true,
    required: false,
  })
  @IsOptional()
  @IsString({
    message: 'Password must be a string',
  })
  @ValidateIf((o) => !o.keyId)
  password?: string;

  @ApiProperty({
    description: 'Id of key, existing or new',
    required: false,
  })
  @IsOptional()
  @IsString({
    message: 'Id must be a string',
  })
  @ValidateIf((o) => !o.password)
  keyId: string;
}
