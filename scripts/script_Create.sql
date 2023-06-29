create SCHEMA polic

-- Частные поликлиники
CREATE TABLE polic.private_clinics(
  id_clinic INTEGER,
  name_clinic VARCHAR(50) NOT NULL,
  amount INTEGER DEFAULT 0 CHECK (amount >= 0),

  CONSTRAINT PK_private_clinics PRIMARY KEY(id_clinic)
);

-- Адреса клиник
CREATE TABLE polic.clinic_addresses(
  address VARCHAR(50),
  id_clinic INTEGER,
  working_hours_start TIME,
  working_hours_finish TIME,

  CONSTRAINT PK_clinic_addresses PRIMARY KEY(address),
  CONSTRAINT FK_private_clinics FOREIGN KEY(id_clinic)
  REFERENCES polic.private_clinics(id_clinic) ON DELETE RESTRICT
);

CREATE TABLE polic.employees(
  id_employee INTEGER,
  second_name VARCHAR(20) NOT NULL,
  first_name VARCHAR(20) NOT NULL,
  experience INTEGER DEFAULT 0 CHECK (experience >= 0),

  CONSTRAINT PK_employees PRIMARY KEY(id_employee)
);

-- Связь адресов и сотрудников (многие ко многим)
CREATE table polic.connect_employee_and_adsress(
  address VARCHAR(50),
  id_employee INTEGER,

  CONSTRAINT FK_adress FOREIGN KEY(address) REFERENCES polic.clinic_addresses(address) ON DELETE CASCADE on UPDATE CASCADE,

  CONSTRAINT FK_employee FOREIGN KEY(id_employee) REFERENCES polic.employees(id_employee) ON DELETE CASCADE on UPDATE CASCADE
);

create table polic.clients(
  id_client INTEGER,
  name_client VARCHAR(30) not NULL,
  age DECIMAL CHECK (age >= 0),
  sex VARCHAR(10),
  telephon VARCHAR(15),

  CONSTRAINT PK_clients PRIMARY KEY(id_client)
);

CREATE TABLE polic.services(
  type_service VARCHAR(100),
  purpose TEXT NOT NULL,
  total_contribution NUMERIC DEFAULT 0 CHECK (total_contribution >= 0),

  CONSTRAINT PK_service PRIMARY KEY(type_service)
);

create table polic.journal(
  id_client INTEGER,
  type_service VARCHAR(100),
  id_clinic INTEGER,
  id_employee INTEGER,
  date_start TIMESTAMP DEFAULT now()::date,
  date_end TIMESTAMP DEFAULT now()::date,

  CONSTRAINT FK_employee FOREIGN KEY(id_employee) REFERENCES polic.employees(id_employee) ON DELETE CASCADE on UPDATE CASCADE,
  CONSTRAINT FK_client FOREIGN KEY(id_client) REFERENCES polic.clients(id_client) ON DELETE CASCADE on UPDATE CASCADE,
  CONSTRAINT FK_service FOREIGN KEY(type_service) REFERENCES polic.services(type_service) ON DELETE CASCADE on UPDATE CASCADE,
  CONSTRAINT FK_private_clinics FOREIGN KEY(id_clinic) REFERENCES polic.private_clinics(id_clinic) ON DELETE CASCADE on UPDATE CASCADE
);


CREATE TABLE polic.Cost_of_services(
  id_clinic INTEGER,
  type_service TEXT,
  cost_service NUMERIC NOT NULL CHECK (cost_service >= 0),

  CONSTRAINT FK_services FOREIGN KEY(type_service) REFERENCES polic.services(type_service) ON DELETE CASCADE on UPDATE CASCADE,
  CONSTRAINT FK_private_clinics FOREIGN KEY(id_clinic) REFERENCES polic.private_clinics(id_clinic) ON DELETE CASCADE on UPDATE CASCADE
);

CREATE TABLE polic.Supplies(
  address VARCHAR(50),
  discount NUMERIC DEFAULT 0 CHECK (discount >= 0),
  price NUMERIC DEFAULT 0 CHECK (price >= 0),

  CONSTRAINT FK_adress FOREIGN KEY(address) REFERENCES polic.clinic_addresses(address) ON DELETE CASCADE on UPDATE CASCADE
);

CREATE TABLE polic.Income_and_expense(
  address VARCHAR(50),
  name_clinic VARCHAR(100),
  income NUMERIC DEFAULT 0 CHECK (income >= 0),
  charges NUMERIC DEFAULT 0 CHECK (charges >= 0),

  CONSTRAINT FK_adress FOREIGN KEY(address) REFERENCES polic.clinic_addresses(address) ON DELETE CASCADE on UPDATE CASCADE
);
