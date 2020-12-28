DROP FUNCTION IF EXISTS count_monthly_gym_trainer_cost;
DELIMITER //
CREATE FUNCTION count_monthly_gym_trainer_cost(g_id int, s_id int) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE amountOfTrainer INT;
    DECLARE salaryTrainer INT;
    DECLARE trainerCost INT;
    SELECT COUNT(*) 
		FROM gyms.trainer_has_gym thg 
        INNER JOIN gyms.trainer t ON t.trainer_id = thg.trainer_id
        WHERE thg.gym_id = g_id 
			AND t.salary_status_id = s_id
        INTO amountOfTrainer;
	SELECT MAX(s.salary)
		FROM gyms.gym g 
        INNER JOIN gyms.trainer_has_gym thg ON thg.gym_id = g.gym_id
        INNER JOIN gyms.trainer t ON t.trainer_id = thg.trainer_id
        INNER JOIN gyms.salary_status s ON s.salary_status_id = t.salary_status_id
        WHERE g.gym_id = g_id
			AND s.salary_status_id = s_id
        INTO salaryTrainer;
	SET trainerCost = amountOfTrainer * salaryTrainer;
	RETURN trainerCost;
    END //
DELIMITER ;