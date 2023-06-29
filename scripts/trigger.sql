-- Создание триггера для автоматического обновления количества сотрудников в поликлинике при добавлении нового сотрудника:

CREATE OR REPLACE FUNCTION update_employee_amount()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE polic.private_clinics
    SET amount = amount + 1
    WHERE id_clinic = NEW.id_clinic;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_employee_amount_trigger
AFTER INSERT ON polic.employees
FOR EACH ROW
EXECUTE FUNCTION update_employee_amount();

-- Создание триггера для автоматического обновления общей стоимости услуги при изменении цены услуги:

CREATE OR REPLACE FUNCTION update_total_contribution()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE polic.services
    SET total_contribution = (SELECT SUM(cost_service) FROM polic.Cost_of_services WHERE type_service = NEW.type_service)
    WHERE type_service = NEW.type_service;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_total_contribution_trigger
AFTER INSERT OR UPDATE ON polic.Cost_of_services
FOR EACH ROW
EXECUTE FUNCTION update_total_contribution();

-- Создание триггера для автоматического обновления дохода и расхода клиники при добавлении новой записи в журнал:

CREATE OR REPLACE FUNCTION update_income_and_expense()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE polic.Income_and_expense
    SET income = income + (SELECT total_contribution FROM polic.services WHERE type_service = NEW.type_service),
        charges = charges + (SELECT price FROM polic.Supplies WHERE address = NEW.address)
    WHERE address = NEW.address AND name_clinic = (SELECT name_clinic FROM polic.private_clinics WHERE id_clinic = NEW.id_clinic);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_income_and_expense_trigger
AFTER INSERT ON polic.journal
FOR EACH ROW
EXECUTE FUNCTION update_income_and_expense();
