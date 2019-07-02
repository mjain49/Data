select * from tab;
--gives list of tables

--DML-->>Insert,Update,Delete

-->DDL-->CRETE,ALTER,DROP

-->TCL--?>Commit,Rollback,SavePoint

Select Command-->Retrieval

select * from departments;
-->Full Departmrnt table

select department_id,department_name from departments;
-->Only Department_id & Department_name from Department

desc employees;
-->Describe the Employee table Structure

five Constraints:-
-->Primary Key

-->Unique

-->only unique->It can be null or unique

-->Check Constraint-->Check for a specific condition but it can be unique

-->Foreign Key

create table Account


create table Account
(
aid number(8) primary key,
mobileno number(10) unique not null,
accountholder varchar2(30) not null,
balance number(8,2) check(balance>=1000.00)
);

>insert into Account values(100,9999999999,'King',24000.00);

>savepoint A; //Bookmark point

>insert into Account values(101,9999999994,'Raja',50000.00);

>insert into Account values(102,9999999222,'Ram',33000.00);

>savepoint B;//Bookmark point 

update Account set balance=30000.00,accountholder='King Khan' where aid=100;

delete from Account; //all rows deleted

rollback to B; //Roll back to savepoint B

commit; //saving the rollback

rollback;//after commit the changes done are permanent so no roll back

//ddl commands performs automatic commit

SQL> insert into Account values(102,9999999222,'Ram',33000.00);
insert into Account values(102,9999999222,'Ram',33000.00)
*
ERROR at line 1:
ORA-00001: unique constraint (HR.SYS_C007584) violated


SQL> insert into Account values(null,9999999222,'Ram',33000.00);
insert into Account values(null,9999999222,'Ram',33000.00)
                           *
ERROR at line 1:
ORA-01400: cannot insert NULL into ("HR"."ACCOUNT"."AID")


SQL> insert into Account values(103,,'Ram',33000.00);
insert into Account values(103,,'Ram',33000.00)
                               *
ERROR at line 1:
ORA-00936: missing expression


SQL> insert into Account values(103,null,'Ram',33000.00);
insert into Account values(103,null,'Ram',33000.00)
                               *
ERROR at line 1:
ORA-01400: cannot insert NULL into ("HR"."ACCOUNT"."MOBILENO")


SQL> insert into Account values(103,9821345678,'Ram',500.00);
insert into Account values(103,9821345678,'Ram',500.00)
*
ERROR at line 1:
ORA-02290: check constraint (HR.SYS_C007583) violated


SQL> insert into Account values(103,9999999222,'Ram',500.00);
insert into Account values(103,9999999222,'Ram',500.00)
*
ERROR at line 1:
ORA-02290: check constraint (HR.SYS_C007583) violated

>>set linesize 500;
>>select last_name,
salary,
commission_pct,
hire_date,
job_id,
department_id from employees 
where department_id=50 and job_id='ST_MAN';

select last_name,
salary,
commission_pct,
hire_date,
job_id,
department_id from employees 
where department_id=50 or job_id='ST_MAN';

>>>select last_name,
salary,
commission_pct,
hire_date,
job_id,
department_id from employees 
where department_id=50 or job_id like '%_MAN';

select last_name,
salary,
commission_pct,
hire_date,
job_id,
department_id from employees 
where job_id in ('ST_MAN','SA_MAN','PU_MAN');

select last_name,
salary,
commission_pct,
hire_date,
job_id,
department_id from employees 
where job_id NOT in ('ST_MAN','SA_MAN','PU_MAN');

select last_name,
salary,
commission_pct,
hire_date,
job_id,
department_id from employees 
where salary between 10000 and 20000
order by job_id,salary; //order by must be last clause

select last_name,
salary,
commission_pct,
hire_date,
job_id,
department_id from employees 
where salary NOT between 10000 and 20000
order by job_id,salary;

//between operator can also be used with Oracles date RR format refers to previous Century 95 means 1995
In YY format the year  95 means current century2095

select last_name,
salary,
commission_pct,
hire_date,
job_id,
department_id from employees 
where hire_date between '01-JAN-05' and '31-DEC-08'
order by hire_date;


select last_name, UPPER(last_name),Lower(last_name)
From Employees;
//Every row values are affected based on the conditions.//soiingle row function

select sum(salary) SUM from Employees;//Group Function i.e. consider all the values and only one result  will come


select sum(salary) SUM,
		max(salary) maxsalary,
		min(Salary) "Min Salary", //we want in this way not upper case so use ""
		count(salary) "Total Count",//space is allowed only in double ""
		avg(salary) As AverageSalary
	
	from Employees;

    SUM  MAXSALARY Min Salary Total Count AVERAGESALARY
------- ---------- ---------- ----------- -------------
 691416      24000       2100         107    6461.83178

 =========================================================
>>Rules
1)select count(*) as totalcount
this is only applicable for count funtion. * indicates entire record
//Null means empty neither zero nor space for any database
2)select avg(commission_pct) as totalcount,
	sum(commission_pct),
	count(commission_pct)
	from employees;

	//All group functions ignores null values

select avg(nvl(commission_pct,0) )as totalcount, //without nvl the null values are ignored but we have to count for average calculation and count total
	sum(commission_pct),
	count(nvl(commission_pct,0)) 
	from employees;

select sum(salary) as totalsum,
count(salary)
from employees
group by department_id;
//group by clause does not ignore null values/groups


select department_id,sum(salary) as totalsum,
count(salary)
from employees
group by department_id;

SQL> select department_id,job_id,sum(salary) as totalsum,
  2  count(salary) AS count
  3  from employees
  4  group by department_id,job_id
  5  order by department_id,job_id;

DEPARTMENT_ID JOB_ID       TOTALSUM      COUNT
------------- ---------- ---------- ----------
           10 AD_ASST          4400          1
           20 MK_MAN          13000          1
           20 MK_REP           6000          1
           30 PU_CLERK        13900          5
           30 PU_MAN          11000          1
           40 HR_REP           6500          1
           50 SH_CLERK        64300         20
           50 ST_CLERK        55700         20
           50 ST_MAN          36400          5
           60 IT_PROG         28800          5
           70 PR_REP          10000          1

DEPARTMENT_ID JOB_ID       TOTALSUM      COUNT
------------- ---------- ---------- ----------
           80 SA_MAN          61000          5
           80 SA_REP         243500         29
           90 AD_PRES         24000          1
           90 AD_VP           34000          2
          100 FI_ACCOUNT      39600          5
          100 FI_MGR          12008          1
          110 AC_ACCOUNT       8300          1
          110 AC_MGR          12008          1
              SA_REP           7000          1

// where clause we cannot apply group conditions so we have to use having


select department_id,job_id,sum(salary) as totalsum,
count(salary) AS count
from employees
having sum(Salary)>10000
group by department_id,job_id 
order by department_id,count;

//order by has to be last 
//having can be before or after group by but necessary to below from


DEPARTMENT_ID JOB_ID       TOTALSUM      COUNT
------------- ---------- ---------- ----------
           20 MK_MAN          13000          1
           30 PU_MAN          11000          1
           30 PU_CLERK        13900          5
           50 ST_MAN          36400          5
           50 ST_CLERK        55700         20
           50 SH_CLERK        64300         20
           60 IT_PROG         28800          5
           80 SA_MAN          61000          5
           80 SA_REP         243500         29
           90 AD_PRES         24000          1
           90 AD_VP           34000          2

DEPARTMENT_ID JOB_ID       TOTALSUM      COUNT
------------- ---------- ---------- ----------
          100 FI_MGR          12008          1
          100 FI_ACCOUNT      39600          5
          110 AC_MGR          12008          1


SQL>
SQL> select count(department_id) from employees;

COUNT(DEPARTMENT_ID)
--------------------
                 106

SQL> select count(distinct department_id) "Distinct Dept_ID" from employees;

Distinct Dept_ID
----------------
              11

---------------------------------------------------------
						JOINS
---------------------------------------------------------

select employees.employee_id,
	   employees.last_name,
	   employees.department_id,
	   departments.department_id,
	   departments.department_name
	   from Employees,Departments;

//it simply takes all the record(107) of employees and combine with every record of deparment
//107 * 27 =2889 records 

//cartesian product

-------------------------------------------------------------
cross join-->Standard Sql 1999
select employees.employee_id,
	   employees.last_name,
	   employees.department_id,
	   departments.department_id,
	   departments.department_name
	   from Employees cross join Departments;

//same output as above

----------------------------------------------------------------

----Equi join OR Inner Join--

select e.employee_id,
	   e.last_name,
	   e.department_id,
	   d.department_id,
	   d.department_name
	   from Employees e ,Departments d
	   where e.department_id=d.department_id;
	   
select e.employee_id,
	   e.last_name,
	   e.department_id,
	   d.department_id,
	   d.department_name
	   from Employees e JOIN Departments d
	   on e.department_id=d.department_id; //when join is used in place of where, on is used
	   
-----------------------------------------------------
select e.employee_id,
	   e.last_name,
	   e.department_id,
	   d.department_id,
	   d.department_name
	   from Employees e INNER JOIN Departments d
	   on e.department_id=d.department_id;

//107 records in employee but join is only showing 106 because one record is null that represent employee is with out department. 
---------------------------------------------------------
eqi join-->> Natural Join
==>Perform joins on common columns between tables 
-->>common in--> same column name,same data type, same size
-->Common columns are displayed only once. 

select * from Employees NATURAL JOIN DEPARTMENTS;

---------------------------------------------------

select * from Employees JOIN DEPARTMENTS using(Department_id);

---------------------------------------------------------
Left Outer Join ----->> matched and unmatched records

select e.employee_id,
	   e.last_name,
	   e.department_id,
	   d.department_id,
	   d.department_name
	   from Employees e LEFT OUTER JOIN Departments d
	   on e.department_id=d.department_id;

-----------------------------------------------------------
Right Outer Join

select e.employee_id,
	   e.last_name,
	   e.department_id,
	   d.department_id,
	   d.department_name
	   from Employees e Right OUTER JOIN Departments d
	   on e.department_id=d.department_id;
--------------------------------------------------------
select e.employee_id,
	   e.last_name,
	   e.department_id,
	   d.department_id,
	   d.department_name
	   from Employees e Full OUTER JOIN Departments d
	   on e.department_id=d.department_id;

-----------------------------------------------------------
SELF JOIN 


select w.employee_id,
	   w.last_name,
	   w.manager_id,
	   m.employee_id,
	   m.last_name
from   employees w join employees m
on w.manager_id=m.employee_id;


==============================
Non Eqi+ Self Join


select w.employee_id,
	   w.last_name,
	   w.manager_id,
	   w.hire_date,
	   m.employee_id,
	   m.last_name,
	   m.hire_date
from   employees w join employees m
on w.manager_id=m.employee_id
and
w.hire_date<m.hire_date;
