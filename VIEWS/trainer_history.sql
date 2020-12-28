USE gyms;
CREATE OR REPLACE VIEW trainer_and_member_history
AS
SELECT
	m.member_id 'member_id',
    p_m.surname 'member_surname',
    p_m.name 'member_name',
    t.trainer_id 'trainer_id',
    p_t.surname 'trainer_surname',
    p_t.name 'trainer_name',
    h.start_date 'take_care_start_date',
    h.end_date 'take_care_end_date'
FROM
	gyms.trainer_history h
INNER JOIN gyms.member m ON m.member_id = h.member_id
INNER JOIN gyms.person_data p_m ON p_m.person_data_id = m.person_data_id
INNER JOIN gyms.trainer t ON t.trainer_id = h.trainer_id
INNER JOIN gyms.person_data p_t ON p_t.person_data_id = t.person_data_id