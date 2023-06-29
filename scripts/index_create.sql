CREATE INDEX name_clinic_index
on polic.private_clinics (name_clinic);

CREATE INDEX name_experience_index
on polic.employees (second_name, first_name, experience);

CREATE INDEX name_client_index
on polic.clients (name_client);

CREATE index journal_index
on polic.journal (date_start, id_employee);

CREATE INDEX type_and_cost_index
on polic.cost_of_services (type_service, cost_service);

CREATE INDEx address_index_from_supplies
on polic.supplies (address);

CREATE index system_of_income_charges
on polic.income_and_expense (name_clinic, income, charges);
