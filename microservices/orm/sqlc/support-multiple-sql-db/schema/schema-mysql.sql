CREATE TABLE authors (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         name VARCHAR(255) NOT NULL,
                         birth_date DATE
);

CREATE TABLE books (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       title VARCHAR(255) NOT NULL,
                       publication_date DATE,
                       author_id INT NOT NULL,
                       FOREIGN KEY (author_id) REFERENCES authors(id)
);
