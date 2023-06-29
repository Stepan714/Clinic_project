-- CRUD - CREATE, READ, UPDATE, DELETE

-----5 пункт---------
--insert - Done  (CREATE из CRUD)

-- select -- READ из CRUD
SELECT *
FROM polic.private_clinics;

SELECT *
FROM polic.clinic_addresses;

SELECT *
FROM polic.employees;

SELECT *
FROM polic.connect_employee_and_adsress;

SELECT *
FROM polic.clients
where age > 40;

SELECT *
FROM polic.services;

SELECT id_clinic, count(*) as cnt
FROM polic.journal
GROUP BY id_clinic
ORDER by cnt DESC;

SELECT *
FROM polic.cost_of_services
where cost_service > 2000;

-- update -- UPDATE из CRUD
UPDATE polic.cost_of_services
set cost_service = cost_service + 500
where cost_service < 2000;

update polic.supplies
set discount = discount - 0.05
WHERE discount > 0.15;

update polic.journal
set date_start = '2023-01-01 10:30:00', date_end = '2023-01-01 11:00:00'
where id_client = 111;

-- delete -- DELETE из CRUD

delete FROM polic.journal
where id_employee = 542198;

delete from polic.private_clinics
where id_clinic = 459813; -- не даст удалить, так как RESTRICT

DELETE from polic.employees
WHERE id_employee = 102; -- удалится каскадно
