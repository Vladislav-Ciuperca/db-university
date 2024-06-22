-- 1 Selezionare tutti gli studenti nati nel 1990
SELECT * FROM students WHERE YEAR(date_of_birth) = 1990;

-- 2 Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT * FROM courses WHERE cfu > 10;

-- 3 Selezionare tutti gli studenti che ad OGGI hanno almeno 30 anni compiuti (3725)
Select * FROM students WHERE date_of_birth > '1994-06-19'; --qua errore

-- 4 Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT * FROM courses WHERE period = 'I semestre' AND year = 1

-- 5 Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT * FROM exams WHERE date > '2020-06-20' AND hour(hour) > 14

-- 6 Selezionare tutti i corsi di laurea magistrale (38)
SELECT * FROM degrees WHERE level = 'magistrale'

-- 7 Da quanti dipartimenti è composta l'università? (12)
SELECT id FROM departments

-- 8 Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT * FROM teachers WHERE phone IS NOT NULL

-- 9 nserire nella tabella degli studenti un nuovo record con i propri dati (per il campo degree_id, inserire un valore casuale)
INSERT INTO `students` (`id`, `degree_id`, `name`, `surname`, `date_of_birth`, `fiscal_code`, `enrolment_date`, `registration_number`, `email`) VALUES (NULL, '1', 'Vladislav', 'Ciuperca', '1999-01-27', 'CPRVDS99A27Z154H', '2024-06-02', '', 'ciuperca37@gmail.com');

-- 10 Cambiare il numero dell’ufficio del professor Pietro Rizzo in 126
UPDATE `teachers` SET `office_number` = '126' WHERE `teachers`.`id` = 58; 

-- Eliminare dalla tabella studenti il record creato precedentemente al punto 9
DELETE FROM students WHERE name = 'vladislav' AND surname = 'ciuperca';

-------------------------------------------------------------------------------
-- esercizio GROUP BY

-- Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(id), year FROM courses GROUP BY year;
SELECT year, COUNT(*)  FROM courses GROUP BY year;

-- Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT  office_address, COUNT(*) AS insegnanti_in_edificio FROM teachers GROUP BY office_address
SELECT COUNT(*) AS insegnanti_in_edificio, office_address FROM teachers GROUP BY office_address

-- Calcolare la media dei voti di ogni appello d'esame
SELECT student_id, AVG(vote) from exam_student GROUP BY student_id

-- Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT count(id),department_id from degrees GROUP BY department_id ORDER BY `degrees`.`id` ASC;


----------------------------------------------------------
-- esercizio con JOIN

-- Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT * FROM students INNER JOIN degrees  ON degrees.id = students.degree_id WHERE degree_id = 53

-- Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT * FROM degrees WHERE name LIKE '%magistrale%'

-- Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT * 
FROM departments 
INNER JOIN degrees ON degrees.department_id = departments.id 
WHERE degrees.name LIKE '%magistrale%' AND departments.name LIKE '%neuroscienze%'

-- Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT *
FROM course_teacher
INNER JOIN teachers ON teachers.id = course_teacher.teacher_id where teacher_id = 44