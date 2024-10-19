-- -------------------------------------------------------------
-- TablePlus 6.1.8(574)
--
-- https://tableplus.com/
--
-- Database: mydatabase
-- Generation Time: 2567-10-19 14:18:19.2340
-- -------------------------------------------------------------


DROP TABLE IF EXISTS "public"."admin_conversations";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."admin_conversations" (
    "admin_id" int4 NOT NULL,
    "conversation_id" varchar(255) NOT NULL,
    PRIMARY KEY ("admin_id","conversation_id")
);

DROP TABLE IF EXISTS "public"."conversations";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."conversations" (
    "conversation_id" varchar(255) NOT NULL,
    "platform_name" varchar(50),
    "conversation_type" varchar(50),
    "is_admin_conversation" bool DEFAULT false,
    "created_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("conversation_id")
);

DROP TABLE IF EXISTS "public"."message_status";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."message_status" (
    "message_id" varchar(255) NOT NULL,
    "user_id" varchar(255) NOT NULL,
    "platform_name" varchar(50),
    "read_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("message_id","user_id")
);

DROP TABLE IF EXISTS "public"."messages";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."messages" (
    "message_id" varchar(255) NOT NULL,
    "conversation_id" varchar(255),
    "sender_id" varchar(255),
    "platform_name" varchar(50),
    "message_text" text,
    "message_type" varchar(50),
    "sent_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("message_id")
);

DROP TABLE IF EXISTS "public"."permissions";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS permissions_permission_id_seq;

-- Table Definition
CREATE TABLE "public"."permissions" (
    "permission_id" int4 NOT NULL DEFAULT nextval('permissions_permission_id_seq'::regclass),
    "user_id" int4,
    "permission_name" varchar(255),
    PRIMARY KEY ("permission_id")
);

DROP TABLE IF EXISTS "public"."user_platforms";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."user_platforms" (
    "platform_user_id" varchar(255) NOT NULL,
    "global_user_id" varchar(255),
    "platform_name" varchar(50),
    "username" varchar(255),
    PRIMARY KEY ("platform_user_id")
);

DROP TABLE IF EXISTS "public"."users";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS users_user_id_seq;
DROP TYPE IF EXISTS "public"."user_role";
CREATE TYPE "public"."user_role" AS ENUM ('user', 'admin');

-- Table Definition
CREATE TABLE "public"."users" (
    "user_id" int4 NOT NULL DEFAULT nextval('users_user_id_seq'::regclass),
    "global_user_id" varchar(255),
    "name" varchar(255),
    "email" varchar(255),
    "password" varchar(255),
    "role" "public"."user_role" DEFAULT 'user'::user_role,
    "created_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("user_id")
);

ALTER TABLE "public"."admin_conversations" ADD FOREIGN KEY ("conversation_id") REFERENCES "public"."conversations"("conversation_id");
ALTER TABLE "public"."admin_conversations" ADD FOREIGN KEY ("admin_id") REFERENCES "public"."users"("user_id");
ALTER TABLE "public"."message_status" ADD FOREIGN KEY ("message_id") REFERENCES "public"."messages"("message_id");
ALTER TABLE "public"."message_status" ADD FOREIGN KEY ("user_id") REFERENCES "public"."user_platforms"("platform_user_id");
ALTER TABLE "public"."messages" ADD FOREIGN KEY ("conversation_id") REFERENCES "public"."conversations"("conversation_id");
ALTER TABLE "public"."messages" ADD FOREIGN KEY ("sender_id") REFERENCES "public"."user_platforms"("platform_user_id");
ALTER TABLE "public"."permissions" ADD FOREIGN KEY ("user_id") REFERENCES "public"."users"("user_id");
ALTER TABLE "public"."user_platforms" ADD FOREIGN KEY ("global_user_id") REFERENCES "public"."users"("global_user_id");


-- Indices
CREATE UNIQUE INDEX users_global_user_id_key ON public.users USING btree (global_user_id);
