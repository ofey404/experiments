import type { ColumnType } from "kysely";

export type Generated<T> = T extends ColumnType<infer S, infer I, infer U>
  ? ColumnType<S, I | undefined, U>
  : ColumnType<T, T | undefined, T>;

export type Int8 = ColumnType<string, bigint | number | string, bigint | number | string>;

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
  users: Users;
  verification_token: VerificationToken;
}
