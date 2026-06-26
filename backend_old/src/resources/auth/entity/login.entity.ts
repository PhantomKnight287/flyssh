import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';

export class UserEntity {
  @ApiProperty()
  username: string;

  @ApiProperty()
  name: string;
}

export class LoginEntity {
  @ApiProperty({
    description: 'JWT token which will be used for all other requests',
  })
  token: string;

  @ApiProperty({})
  @Type(() => UserEntity)
  user: UserEntity;
}
