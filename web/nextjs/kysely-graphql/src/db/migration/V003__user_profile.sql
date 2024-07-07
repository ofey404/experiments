CREATE TABLE userprofile
(
  user_id INTEGER NOT NULL,
  profile_info JSON NOT NULL DEFAULT '{}',
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE OR REPLACE FUNCTION create_profile() RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO userprofile (user_id, profile_info) VALUES (NEW.id, '{"bio": "This is a dummy profile", "interests": ["coding", "chess"]}');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER create_user_profile AFTER INSERT ON users
FOR EACH ROW
EXECUTE PROCEDURE create_profile();
