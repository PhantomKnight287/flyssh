-- DropForeignKey
ALTER TABLE "hosts" DROP CONSTRAINT "hosts_key_id_fkey";

-- AlterTable
ALTER TABLE "hosts" ADD COLUMN     "port" INTEGER NOT NULL DEFAULT 22,
ALTER COLUMN "key_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "hosts" ADD CONSTRAINT "hosts_key_id_fkey" FOREIGN KEY ("key_id") REFERENCES "keys"("id") ON DELETE SET NULL ON UPDATE CASCADE;
