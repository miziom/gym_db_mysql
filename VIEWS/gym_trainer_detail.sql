USE gyms;
CREATE OR REPLACE VIEW gym_trainer_detail
AS
SELECT 
	g.gym_id 'gym_id',
	p.surname 'trainer_surname',
    p.name 'trainer_name',
    p.gender 'trainer_gender',
    p.phone_number 'trainer_phone',
    a.country 'trainer_country',
    a.postal_code 'trainer_postal_code',
    a.city 'trainer_city',
    a.street 'trainer_street',
    a.house_number 'trainer_house_number',
    a.flat_number 'trainer_flat_number',
    s.salary 'trainer_salary'
FROM 
	gyms.trainer t
INNER JOIN gyms.trainer_has_gym t_has_g ON t_has_g.trainer_id = t.trainer_id 
INNER JOIN gyms.gym g ON g.gym_id = t_has_g.gym_id
INNER JOIN gyms.person_data p ON p.person_data_id = t.person_data_id
INNER JOIN gyms.salary_status s ON s.salary_status_id = t.salary_status_id
INNER JOIN gyms.address a ON a.address_id = p.address_id