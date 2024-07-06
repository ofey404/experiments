import type { ColumnType } from "kysely";

export type Generated<T> = T extends ColumnType<infer S, infer I, infer U>
  ? ColumnType<S, I | undefined, U>
  : ColumnType<T, T | undefined, T>;

export type Timestamp = ColumnType<Date, Date | string, Date | string>;

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

export interface DB {
  flyway_schema_history: FlywaySchemaHistory;
  key_value: KeyValue;
}
