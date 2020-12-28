USE gyms;
CREATE OR REPLACE VIEW gym_info
AS
SELECT
	g.gym_id 'gym_id',
    g.name 'gym_name',
    g.description 'gym_description',
	a.country 'gym_country',
    a.postal_code 'gym_postal_code',
    a.city 'gym_city',
    a.street 'gym_street',
    a.house_number 'gym_house_number',
    a.flat_number 'gym_flat_number',
    o_i.day 'gym_day',
    o_i.open_hour 'gym_open_hour',
    o_i.close_hour 'gym_close_hour',
	eq.treadmill_number 'eq_treadmill_number',
    eq.rowing_machine_number 'eq_rowing_machine_number',
    eq.cross_trainer_number 'eq_cross_trainer_number',
    eq.bike_number 'eq_bike_number',
    eq.stair_mill_number 'eq_stair_mill_number',
    eq.leg_machine_number 'eq_leg_machine_number',
    eq.multi_gym_number 'eq_multi_gym_number',
    eq.dumbbell_set_number 'eq_dumbbell_set_number'
FROM
	gyms.gym g
INNER JOIN gyms.schedule s ON s.gym_id = g.gym_id
INNER JOIN gyms.opening_info o_i ON o_i.opening_info_id = s.opening_info_id
INNER JOIN gyms.equipment eq ON eq.gym_id = g.gym_id
INNER JOIN gyms.address a ON a.address_id = g.address_id