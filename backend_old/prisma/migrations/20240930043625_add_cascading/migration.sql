-- DropForeignKey
ALTER TABLE "hosts" DROP CONSTRAINT "hosts_owner_id_fkey";

-- DropForeignKey
ALTER TABLE "keys" DROP CONSTRAINT "keys_owner_id_fkey";

-- AddForeignKey
ALTER TABLE "hosts" ADD CONSTRAINT "hosts_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "keys" ADD CONSTRAINT "keys_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
