DROP DATABASE med_center_db;
CREATE DATABASE med_center_db;
\c med_center_db;

Create Table doctors (
    doctor_id Serial PRIMARY KEY,
    first_name text Not Null,
    last_name text Not Null
);

Create Table patients (
    patient_id Serial PRIMARY KEY,
    first_name text Not Null,
    last_name text Not Null
);

Create Table services_provided (
    id Serial Primary Key,
    date_of_service DATE NOT Null,
    patient_id INTEGER REFERENCES patients (patient_id),
    doctor_id INTEGER REFERENCES doctors (doctor_id)
);

Create Table medical_conditions (
    id Serial Primary Key,
    condition_name text Not Null
);

Create Table patient_diagnosis (
    id Serial Primary Key,
    patient_id INTEGER REFERENCES patients (patient_id),
    condition_id INTEGER REFERENCES medical_conditions
);



INSERT INTO doctors
(first_name, last_name)
VALUES
('Teddy', 'DeLago'),('Rosie', 'Sweetness'),('Gaelan', 'Mullins'), ('Izzy', 'Gonzalez'), ('Liza', 'Henriquez');

INSERT INTO patients
(first_name, last_name)
VALUES
('Trae', 'DeLago'), ('Vanessa', 'Holman'), ('Clara', 'Bell'), ('Sushil', 'Dayal'), ('Samantha', 'Tomblin');

INSERT INTO services_provided
(date_of_service, patient_id, doctor_id)
VALUES
('2023-01-02', 2, 2), ('2023-01-02', 3, 4),('2023-01-02', 3, 5),('2023-01-02', 3, 1), ('2023-01-03', 4, 4), ('2023-01-03', 5, 1), ('2023-01-03', 5, 2),('2023-01-03', 5, 3);

INSERT INTO medical_conditions
(condition_name)
VALUES
('flu'), ('strep'), ('fever'), ('eczema'), ('high blood pressure'), ('upset tum tums');

INSERT INTO patient_diagnosis
(patient_id, condition_id)
VALUES
(1,1), (1,3), (2, 6), (3, 5), (4, 5), (4, 6),(5, 1);

SELECT p.last_name, p.first_name, d.first_name AS doctor, mc.condition_name AS diagnosis
FROM patients p
JOIN services_provided s ON p.patient_id = s.patient_id
JOIN doctors d ON s.doctor_id = d.doctor_id
JOIN patient_diagnosis pd ON p.patient_id = pd.patient_id
JOIN medical_conditions mc ON pd.condition_id = mc.id
GROUP BY p.first_name, p.last_name, d.first_name, diagnosis
ORDER BY p.last_name;