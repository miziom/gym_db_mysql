USE gyms;
CREATE OR REPLACE VIEW user_exercise_set
AS
SELECT 
	m.member_id 'member_id',
    p.surname 'member_surname',
    p.name 'member_name',
    t_g.group_name 'group_name',
    e.name 'exercise_name',
    e.description 'exercise_description',
    e.calories 'exercise_calories',
    e.sets 'exercise_sets',
    e.reps 'exercise_reps',
    e.break_time 'exercise_break_time'
FROM
	gyms.exercise_set e_s
INNER JOIN gyms.exercise e ON e.exercise_id = e_s.exercise_id
INNER JOIN gyms.training_group t_g ON t_g.training_group_id = e_s.training_group_id
INNER JOIN gyms.member m ON m.member_id = e_s.member_id
INNER JOIN gyms.person_data p on p.person_data_id = e_s.member_id