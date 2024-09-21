/*
  Warnings:

  - You are about to drop the `_HostToKey` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `key_id` to the `hosts` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "_HostToKey" DROP CONSTRAINT "_HostToKey_A_fkey";

-- DropForeignKey
ALTER TABLE "_HostToKey" DROP CONSTRAINT "_HostToKey_B_fkey";

-- AlterTable
ALTER TABLE "hosts" ADD COLUMN     "key_id" TEXT NOT NULL;

-- DropTable
DROP TABLE "_HostToKey";

-- AddForeignKey
ALTER TABLE "hosts" ADD CONSTRAINT "hosts_key_id_fkey" FOREIGN KEY ("key_id") REFERENCES "keys"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
