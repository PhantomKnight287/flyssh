import { PartialType } from '@nestjs/swagger';
import { CreateKeyDTO } from './create-key.dto';

export class UpdateKeyDTO extends PartialType(CreateKeyDTO) {}
