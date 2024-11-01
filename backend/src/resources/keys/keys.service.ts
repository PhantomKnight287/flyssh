import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { CreateKeyDTO } from './dto/create-key.dto';
import { User } from '@prisma/client';
import { prisma } from 'src/db';
import { createId } from '@paralleldrive/cuid2';
import { KeyEntity } from './entities/key.entity';
import { plainToInstance } from 'class-transformer';
import { GenericResponseDto } from '../dto/generic-response.dto';
import { UpdateKeyDTO } from './dto/update-key.dto';

@Injectable()
export class KeysService {
  async create(body: CreateKeyDTO, user: User) {
    const key = await prisma.key.create({
      data: {
        id: `key_${createId()}`,
        label: body.label,
        value: body.value,
        passphrase: body.passphrase,
        iv: body.iv,
        owner: {
          connect: {
            id: user.id,
          },
        },
      },
    });
    return {
      id: key.id,
    };
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
    const keys = await prisma.key.paginate({
      limit,
      page,
      select: {
        id: true,
        label: true,
        iv: true,
        value: true,
        passphrase: true,
        _count: {
          select: {
            hosts: true,
          },
        },
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
    return keys.result;
  }

  async findOne(id: string, userId: string) {
    const key = await prisma.key.findFirst({
      where: {
        id,
        ownerId: userId,
      },
    });
    if (!key) throw new HttpException('No key found', HttpStatus.NOT_FOUND);
    return plainToInstance(KeyEntity, key);
  }

  async delete(id: string, userId: string) {
    const key = await prisma.key.findFirst({
      where: {
        id,
        ownerId: userId,
      },
    });
    if (!key) throw new HttpException('No key found', HttpStatus.NOT_FOUND);
    await prisma.key.delete({
      where: {
        id: key.id,
      },
    });
    return plainToInstance(GenericResponseDto, { id: key.id });
  }

  async update(id: string, updateKeyDto: UpdateKeyDTO, userId: string) {
    const key = await prisma.key.findFirst({
      where: {
        id,
        ownerId: userId,
      },
    });
    if (!key) throw new HttpException('No key found', HttpStatus.NOT_FOUND);
    const updatedKey = await prisma.key.update({
      where: {
        id: key.id,
      },
      data: {
        label: updateKeyDto.label,
        value: updateKeyDto.value,
        passphrase: updateKeyDto.passphrase,
        iv: updateKeyDto.iv,
      },
      select: { id: true },
    });
    return plainToInstance(GenericResponseDto, { id: updatedKey.id });
  }
}
