import { ApiProperty } from '@nestjs/swagger';

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
