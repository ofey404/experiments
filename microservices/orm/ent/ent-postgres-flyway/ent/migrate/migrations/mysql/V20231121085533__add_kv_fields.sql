-- create "kv_pairs" table
CREATE TABLE `kv_pairs` (`id` bigint NOT NULL AUTO_INCREMENT, `key` varchar(255) NOT NULL, `value` varchar(255) NOT NULL, PRIMARY KEY (`id`), UNIQUE INDEX `key` (`key`)) CHARSET utf8mb4 COLLATE utf8mb4_bin;
