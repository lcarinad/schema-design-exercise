DROP DATABASE craigslist_db;
CREATE DATABASE craigslist_db;
\c craigslist_db;

Create Table regions (
    region_id SERIAL PRIMARY KEY,
    region_name TEXT NOT NULL);

Create Table users (
    user_id Serial PRIMARY KEY,
    user_name VARCHAR(18) UNIQUE NOT NULL,
    region_id INTEGER REFERENCES regions (region_id) ON DELETE CASCADE
);

Create Table categories (
    category_id Serial Primary Key,
    cat_name TEXT UNIQUE NOT NULL
);

Create Table posts(
    id Serial Primary Key,
    category_id INTEGER REFERENCES categories (category_id) ON DELETE CASCADE,
    title VARCHAR(30),
    post TEXT NOT NULL,
    user_id INTEGER REFERENCES users (user_id) ON DELETE CASCADE,
    city_state TEXT NOT NULL,
    region_id INTEGER REFERENCES regions (region_id)
);

INSERT INTO regions
(region_name)
VALUES
('Central NJ'), ('North Jersey'), ('NJ suburbs of NYC' ), ('South Jersey'), ('Jersey Shore');

INSERT INTO users
(user_name, region_id)
VALUES
('rosie_girl', 1), ('teddy_boy', 1), ('dog_mom', 2), ('dog_dad', 2), ('bailey', 3), ('walle', 3), ('dog_gma', 4), ('dog_gpa', 4), ('king_george', 4), ('jackson', 5), ('chrissy', 5), ('kenny', 5);

INSERT INTO categories
(cat_name)
VALUES
('for sale'), ('jobs'), ('housing'), ('services');

INSERT INTO posts
(category_id, title, post, user_id, city_state, region_id)
VALUES
(1, 'Selling Laptop', 'Brand new laptop for sale.', 1, 'New Brunswick, NJ', 1),
(2, 'Web Developer Position', 'We are hiring a web developer.', 2, 'Jersey City, NJ', 3),
(3, 'Apartment for Rent', 'Spacious 2-bedroom apartment available.', 3, 'Hoboken, NJ', 3),
(1, 'Used Car for Sale', '2008 Honda Civic for sale.', 4, 'Trenton, NJ', 4),
(4, 'Lawn Care Services', 'We offer lawn care and maintenance services.', 5, 'Atlantic City, NJ', 5),
(2, 'Graphic Designer Job', 'Job opening for a graphic designer.', 6, 'Princeton, NJ', 4),
(3, 'Roommate Needed', 'Looking for a roommate in a 3-bedroom house.', 7, 'Newark, NJ', 2),
(1, 'Furniture for Sale', 'Selling a complete living room set.', 8, 'Hoboken, NJ', 3),
(4, 'Plumbing Services', 'We provide plumbing services in the area.', 9, 'Camden, NJ', 4),
(2, 'Sales Associate Position', 'Retail store looking for a sales associate.', 10, 'Point Pleasant, NJ', 5),
(3, '2-Bedroom Apartment for Rent', 'Beautiful apartment available in a quiet neighborhood', 1, 'Cherry Hill, NJ', 4),
(1, 'Bicycle for Sale', 'Gently used mountain bike for sale at a great price.', 3, 'Toms River, NJ', 5);

SELECT user_name, title, post, city_state FROM users
JOIN posts ON users.user_id = posts.user_id                                                                                      ORDER by city_state;

SELECT user_name, city_state, region_name, cat_name, title, post  
FROM users   
JOIN posts ON users.user_id = posts.user_id    
JOIN regions ON regions.region_id = posts.region_id
JOIN categories ON categories.category_id = posts.category_id 
WHERE region_name = 'Jersey Shore';

SELECT user_name, city_state, region_name, cat_name, title, post  
FROM users   
JOIN posts ON users.user_id = posts.user_id    
JOIN regions ON regions.region_id = posts.region_id
JOIN categories ON categories.category_id = posts.category_id 
WHERE region_name = 'Jersey Shore' AND user_name = 'dog_mom';

SELECT user_name, city_state, region_name, cat_name, title, post  
FROM users   
JOIN posts ON users.user_id = posts.user_id    
JOIN regions ON regions.region_id = posts.region_id
JOIN categories ON categories.category_id = posts.category_id 
WHERE region_name = 'Jersey Shore' AND user_name = 'dog_mom';

SELECT region_name, COUNT(*)
FROM regions 
JOIN posts ON posts.region_id = regions.region_id
GROUP BY regions.region_name;