USE gyms;
DROP TRIGGER IF EXISTS after_set_trainer_to_member;
DELIMITER $$
CREATE TRIGGER after_set_trainer_to_member
after UPDATE
ON gyms.member FOR EACH ROW
BEGIN
	-- for the changes made
	IF (NEW.trainer_id != OLD.trainer_id OR OLD.trainer_id IS NULL) THEN
		IF EXISTS (
				SELECT * FROM gyms.trainer_history th
					WHERE th.trainer_id = OLD.trainer_id
                    AND th.member_id = OLD.member_id
					AND th.end_date IS NULL
				) THEN
			-- add end date
			UPDATE gyms.trainer_history t_h
				SET t_h.end_date = date_format(curdate(), '%Y-%m-%d')
			WHERE t_h.trainer_id = OLD.trainer_id
			AND t_h.member_id = OLD.member_id;
		END IF;
        -- add to story
		INSERT INTO gyms.trainer_history (start_date, trainer_id, member_id) 
			values (date_format(curdate(), '%Y-%m-%d'), NEW.trainer_id, NEW.member_id);
    END IF;
END$$
DELIMITER ;