import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { CreateHostDto } from './dto/create-host.dto';
import { UpdateHostDto } from './dto/update-host.dto';
import { prisma } from '../../db';
import { createId } from '@paralleldrive/cuid2';
import { plainToInstance } from 'class-transformer';
import { Host, PartialHost } from './entities/host.entity';
import { GenericResponseDto } from '../dto/generic-response.dto';

@Injectable()
export class HostsService {
  async create(createHostDto: CreateHostDto, userId: string) {
    if (!createHostDto.keyId && !createHostDto.password)
      throw new HttpException(
        'Please specify either a password or key',
        HttpStatus.BAD_REQUEST,
      );
    const newHost = await prisma.host.create({
      data: {
        id: `host_${createId()}`,
        label: createHostDto.label,
        hostname: createHostDto.hostname,
        username: createHostDto.username,
        password: createHostDto.password,
        iv: createHostDto.iv,
        key: createHostDto.keyId
          ? {
              connect: {
                id: createHostDto.keyId,
              },
            }
          : undefined,
        owner: {
          connect: {
            id: userId,
          },
        },
      },
      select: {
        id: true,
      },
    });
    return newHost;
  }

  async findAll({
    page,
    limit,
    userId,
  }: {
    page: number;
    limit: number;
    userId: string;
  }) {
    const hosts = await prisma.host.paginate({
      limit,
      page,
      select: {
        id: true,
        label: true,
        username: true,
        port: true,
        hostname: true,
      },
      where: {
        ownerId: userId,
      },
      orderBy: [
        {
          createdAt: 'desc',
        },
      ],
    });
    return plainToInstance(PartialHost, hosts.result);
  }

  async findOne(id: string, userId: string) {
    const host = await prisma.host.findFirst({
      where: {
        id,
        ownerId: userId,
      },
    });
    if (!host) throw new HttpException('No host found', HttpStatus.NOT_FOUND);
    return plainToInstance(Host, host);
  }

  async update(id: string, updateHostDto: UpdateHostDto, userId: string) {
    const host = await prisma.host.findFirst({
      where: {
        ownerId: userId,
        id,
      },
    });
    if (!host) throw new HttpException('No host found', HttpStatus.NOT_FOUND);
    const updatedHost = await prisma.host.update({
      where: {
        id: host.id,
      },
      data: {
        label: updateHostDto.label,
        username: updateHostDto.username,
        password: updateHostDto.password,
        keyId: updateHostDto.keyId,
      },
      select: { id: true },
    });
    return plainToInstance(GenericResponseDto, updatedHost);
  }

  async remove(id: string, userId: string) {
    const host = await prisma.host.findFirst({
      where: {
        id: id,
        ownerId: userId,
      },
    });
    if (!host) throw new HttpException('No host found', HttpStatus.NOT_FOUND);
    await prisma.host.delete({
      where: {
        id: id,
      },
    });
    return plainToInstance(GenericResponseDto, { id: host.id });
  }
}
