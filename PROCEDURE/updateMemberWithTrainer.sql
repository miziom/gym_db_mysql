DROP PROCEDURE IF EXISTS updateMemberWithTrainer;
DELIMITER $$
CREATE PROCEDURE updateMemberWithTrainer(
	-- input arguments
	IN new_member_id INT,
	IN new_trainer_id INT,
	IN new_gym_id INT
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
    -- if member doesn't exist - rollback
    IF NOT EXISTS (
				SELECT * FROM gyms.member m
					WHERE m.member_id = new_member_id
				) THEN
		rollback;
	END IF;
    
    -- HOW A TRAINER DOESN'T EXIST - ROLLBACK
    IF NOT EXISTS (SELECT * FROM gyms.trainer t
					WHERE t.trainer_id = new_trainer_id
				) THEN
		ROLLBACK;
	ELSE 
		-- WHEN DO NOT WORKS ON THIS GYM - ROLLBACK
		IF NOT EXISTS (
						SELECT * FROM gyms.trainer t
							INNER JOIN gyms.trainer_has_gym thg ON thg.trainer_id = t.trainer_id
							INNER JOIN gyms.gym g ON thg.gym_id = g.gym_id
								WHERE t.trainer_id = new_trainer_id 
								AND g.gym_id = new_gym_id
					) THEN
			ROLLBACK;
		ELSE
        -- row update
			UPDATE gyms.member m
			SET m.trainer_id = new_trainer_id,
				m.gym_id = new_gym_id
			WHERE member_id = new_member_id;
        END IF;
    END IF;
	-- end of transaction
	COMMIT WORK;
END $$
