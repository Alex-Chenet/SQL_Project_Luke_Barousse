-- Creating data table--
CREATE TABLE job_applied (
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);

-- Inserting data into the table--
INSERT INTO job_applied 
    (
        job_id,
        application_sent_date,
        custom_resume,
        resume_file_name,
        cover_letter_sent,
        cover_letter_file_name,
    status)
VALUES (1,
        '2024-02-01', 
        TRUE, 
        'resume1.pdf', 
        TRUE, 
        'cover_letter1.pdf', 
        'submitted'),
       (2, '2024-02-02', FALSE, 'resume2.pdf', FALSE, NULL, 'interview scheduled'),
       (3, '2024-02-03', TRUE, 'resume3.pdf', TRUE, 'cover_letter3.pdf', 'ghosted'),
       (4, '2024-02-04', TRUE, 'resume4.pdf', FALSE, NULL, 'submitted'),
       (5, '2024-02-05', FALSE, 'resume5.pdf', TRUE, 'cover_letter5.pdf', 'rejected');

-- Altering the table to add a new column--
ALTER TABLE job_applied
ADD contact VARCHAR(50)

-- Updating the table to add contact information--
UPDATE job_applied
SET contact = 'John Doe'
WHERE job_id = 1;

UPDATE job_applied
SET contact = 'Jane Smith'
WHERE job_id = 2;

UPDATE job_applied
SET contact = 'Alice Johnson'
WHERE job_id = 3;

UPDATE job_applied
SET contact = 'Bob Brown'
WHERE job_id = 4;

UPDATE job_applied
SET contact = 'Emily Davis'
WHERE job_id = 5;

SELECT * FROM job_applied;

--Changing Column Name--
ALTER TABLE job_applied
RENAME COLUMN contact TO contact_name;

--Change Type of Column--
ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;

--Drop Column--
ALTER TABLE job_applied
DROP COLUMN contact_name;

--Drop Table--
DROP TABLE job_applied;

