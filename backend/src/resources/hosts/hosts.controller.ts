import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  ParseIntPipe,
  NotFoundException,
} from '@nestjs/common';
import { HostsService } from './hosts.service';
import { CreateHostDto } from './dto/create-host.dto';
import { UpdateHostDto } from './dto/update-host.dto';
import {
  ApiBadRequestResponse,
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiProperty,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';
import { Auth } from '../../decorators/auth/auth.decorator';
import { User } from '@prisma/client';
import { GenericResponseDto } from '../dto/generic-response.dto';
import { GenericErrorEntity } from '../dto/generic-error.dto';
import { Host, PartialHost } from './entities/host.entity';

@Controller('hosts')
@ApiTags('Hosts')
@ApiBearerAuth('JWT-auth')
export class HostsController {
  constructor(private readonly hostsService: HostsService) {}

  @ApiOperation({
    description: 'Create new host',
    summary: 'Create new host',
  })
  @ApiCreatedResponse({ type: GenericResponseDto })
  @ApiBadRequestResponse({ type: GenericErrorEntity })
  @Post()
  create(@Body() createHostDto: CreateHostDto, @Auth() auth: User) {
    return this.hostsService.create(createHostDto, auth.id);
  }

  @ApiOperation({
    summary: 'Get all hosts',
    description: 'Get all hosts(requires pagination)',
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
    type: [PartialHost],
  })
  @Get()
  findAll(
    @Query('page', ParseIntPipe) page: number,
    @Query('limit', ParseIntPipe) limit: number,
  ) {
    return this.hostsService.findAll({ page, limit });
  }

  @ApiOperation({
    description: 'Get all details of a host',
    summary: 'Get details of a host',
  })
  @ApiParam({
    name: 'id',
    description: 'The id of the host',
    required: true,
  })
  @ApiNotFoundResponse({
    type: GenericErrorEntity,
  })
  @ApiOkResponse({
    type: Host,
  })
  @Get(':id')
  findOne(@Param('id') id: string, @Auth() auth: User) {
    return this.hostsService.findOne(id, auth.id);
  }

  @ApiOperation({
    description: 'Update host',
    summary: 'Update host',
  })
  @ApiNotFoundResponse({ type: GenericErrorEntity })
  @ApiOkResponse({ type: GenericResponseDto })
  @ApiParam({ name: 'id', description: 'The id of the host', required: true })
  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateHostDto: UpdateHostDto,
    @Auth() auth: User,
  ) {
    return this.hostsService.update(id, updateHostDto, auth.id);
  }

  @ApiOperation({
    description: 'Delete host',
    summary: 'Delete host',
  })
  @ApiOkResponse({
    type: GenericResponseDto,
  })
  @ApiNotFoundResponse({ type: GenericErrorEntity })
  @ApiParam({ name: 'id', description: 'The id of the host', required: true })
  @Delete(':id')
  remove(@Param('id') id: string, @Auth() auth: User) {
    return this.hostsService.remove(id, auth.id);
  }
}
