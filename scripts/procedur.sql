-- Процедура поставки оборудования в клинику по адрессу, обновляются расходы конкретной клиники

CREATE OR REPLACE PROCEDURE equipment_delivery(place_address VARCHAR(50), discount NUMERIC, price NUMERIC)
LANGUAGE SQL 
AS $$
  INSERT INTO polic.supplies VALUES (place_address, discount, price);
  update polic.income_and_expense
  SET charges = charges + (1 - discount) * price
  where address like place_address;
$$;

-- Процедура прихода нового клиента и записи его в журнал

CREATE or REPLACE PROCEDURE new_client(id_client INTEGER, name_cl VARCHAR(30), age NUMERIC,
                                       sex VARCHAR(10), tel VARCHAR(15), type_service VARCHAR(100), id_clinic INTEGER,
                                       id_doctor INTEGER, date_start TIMESTAMP, date_end TIMESTAMP)
LANGUAGE SQL
as $$
	INSERT INTO polic.clients VALUES(id_client, name_cl, age, sex, tel);
	INSERT INTO polic.journal VALUES(id_client, type_service, id_clinic,
                                id_doctor, date_start, date_end);
$$


