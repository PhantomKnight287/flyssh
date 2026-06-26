import { Module } from '@nestjs/common';
import { HostsService } from './hosts.service';
import { HostsController } from './hosts.controller';

@Module({
  controllers: [HostsController],
  providers: [HostsService],
})
export class HostsModule {}
