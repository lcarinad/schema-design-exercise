DROP DATABASE craigslist_db;
CREATE DATABASE craigslist_db;
\c craigslist_db;

Create Table regions (
    region_id SERIAL PRIMARY KEY,
    region_name
);

Create Table users (
    user_id Serial PRIMARY KEY,
    user_name VARCHAR(10) UNIQUE NOT NULL,
    region_id INTEGER REFERENCES regions (region_id) ON DELETE CASCADE
);

Create Table categories (
    category_id Serial Primary Key,
    cat_name TEXT UNIQUE NOT NULL
);

Create Table posts(
    id Serial Primary Key,
    category_id INTEGER REFERENCES categories (category_id) ON DELETE CASCADE,
    title VARCHAR(20),
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
(rosie_girl, 1), (teddy_boy, 1), (dog_mom, 2), (dog_dad, 2), (bailey, 3), (walle, 3), (dog_gma, 4), (dog_gpa, 4), (king_george, 4), (jackson, 5), (chrissy, 5), (kenny, 5);

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
(2, 'Sales Associate Position', 'Retail store looking for a sales associate.', 10, 'Point Pleasant, NJ', 5);
