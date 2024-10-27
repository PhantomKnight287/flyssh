import {
  Body,
  Controller,
  Get,
  ParseIntPipe,
  Post,
  Query,
} from '@nestjs/common';
import { KeysService } from './keys.service';
import { CreateKeyDTO } from './dto/create-key.dto';
import { Auth } from 'src/decorators/auth/auth.decorator';
import { User } from '@prisma/client';
import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiOperation,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';
import { GenericResponseDto } from '../dto/generic-response.dto';
import { PartialKey } from './entities/key.entity';

@Controller('keys')
@ApiTags('Keys')
@ApiBearerAuth('JWT-auth')
export class KeysController {
  constructor(private readonly keysService: KeysService) {}

  @ApiOperation({
    description: 'Create a key',
    summary: 'Create a key',
  })
  @ApiCreatedResponse({
    type: GenericResponseDto,
  })
  @Post()
  create(@Body() body: CreateKeyDTO, @Auth() auth: User) {
    return this.keysService.create(body, auth);
  }

  @ApiOperation({
    summary: 'Get all keys',
    description: 'Get all keys(requires pagination)',
  })
  @ApiQuery({
    name: 'page',
    type: Number,
    required: true,
    description: 'The page no for pagination(must start with 1)',
  })
  @ApiQuery({
    name: 'limit',
    type: Number,
    required: true,
    description:
      'No of records to return(must stay constant for a transaction)',
  })
  @ApiOkResponse({
    type: [PartialKey],
  })
  @Get()
  findAll(
    @Query('page', ParseIntPipe) page: number,
    @Query('limit', ParseIntPipe) limit: number,
    @Auth() auth: User,
  ) {
    return this.keysService.findAll({ page, limit, userId: auth.id });
  }
}
