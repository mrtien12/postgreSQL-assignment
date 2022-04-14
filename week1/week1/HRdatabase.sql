create table regions (
    region_id int ,
    region_name varchar(25),
    CONSTRAINT regions_pk primary key(region_id)
);
create table jobs(
    job_id varchar(10),
    job_title varchar(35),
    min_salary int , 
    max_salary int ,
    CONSTRAINT jobs_pk primary key(job_id)
);
create table countries (
    country_id char(2),
    country_name varchar(40),
    region_id int,
    CONSTRAINT countries_pk primary key (country_id),
    foreign key (region_id) references regions(region_id) on delete cascade
);
create table locations (
    location_id int ,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12),
    country_id char(2),
    CONSTRAINT locations_pk primary key (location_id),
    foreign key (country_id) references countries(country_id) on delete cascade
);
create table departments(
    department_id int , 
    department_name varchar(30),
    manager_id int ,
    location_id int , 
    CONSTRAINT departments_pk primary key (department_id),
    foreign key (location_id) references locations(location_id) on delete cascade 
);
create table job_history (
    employee_id int ,
    start_date1 date, 
    end_date date , 
    job_id varchar(10),
    department_id int ,
    CONSTRAINT job_history_pk primary key (employee_id,start_date1),
  	UNIQUE(employee_id),
    foreign key (department_id) references departments(department_id) on delete cascade,
    foreign key (job_id) references jobs(job_id) on delete cascade
);
create table employees (
    employee_id int ,
    first_name varchar(20),
    last_name varchar(25),
    email varchar(25),
    phone_number varchar(25),
    hire_date date , 
    job_id varchar(10),
    salary int , 
    commission_pct int , 
    manager_id int , 
    department_id int ,
    CONSTRAINT employees_pk primary key(employee_id),
    foreign key (department_id) references departments(department_id) on delete cascade,
    foreign key (job_id) references jobs(job_id) on delete cascade,
    foreign key (employee_id) references job_history(employee_id) on delete cascade
);


create table job_grades(
    grade_level varchar(21),
    lowest_sal int , 
    highest_sal int ,
    primary key (grade_level)
);