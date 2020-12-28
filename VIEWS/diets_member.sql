USE gyms;
CREATE OR REPLACE VIEW diets_member
AS
SELECT 
	m.member_id 'member_id',
    p.surname 'member_surname',
    p.name 'member_name',
    d.diet_description 'diet_description',
    d.start_date 'diet_start_date',
    d.end_date 'diet_end_date'
FROM
	gyms.diet d
INNER JOIN gyms.member m ON m.member_id = d.member_id
INNER JOIN gyms.person_data p ON p.person_data_id = m.person_data_id