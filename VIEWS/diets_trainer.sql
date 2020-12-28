USE gyms;
CREATE OR REPLACE VIEW diets_trainer
AS
SELECT 
	t.trainer_id 'trainer_id',
    p.surname 'trainer_surname',
    p.name 'trainer_name',
    d.diet_description 'diet_description',
    d.start_date 'diet_start_date',
    d.end_date 'diet_end_date'
FROM
	gyms.diet d
INNER JOIN gyms.trainer t ON t.trainer_id = d.trainer_id
INNER JOIN gyms.person_data p ON p.person_data_id = t.person_data_id