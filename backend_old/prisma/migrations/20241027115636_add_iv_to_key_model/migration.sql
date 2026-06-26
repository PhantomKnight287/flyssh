/*
  Warnings:

  - Added the required column `iv` to the `keys` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "keys" ADD COLUMN     "iv" TEXT NOT NULL;
