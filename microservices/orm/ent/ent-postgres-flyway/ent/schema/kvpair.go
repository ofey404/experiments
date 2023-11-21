package schema

import "entgo.io/ent"

// KVPair holds the schema definition for the KVPair entity.
type KVPair struct {
	ent.Schema
}

// Fields of the KVPair.
func (KVPair) Fields() []ent.Field {
	return nil
}

// Edges of the KVPair.
func (KVPair) Edges() []ent.Edge {
	return nil
}
