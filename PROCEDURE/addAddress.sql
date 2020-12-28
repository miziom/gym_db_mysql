DROP PROCEDURE IF EXISTS addAddress;
DELIMITER $$
CREATE PROCEDURE addAddress(
	-- input arguments
	IN new_country varchar(55),
	IN new_postal_code varchar(12),
	IN new_city varchar(60),
	IN new_street varchar(100),
	IN new_house_number varchar(9),
	IN new_flat_number varchar(45),
    -- output argument
    OUT addressID INT
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
		-- checking if the address with the entered parameters does not exist
		IF NOT EXISTS (SELECT * FROM gyms.address 
						WHERE gyms.address.country = new_country
                        AND gyms.address.postal_code = new_postal_code
                        AND gyms.address.city = new_city
                        AND gyms.address.street = new_street
                        AND gyms.address.house_number = new_house_number
                        AND gyms.address.flat_number = new_flat_number) THEN
			-- starting the transaction
			START TRANSACTION;
            -- insert into the table based on the parameters
			INSERT INTO gyms.address (country, postal_code, city, street, house_number, flat_number) 
						VALUES (new_country, new_postal_code, new_city, new_street, new_house_number, new_flat_number);
			-- setting the ID of the entered address
			SET addressID = LAST_INSERT_ID();
			-- end of transaction
			COMMIT WORK;
		-- the case when such an address exists
		ELSE
        -- setting the ID of the address found
			SELECT gyms.address.address_id INTO addressID FROM gyms.address 
			WHERE gyms.address.country = new_country
				AND gyms.address.postal_code = new_postal_code
				AND gyms.address.city = new_city
				AND gyms.address.street = new_street
				AND gyms.address.house_number = new_house_number
				AND gyms.address.flat_number = new_flat_number;
		END IF;
END $$
