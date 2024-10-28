import { ApiProperty, ApiPropertyOptional, OmitType } from '@nestjs/swagger';

class Count {
  @ApiProperty({ description: 'No of hosts using this key' })
  hosts: number;
}

export class PartialKey {
  @ApiProperty({})
  label: string;

  @ApiProperty({})
  id: string;

  @ApiProperty({ type: Count })
  _count: Count;
}

export class KeyEntity extends OmitType(PartialKey, ['_count']) {
  @ApiProperty({ type: String })
  value: string;

  @ApiPropertyOptional()
  passphrase?: string;

  @ApiProperty({ type: String })
  iv: string;
}
