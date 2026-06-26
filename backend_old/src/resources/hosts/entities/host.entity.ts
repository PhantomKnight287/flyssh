import { ApiProperty, ApiPropertyOptional, OmitType } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsNumber, IsOptional, IsString } from 'class-validator';
import { KeyEntity, PartialKey } from 'src/resources/keys/entities/key.entity';

class PartialKeyWithoutCount extends OmitType(PartialKey, [
  '_count',
  'iv',
  'value',
  'passphrase',
]) {}
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

  @ApiProperty({})
  @IsString()
  hostname: string;

  @ApiPropertyOptional({ type: PartialKeyWithoutCount })
  @Type(() => PartialKeyWithoutCount)
  key?: PartialKeyWithoutCount;

  @ApiProperty()
  @IsString()
  iv: string;

  @ApiProperty({ nullable: true, required: false })
  @IsString()
  @IsOptional()
  password?: string;
}

export class Host extends OmitType(PartialHost, ['key']) {
  @ApiPropertyOptional({ type: KeyEntity })
  key: KeyEntity;
}
