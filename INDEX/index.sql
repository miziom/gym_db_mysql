-- index for gyms.salary_status
CREATE INDEX index_salary ON gyms.salary_status(salary);

-- indexes for gyms.person_data
CREATE INDEX index_name ON gyms.person_data(name);
CREATE INDEX index_gender ON gyms.person_data(gender);

-- indexes for gyms.trainer_history
CREATE INDEX index_start_date ON gyms.trainer_history(start_date);
CREATE INDEX index_end_date ON gyms.trainer_history(end_date);
CREATE INDEX index_trainer_id_end_date ON gyms.trainer_history(trainer_id, end_date); -- see who was led by the coach
CREATE INDEX index_member_id_end_date ON gyms.trainer_history(member_id, end_date); -- see the trainer stories for the user

-- indexes for gyms.diet
CREATE INDEX index_start_date ON gyms.diet(start_date);
CREATE INDEX index_end_date ON gyms.diet(end_date);
CREATE INDEX index_member_id_end_date ON gyms.diet(member_id, end_date); -- looking for diets for a member that are active (NULL) or that were (not null)

-- indexes for gyms.fees
CREATE INDEX index_start_date ON gyms.fees(start_date);
CREATE INDEX index_end_date ON gyms.fees(end_date);
CREATE INDEX index_is_active_member_id ON gyms.fees(is_active, member_id);
