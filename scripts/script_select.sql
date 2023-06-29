-----6 пункт---------

-- 1)Найти максимальную стоимость услуги, которую оказывает каждый сотрудник, записанный в журнале

WITH
	copy_t as (
      SELECT
      	type_service,
      	cost_service
      from polic.cost_of_services
    )
SELECT polic.employees.second_name as surname, polic.employees.first_name as firstname, max(copy_t.cost_service) as max_cost
from copy_t inner JOIN polic.journal USING(type_service) as second_table
inner join polic.employees USING(id_employee)
GROUP BY polic.employees.second_name, polic.employees.first_name
ORDER by surname, firstname;

-- 2) Найти все уникальные скидки и посчитать их кол-во, оставить только скидки, которые выданы более 1 поликлинике,
--    Отсортировать по убыванию скидки.

select
    discount,
    count(*) as cnt
from polic.supplies
GROUP BY discount
HAVING count(*) > 1
order by discount desc;

-- 3) Сравнить среднюю стоимость  услуг каждой поликлиники с каждой услугой

SELECT
    name_clinic,
    type_service,
    cost_service,
    avg(cost_service) OVER(PARTITION by id_clinic) as avg_cost
from polic.cost_of_services inner join polic.private_clinics USING(id_clinic)
order by name_clinic, type_service;

-- 4) Пронумеровать сотрудников в зависимости от их опыта работы.
-- Человек с наибольшим опытом работы имеет номер 1.

select
    first_name,
    second_name,
    ROW_NUMBER() over(ORDER By experience DESC) as row_num
from polic.employees;

-- 5) Ученик Петя ошибся, когда писал insert к таблице сотрудников,
-- ошибка заключается в том, что нужный опыт работника находится у следующего за ним. Известно, что у последнего сотрудника опыт работы 5 лет
-- Исправьте эту проблему. Выведите нужную таблицу.

select
    first_name,
    second_name,
    LEAD(experience, 1, 5) over() as experience
from polic.employees;


-- 6) -- Для каждого сервиса посчитать сумму стоимостей, причем
-- по каждому окну сумма увеличивается взависимости от сортировки цены
-- Смысл для partition и order by одновременно в моих таблицах сложно придумать

SELECT
    type_service,
    sum(cost_service) over(PARTITION by type_service
                           order by cost_service) as sum_
from polic.cost_of_services;

