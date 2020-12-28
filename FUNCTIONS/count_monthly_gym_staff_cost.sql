DROP FUNCTION IF EXISTS count_monthly_gym_staff_cost;
DELIMITER //
CREATE FUNCTION count_monthly_gym_staff_cost(g_id int, s_id int) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE amountOfStaff INT;
    DECLARE salaryStaff INT;
    DECLARE staffCost INT;
    SELECT COUNT(*) 
		FROM gyms.staff s 
        WHERE s.gym_id = g_id 
			AND s.salary_status_id = s_id
        INTO amountOfStaff;
	SELECT max(ss.salary)
		FROM gyms.gym g 
        INNER JOIN gyms.staff s ON s.gym_id = g.gym_id
        INNER JOIN gyms.salary_status ss ON ss.salary_status_id = s.salary_status_id
        WHERE g.gym_id = g_id
			AND ss.salary_status_id = s_id
        INTO salaryStaff;
	SET staffCost = amountOfStaff * salaryStaff;
	RETURN staffCost;
    END //
DELIMITER ;