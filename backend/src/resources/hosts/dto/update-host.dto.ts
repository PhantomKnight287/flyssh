import { PartialType } from '@nestjs/swagger';
import { CreateHostDto } from './create-host.dto';

export class UpdateHostDto extends PartialType(CreateHostDto) {}
