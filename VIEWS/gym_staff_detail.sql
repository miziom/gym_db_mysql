USE gyms;
CREATE OR REPLACE VIEW gym_staff_detail
AS
SELECT 
	g.gym_id 'gym_id',
	p.surname 'staff_surname',
    p.name 'staff_name',
    p.gender 'staff_gender',
    p.phone_number 'staff_phone',
    a.country 'staff_country',
    a.postal_code 'staff_postal_code',
    a.city 'staff_city',
    a.street 'staff_street',
    a.house_number 'staff_house_number',
    a.flat_number 'staff_flat_number',
	ss.status 'team_group',
    sg.group_name 'staff_group',
    ss.salary 'staff_salary'
FROM 
	gyms.staff s
INNER JOIN gyms.gym g ON g.gym_id = s.gym_id
INNER JOIN gyms.person_data p ON p.person_data_id = s.person_data_id
INNER JOIN gyms.address a ON a.address_id = p.address_id
INNER JOIN gyms.salary_status ss ON ss.salary_status_id = s.salary_status_id
INNER JOIN gyms.staff_group sg ON sg.staff_group_id = s.staff_group_id
