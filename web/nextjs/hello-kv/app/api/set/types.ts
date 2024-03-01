export interface SetRequest {
  key: string;
  value: string;
}

export interface SetResponse {
  reply?: string;
  error?: string;
}
