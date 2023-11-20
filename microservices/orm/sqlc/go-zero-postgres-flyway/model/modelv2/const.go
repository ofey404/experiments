package modelv2

const SchemaVersion = "2.0.0"

func (q *Queries) GetSupportedSchemaVersion() string {
	return SchemaVersion
}
