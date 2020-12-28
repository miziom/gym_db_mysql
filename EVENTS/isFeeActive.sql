DROP EVENT IF EXISTS isFeeActive;

delimiter |
CREATE EVENT isFeeActive
ON SCHEDULE EVERY 24 hour
STARTS (TIMESTAMP(CURRENT_DATE) + INTERVAL 0 HOUR)
DO
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
    -- start of the transaction
    START TRANSACTION;
    -- updating records where the payment end date has passed and the is_active flag equals 1 
		UPDATE gyms.fees f
			SET f.is_active = 0
        WHERE DATE(f.end_date) < CURDATE()
        AND f.is_active <> 0;
	-- end of transaction
    COMMIT WORK;
  END |

delimiter ;