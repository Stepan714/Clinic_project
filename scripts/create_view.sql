-------1----------------
CREATE or REPLACE VIEW inf_of_clients AS
SELECT
	name_client,
    age,
    sex,
    CONCAT(CONCAT(SUBSTRING(telephon, 1, 5), '****'), SUBSTRING(telephon, 10, 3)) as telephon
from polic.clients
WITH CASCADEd CHECK OPTION;

-------2----------------
CREATE or REPLACE VIEW discrabe_income_charges AS
SELECT
	name_clinic,
    sum(income) as sum_income,
    SUM(charges) as sun_charges,
    (sum(income) - SUM(charges)) / SUM(charges) * 100 as ROI
from polic.income_and_expense
GROUP by name_clinic
ORDER by ROI DESC, name_clinic;

-------3-----------------
CREATE or REPLACE VIEW supplies_inf AS
SELECT
	address,
    price * (1 - discount) as price
FROM polic.supplies
WITH CASCADEd CHECK OPTION;

-------4------------------
CREATE or REPLACE VIEW nameclinic_with_employee AS
SELECT
	name_clinic,
    first_name,
    second_name
FROM
	(polic.private_clinics INNER join polic.clinic_addresses USING(id_clinic)
    	INNER JOIN
   	polic.connect_employee_and_adsress USING(address)) as first_table
    INNER JOIN
	polic.employees as second_table on first_table.id_employee = second_table.id_employee;

------5------------------

CREATE or REPLACE VIEW clinic_cost_servise as
select
	name_clinic,
    type_service,
    cost_service
from polic.private_clinics left join polic.cost_of_services using(id_clinic)
ORDER by name_clinic, type_service;

------6--------------------

create or replace view journal_with_client_and_employee as
select
	name_client,
    type_service,
    CONCAT(first_name, CONCAT(' ', second_name)) as doctor_name,
    date_start,
    date_end
from
	polic.clients inner join polic.journal using(id_client)
	inner JOIN
    polic.employees USING(id_employee)
ORDER by date_end - date_start;

------7--------------------

CREATE or replace VIEW analitics_of_client as
select
	sex,
    age,
	count(*) as count
from polic.clients
GROUP by sex, age;
