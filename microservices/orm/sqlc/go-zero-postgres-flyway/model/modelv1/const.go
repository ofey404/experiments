package modelv1

const SchemaVersion = "1.0.0"

func (q *Queries) GetSupportedSchemaVersion() string {
	return SchemaVersion
}
