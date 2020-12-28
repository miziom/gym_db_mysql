USE gyms;
CREATE OR REPLACE VIEW fees_info
AS
SELECT 
	m.member_id 'member_id',
	p_m.surname 'member_surname',
    p_m.name 'member_name',
    f.start_date 'fee_start_date',
    f.end_date 'fee_end_date',
    f.type 'fee_type',
    f.amount 'fee_value',
    f.currency 'fee_currency',
    f.is_active 'fee_is_active'
FROM
	gyms.member m
INNER JOIN gyms.fees f ON f.member_id = m.member_id
INNER JOIN gyms.person_data p_m ON p_m.person_data_id = m.person_data_id


