import { Injectable } from '@nestjs/common';
import { CreateKeyDTO } from './dto/create-key.dto';
import { User } from '@prisma/client';
import { prisma } from 'src/db';
import { createId } from '@paralleldrive/cuid2';

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
}
