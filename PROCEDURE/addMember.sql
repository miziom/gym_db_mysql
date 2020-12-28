DROP PROCEDURE IF EXISTS addMember;
DELIMITER $$
CREATE PROCEDURE addMember(
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
	IN new_phone_number varchar(15)
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
    -- calling the procedure responsible for adding personal data addPersonData (...)
    CALL addPersonData(new_country, new_postal_code, new_city, new_street, new_house_number, new_flat_number, new_surname, new_name, new_e_mail, new_gender, new_phone_number, @personID);
    -- HOW ALREADY IS A MEMBER WITH SUCH PERSONAL DATA - ROLLBACK
    IF EXISTS (SELECT * FROM gyms.member m
				WHERE m.person_data_id = @personID
			) THEN
		ROLLBACK;
	-- WHAT'S NO - ADD MEMBER
	ELSE 
		INSERT INTO gyms.member (trainer_id, gym_id, person_data_id) 
			values (null, null, @personID);
    END IF;
	-- end of transaction
	COMMIT WORK;
END $$