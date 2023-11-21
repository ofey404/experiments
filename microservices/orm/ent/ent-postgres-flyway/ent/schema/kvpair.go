package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/field"
)

// KVPair holds the schema definition for the KVPair entity.
type KVPair struct {
	ent.Schema
}

// Fields of the KVPair.
func (KVPair) Fields() []ent.Field {
	return []ent.Field{
		field.String("key").Unique(),
		field.String("value"),
	}
}

// Edges of the KVPair.
func (KVPair) Edges() []ent.Edge {
	return nil
}
