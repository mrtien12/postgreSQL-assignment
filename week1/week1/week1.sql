--1--
--alter table if EXISTS countries 
--rename to country_new
--2--
--alter table locations
--add COLUMN region_id int 
--3--
--drop table locations CASCADE
/*create table locations (
	  id int ,
  	location_id int , 
  	street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12),
    country_id char(2),
    add constraint locations_pk primary key (location_id),
    foreign key (country_id) references country_new(country_id) on delete cascade
);
add this sql first 
*/
/*
alter table departments
	add CONSTRAINT fk_location_id foreign key (location_id) references locations(location_id) on delete cascade ;
*/
--add the above query next to finish task 3
--4--
--do it repeatly with the task 3
--5--
--/first/ alter table locations add COLUMN region_id varchar(2);
--/second/ alter TABLE locations alter column country_id type integer USING country_id::integer
--6--
--alter table locations drop COLUMN city
--7--
--alter table locations rename state_province to state
--8--
--already are primary key
--9-- 

--first--alter table locations drop CONSTRAINT locations_pk cascade --#drop first 
--second--alter table locations add CONSTRAINT locations_pk  PRIMARY key (location_id,country_id) 

--10--
--ALTER table locations drop CONSTRAINT locations_pk CASCADE       

--11----12--
--alter table job_history
--add CONSTRAINT job_id_fk FOREIGN key (job_id) REFERENCES jobs(job_id) on DELETE CASCADE
--13--
--alter table job_history drop CONSTRAINT job_id_fk CASCADE
--14--
--create index indx_job_id on job_history(job_id)
--15--
--drop INDEX indx_job_id