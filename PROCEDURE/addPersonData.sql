DROP PROCEDURE IF EXISTS addPersonData;
DELIMITER $$
CREATE PROCEDURE addPersonData(
	-- input arguments
	IN new_country varchar(55),
	IN new_postal_code varchar(12),
	IN new_city varchar(60),
	IN new_street varchar(100),
	IN new_house_number varchar(9),
	IN new_flat_number varchar(45),
	IN new_surname varchar(50),
	IN new_name varchar(50),
	IN new_e_mail varchar(100),
	IN new_gender varchar(10),
	IN new_phone_number varchar(15),
    -- output argument
    OUT personID INT
	)
BEGIN
	-- error handling declaration for sqlexception
	DECLARE exit handler for sqlexception
	BEGIN
		-- ERROR
		resignal; # rethrow the exception to let client learn what exactly happened
		select "exception, transaction rollbacked"; # should not reach here
		ROLLBACK;
	END;
	-- error handling declaration for sqlwarning
	DECLARE exit handler for sqlwarning
	BEGIN
		-- WARNING
		resignal;
		select "warning, transaction rollbacked";
		ROLLBACK;
	END;
    -- starting the transaction
	START TRANSACTION;
    -- if there is already a row that contains the entered data, it returns its ID
	IF EXISTS (SELECT * FROM gyms.person_data p
					WHERE p.surname = new_surname
					AND p.name = new_name
					AND p.e_mail = new_e_mail
					AND p.gender = new_gender
					AND p.phone_number = new_phone_number
                    ) THEN
		-- ID is assigned
		SELECT p.person_data_id INTO personID FROM gyms.person_data p
					WHERE p.surname = new_surname
					AND p.name = new_name
					AND p.e_mail = new_e_mail
					AND p.gender = new_gender
					AND p.phone_number = new_phone_number;
	
    --  if no such line exists, it creates a new member
	ELSEIF NOT EXISTS (SELECT * FROM gyms.person_data p
					WHERE p.surname = new_surname
					AND p.name = new_name
					AND p.e_mail = new_e_mail
					AND p.gender = new_gender
					AND p.phone_number = new_phone_number
                    ) THEN 
		-- calling the procedure responsible for adding addAddress (...)
		CALL addAddress(new_country, new_postal_code, new_city, new_street, new_house_number, new_flat_number, @addressID);
		-- entering a new record
		INSERT INTO gyms.person_data (surname, name, e_mail, gender, phone_number, address_id) 
			VALUES (new_surname, new_name, new_e_mail, new_gender, new_phone_number, @addressID);
		-- ID setting
		SET personID = LAST_INSERT_ID();
	END IF;
	-- end of transaction
	COMMIT WORK;
END $$