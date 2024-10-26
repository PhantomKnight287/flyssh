import { ApiProperty } from '@nestjs/swagger';
import { IsNumber, IsOptional, IsString } from 'class-validator';

export class PartialHost {
  @ApiProperty()
  @IsString()
  id: string;

  @ApiProperty()
  @IsString()
  label: string;

  @ApiProperty()
  @IsString()
  username: string;

  @ApiProperty()
  @IsNumber()
  port: number;
}

export class Host extends PartialHost {
  @ApiProperty({ nullable: true, required: false })
  @IsString()
  @IsOptional()
  password?: string;

  @ApiProperty()
  @IsString()
  iv: string;

  @ApiProperty({})
  @IsString()
  hostname: string;
}
