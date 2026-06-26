import { PrismaClient } from '@prisma/client';
import { extension } from 'prisma-paginate';

const _ = new PrismaClient({
  errorFormat: 'pretty',
  log: ['error', 'info', 'warn'],
});

export const prisma = _.$extends(extension);
