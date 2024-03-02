SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS high_school;

CREATE DATABASE high_school CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

USE high_school;

DROP TABLE IF EXISTS Student;
CREATE TABLE Student (
    registration_number INT NOT NULL auto_increment,
    first_name char(20) default NULL,
    last_name char(20) default NULL,
    date_of_birth char(20) default NULL,
    PRIMARY KEY (registration_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS Teacher;
CREATE TABLE Teacher (
    first_name char(20) NOT NULL,
    last_name char(20) NOT NULL,
    date_of_birth varchar(20) default NULL,
    PRIMARY KEY (first_name, last_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS Course;
CREATE TABLE Course (
    name char(80) NOT NULL,
    PRIMARY KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS CourseSchedule;
CREATE TABLE CourseSchedule (
    course_name char(80) NOT NULL,
    day_of_week DATE DEFAULT NULL,
    start_time TIME DEFAULT NULL,
    end_time TIME DEFAULT NULL,
    PRIMARY KEY (course_name, day_of_week),
    CONSTRAINT course_schedule_fk FOREIGN KEY (course_name) REFERENCES Course (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS Registration;
CREATE TABLE Registration (
    course_name char(80) NOT NULL,
    student_registration_number INT NOT NULL,
    created_at DATE NOT NULL,
    PRIMARY KEY (course_name, student_registration_number),
    CONSTRAINT student_registration_fk FOREIGN KEY (student_registration_number) REFERENCES Student (registration_number),
    CONSTRAINT course_registration_fk FOREIGN KEY (course_name) REFERENCES Course (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS Assignment;
CREATE TABLE Assignment (
    course_name char(80) NOT NULL,
    teacher_first_name char(20) NOT NULL,
    teacher_last_name char(20) NOT NULL,
    PRIMARY KEY (course_name, teacher_first_name, teacher_last_name),
    CONSTRAINT course_assignment_fk FOREIGN KEY (course_name) REFERENCES Course (name),
    CONSTRAINT teacher_assignment_fk FOREIGN KEY (teacher_first_name, teacher_last_name) REFERENCES Teacher (first_name, last_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS Evaluation;
CREATE TABLE Evaluation (
    id INT NOT NULL auto_increment,
    status ENUM ('passed', 'failed') NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS PartialNote;
CREATE TABLE PartialNote (
    course_name char(80) NOT NULL,
    teacher_first_name char(20) NOT NULL,
    teacher_last_name char(20) NOT NULL,
    student_registration_number INT NOT NULL,
    note float(9,3) NOT NULL,
    create_at DATE NOT NULL,
    evaluation_id INT NULL,
    PRIMARY KEY (course_name, teacher_first_name, teacher_last_name, student_registration_number, evaluation_id),
    CONSTRAINT course_reg_par_note_fk FOREIGN KEY (course_name, student_registration_number) REFERENCES Registration (course_name, student_registration_number),
    CONSTRAINT teacher_assig_par_note_fk FOREIGN KEY (teacher_first_name, teacher_last_name) REFERENCES Teacher (first_name, last_name),
    CONSTRAINT evaluation_par_note_fk FOREIGN KEY (evaluation_id) REFERENCES Evaluation (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO Teacher (first_name, last_name, date_of_birth) VALUES
  ('Juan', 'Gomez', '1985-08-31'),
  ('Mauro', 'Paglialunga', '2000-02-15'),
  ('Tiziano', 'Ferro', '1995-02-15');
COMMIT;


INSERT INTO Student (first_name, last_name, date_of_birth) VALUES
  ('Cristian', 'Godoy', '1985-10-04'),
  ('Marco', 'Redondo', '1991-01-05'),
  ('Ezequiel', 'Villegas', '1985-10-04'),
  ('Martin', 'Giraudo', '1991-01-05'),
  ('Alan', 'Colazo', '1985-10-04'),
  ('Emiliano', 'Lezcano', '1990-05-15'),
  ('David', 'Cabral', '1982-11-25'),
  ('Federico', 'Estefano', '1982-03-27'),
  ('Hugo', 'Cardozo', '1991-01-05'),
  ('Federico', 'Acosta', '1990-09-25');
COMMIT;

INSERT INTO Student (first_name, last_name, date_of_birth) VALUES
  ('Python3'),
  ('MySQL'),
  ('Rust');
COMMIT;



