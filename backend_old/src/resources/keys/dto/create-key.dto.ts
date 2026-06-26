import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsString } from 'class-validator';

export class CreateKeyDTO {
  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'Label of the key',
  })
  label: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({ description: "Encrypted 'private' key" })
  value: string;

  @IsString()
  @IsOptional()
  @ApiPropertyOptional({ description: 'Passphrase' })
  passphrase?: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({ description: 'IV used to encrypt the key' })
  iv: string;
}
