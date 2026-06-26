import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseIntPipe,
  Patch,
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
import { KeyEntity, PartialKey } from './entities/key.entity';
import { UpdateKeyDTO } from './dto/update-key.dto';

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

  @ApiOperation({
    summary: 'Get a key',
    description: 'Get a key',
  })
  @ApiOkResponse({
    type: KeyEntity,
  })
  @Get(':id')
  findOne(@Param('id') id: string, @Auth() auth: User) {
    return this.keysService.findOne(id, auth.id);
  }

  @ApiOperation({
    summary: 'Delete a key',
    description: 'Delete a key',
  })
  @ApiOkResponse({
    type: GenericResponseDto,
  })
  @Delete(':id')
  delete(@Param('id') id: string, @Auth() auth: User) {
    return this.keysService.delete(id, auth.id);
  }

  @ApiOperation({
    summary: 'Update a key',
    description: 'Update a key',
  })
  @ApiOkResponse({
    type: GenericResponseDto,
  })
  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateKeyDto: UpdateKeyDTO,
    @Auth() auth: User,
  ) {
    return this.keysService.update(id, updateKeyDto, auth.id);
  }
}
