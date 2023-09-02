-- ChatGPTが一発で作りました
-- Drop in the order as provided (opposite of CREATE)
DROP TABLE IF EXISTS unread_announcements;
DROP TABLE IF EXISTS announcements;
DROP TABLE IF EXISTS submissions;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS registrations;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS users;

-- master data
CREATE TABLE users
(
    id              CHAR(26) PRIMARY KEY,
    code            CHAR(6) UNIQUE              NOT NULL,
    name            VARCHAR(255)                NOT NULL,
    hashed_password BYTEA                       NOT NULL,
    type            TEXT NOT NULL
);

CREATE TABLE courses
(
    id          CHAR(26) PRIMARY KEY,
    code        VARCHAR(255) UNIQUE                                           NOT NULL,
    type        TEXT                       NOT NULL,
    name        VARCHAR(255)                                                  NOT NULL,
    description TEXT                                                          NOT NULL,
    credit      SMALLINT                                                      NOT NULL,
    period      SMALLINT                                                      NOT NULL,
    day_of_week TEXT NOT NULL,
    teacher_id  CHAR(26)                                                      NOT NULL,
    keywords    TEXT                                                          NOT NULL,
    status      TEXT                NOT NULL DEFAULT 'registration'
);

CREATE TABLE registrations
(
    course_id CHAR(26),
    user_id   CHAR(26),
    PRIMARY KEY (course_id, user_id)
);

CREATE TABLE classes
(
    id                CHAR(26) PRIMARY KEY,
    course_id         CHAR(26)         NOT NULL,
    part              SMALLINT         NOT NULL,
    title             VARCHAR(255)     NOT NULL,
    description       TEXT             NOT NULL,
    submission_closed BOOLEAN          NOT NULL DEFAULT false,
    UNIQUE (course_id, part)
);

CREATE TABLE submissions
(
    user_id   CHAR(26)     NOT NULL,
    class_id  CHAR(26)     NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    score     SMALLINT,
    PRIMARY KEY (user_id, class_id)
);

CREATE TABLE announcements
(
    id         CHAR(26) PRIMARY KEY,
    course_id  CHAR(26)     NOT NULL,
    title      VARCHAR(255) NOT NULL,
    message    TEXT         NOT NULL
);

CREATE TABLE unread_announcements
(
    announcement_id CHAR(26)   NOT NULL,
    user_id         CHAR(26)   NOT NULL,
    is_deleted      BOOLEAN    NOT NULL DEFAULT false,
    PRIMARY KEY (announcement_id, user_id)
);

create index submissions_class_id_index
    on submissions (class_id);
    
create index courses_teacher_id_index2
    on courses (teacher_id);
    
create index classes_part_index
    on classes (part);

create index announcements_course_id_index
    on announcements (course_id);

create index unread_announcements_user_id_is_deleted_index
    on unread_announcements (user_id, is_deleted);

