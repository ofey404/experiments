import type { ColumnType } from "kysely";

export type Generated<T> = T extends ColumnType<infer S, infer I, infer U>
  ? ColumnType<S, I | undefined, U>
  : ColumnType<T, T | undefined, T>;

export type Int8 = ColumnType<string, bigint | number | string, bigint | number | string>;

export type Json = JsonValue;

export type JsonArray = JsonValue[];

export type JsonObject = {
  [K in string]?: JsonValue;
};

export type JsonPrimitive = boolean | number | string | null;

export type JsonValue = JsonArray | JsonObject | JsonPrimitive;

export type Timestamp = ColumnType<Date, Date | string, Date | string>;

export interface Accounts {
  access_token: string | null;
  expires_at: Int8 | null;
  id: Generated<number>;
  id_token: string | null;
  provider: string;
  providerAccountId: string;
  refresh_token: string | null;
  scope: string | null;
  session_state: string | null;
  token_type: string | null;
  type: string;
  userId: number;
}

export interface FlywaySchemaHistory {
  checksum: number | null;
  description: string;
  execution_time: number;
  installed_by: string;
  installed_on: Generated<Timestamp>;
  installed_rank: number;
  script: string;
  success: boolean;
  type: string;
  version: string | null;
}

export interface KeyValue {
  key: string;
  value: string;
}

export interface Sessions {
  expires: Timestamp;
  id: Generated<number>;
  sessionToken: string;
  userId: number;
}

export interface Userprofile {
  profile_info: Generated<Json>;
  user_id: number;
}

export interface Users {
  email: string | null;
  emailVerified: Timestamp | null;
  id: Generated<number>;
  image: string | null;
  name: string | null;
}

export interface VerificationToken {
  expires: Timestamp;
  identifier: string;
  token: string;
}

export interface DB {
  accounts: Accounts;
  flyway_schema_history: FlywaySchemaHistory;
  key_value: KeyValue;
  sessions: Sessions;
  userprofile: Userprofile;
  users: Users;
  verification_token: VerificationToken;
}
