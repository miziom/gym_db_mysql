DROP EVENT IF EXISTS BackUpCSV;

delimiter |
CREATE EVENT BackUpCSV
ON SCHEDULE EVERY 24 hour
STARTS (TIMESTAMP(CURRENT_DATE) + INTERVAL 16 HOUR)
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
	-- output path
	SET @out_put_path := 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads'; 
    -- only the first output file is described, because each subsequent one is created the same only for other tables, as can be seen below
    -- creating an output path for the csv file
	SET @full_output_path_ADDRESS := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-ADDRESS.csv');
    -- saving the table to a file
	set @ADDRESS := concat("SELECT * INTO OUTFILE '",@full_output_path_ADDRESS,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.address;");
	-- preparation and execution of the command generated
	prepare ADDRESS_prepere from @ADDRESS;
	execute ADDRESS_prepere;
	deallocate prepare ADDRESS_prepere;
    
	SET @full_output_path_DIET := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-DIET.csv');
	set @DIET := concat("SELECT * INTO OUTFILE '",@full_output_path_DIET,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.diet;");
	prepare DIET_prepere from @DIET;
	execute DIET_prepere;
	deallocate prepare DIET_prepere;
    
	SET @full_output_path_EQUIPMENT := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-EQUIPMENT.csv');
	set @EQUIPMENT := concat("SELECT * INTO OUTFILE '",@full_output_path_EQUIPMENT,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.equipment;");
	prepare EQUIPMENT_prepere from @EQUIPMENT;
	execute EQUIPMENT_prepere;
	deallocate prepare EQUIPMENT_prepere;
    
	SET @full_output_path_EXERCISE := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-EXERCISE.csv');
	set @EXERCISE := concat("SELECT * INTO OUTFILE '",@full_output_path_EXERCISE,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.exercise;");
	prepare EXERCISE_prepere from @EXERCISE;
	execute EXERCISE_prepere;
	deallocate prepare EXERCISE_prepere;
    
	SET @full_output_path_EXERCISE_SET := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-EXERCISE_SET.csv');
	set @EXERCISE_SET := concat("SELECT * INTO OUTFILE '",@full_output_path_EXERCISE_SET,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.exercise_set;");
	prepare EXERCISE_SET_prepere from @EXERCISE_SET;
	execute EXERCISE_SET_prepere;
	deallocate prepare EXERCISE_SET_prepere;
    
	SET @full_output_path_FEES := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-FEES.csv');
	set @FEES := concat("SELECT * INTO OUTFILE '",@full_output_path_FEES,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.fees;");
	prepare FEES_prepere from @FEES;
	execute FEES_prepere;
	deallocate prepare FEES_prepere;
    
	SET @full_output_path_GYM := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-GYM.csv');
	set @GYM := concat("SELECT * INTO OUTFILE '",@full_output_path_GYM,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.gym;");
	prepare GYM_prepere from @GYM;
	execute GYM_prepere;
	deallocate prepare GYM_prepere;
    
	SET @full_output_path_MEMBER := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-MEMBER.csv');
	set @MEMBER := concat("SELECT * INTO OUTFILE '",@full_output_path_MEMBER,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.member;");
	prepare MEMBER_prepere from @MEMBER;
	execute MEMBER_prepere;
	deallocate prepare MEMBER_prepere;
    
	SET @full_output_path_OPENING_INFO := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-OPENING_INFO.csv');
	set @OPENING_INFO := concat("SELECT * INTO OUTFILE '",@full_output_path_OPENING_INFO,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.opening_info;");
	prepare OPENING_INFO_prepere from @OPENING_INFO;
	execute OPENING_INFO_prepere;
	deallocate prepare OPENING_INFO_prepere;
    
	SET @full_output_path_PERSON_DATA := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-PERSON_DATA.csv');
	set @PERSON_DATA := concat("SELECT * INTO OUTFILE '",@full_output_path_PERSON_DATA,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.person_data;");
	prepare PERSON_DATA_prepere from @PERSON_DATA;
	execute PERSON_DATA_prepere;
	deallocate prepare PERSON_DATA_prepere;
    
	SET @full_output_path_SALARY_STATUS := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-SALARY_STATUS.csv');
	set @SALARY_STATUS := concat("SELECT * INTO OUTFILE '",@full_output_path_SALARY_STATUS,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.salary_status;");
	prepare SALARY_STATUS_prepere from @SALARY_STATUS;
	execute SALARY_STATUS_prepere;
	deallocate prepare SALARY_STATUS_prepere;
    
	SET @full_output_path_SCHEDULE := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-SCHEDULE.csv');
	set @SCHEDULE := concat("SELECT * INTO OUTFILE '",@full_output_path_SCHEDULE,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.schedule;");
	prepare SCHEDULE_prepere from @SCHEDULE;
	execute SCHEDULE_prepere;
	deallocate prepare SCHEDULE_prepere;
    
	SET @full_output_path_STAFF := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-STAFF.csv');
	set @STAFF := concat("SELECT * INTO OUTFILE '",@full_output_path_STAFF,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.staff;");
	prepare STAFF_prepere from @STAFF;
	execute STAFF_prepere;
	deallocate prepare STAFF_prepere;
    
	SET @full_output_path_STAFF_GROUP := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-STAFF_GROUP.csv');
	set @STAFF_GROUP := concat("SELECT * INTO OUTFILE '",@full_output_path_STAFF_GROUP,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.staff_group;");
	prepare STAFF_GROUP_prepere from @STAFF_GROUP;
	execute STAFF_GROUP_prepere;
	deallocate prepare STAFF_GROUP_prepere;
    
	SET @full_output_path_TRAINER := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-TRAINER.csv');
	set @TRAINER := concat("SELECT * INTO OUTFILE '",@full_output_path_TRAINER,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.trainer;");
	prepare TRAINER_prepere from @TRAINER;
	execute TRAINER_prepere;
	deallocate prepare TRAINER_prepere;
    
	SET @full_output_path_TRAINER_HAS_GYM := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-TRAINER_HAS_GYM.csv');
	set @TRAINER_HAS_GYM := concat("SELECT * INTO OUTFILE '",@full_output_path_TRAINER_HAS_GYM,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.trainer_has_gym;");
	prepare TRAINER_HAS_GYM_prepere from @TRAINER_HAS_GYM;
	execute TRAINER_HAS_GYM_prepere;
	deallocate prepare TRAINER_HAS_GYM_prepere;
    
	SET @full_output_path_TRAINER_HISTORY := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-TRAINER_HISTORY.csv');
	set @TRAINER_HISTORY := concat("SELECT * INTO OUTFILE '",@full_output_path_TRAINER_HISTORY,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.trainer_history;");
	prepare TRAINER_HISTORY_prepere from @TRAINER_HISTORY;
	execute TRAINER_HISTORY_prepere;
	deallocate prepare TRAINER_HISTORY_prepere;
    
	SET @full_output_path_TRAINING_GROUP := CONCAT(@out_put_path,'/', DATE_FORMAT( NOW(), '%Y-%m-%d#%H-%i'), '-TRAINING_GROUP.csv');
	set @TRAINING_GROUP := concat("SELECT * INTO OUTFILE '",@full_output_path_TRAINING_GROUP,
		"' FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		FROM gyms.training_group;");
	prepare TRAINING_GROUP_prepere from @TRAINING_GROUP;
	execute TRAINING_GROUP_prepere;
	deallocate prepare TRAINING_GROUP_prepere;
    
    -- end of transaction
    COMMIT WORK;
  END |

delimiter ;