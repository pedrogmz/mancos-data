UPDATE `jobs` SET `name`= 'offpolice',`label`='Fuera de servicio',`whitelisted`= 0 WHERE name = 'offpolice'
UPDATE `jobs` SET `name`= 'offambulance',`label`='Fuera de servicio',`whitelisted`= 0 WHERE name = 'offambulance'
UPDATE `jobs` SET `name`= 'offmechanic',`label`='Fuera de servicio',`whitelisted`= 0 WHERE name = 'offmechanic'
UPDATE `jobs` SET `name`= 'offtaxi',`label`='Fuera de servicio',`whitelisted`= 0 WHERE name = 'offtaxi'

-- Policia
UPDATE `job_grades` SET `job_name`= 'offpolice',`grade`=0,`name`='recruit',`label`='Alumno',`salary`= 175 WHERE id = 44
UPDATE `job_grades` SET `job_name`= 'offpolice',`grade`=1,`name`='officer',`label`='Oficial',`salary`= 175 WHERE id = 45
UPDATE `job_grades` SET `job_name`= 'offpolice',`grade`=2,`name`='sergeant',`label`='Sargento',`salary`= 200 WHERE id = 46
UPDATE `job_grades` SET `job_name`= 'offpolice',`grade`=3,`name`='lieutenant',`label`='Teniente',`salary`= 225 WHERE id = 47
UPDATE `job_grades` SET `job_name`= 'offpolice',`grade`=4,`name`='boss',`label`='Jefe de la policia',`salary`= 250 WHERE id = 48

-- EMS
UPDATE `job_grades` SET `job_name`= 'offambulance',`grade`=0,`name`='ambulance',`label`='Practicas',`salary`= 175 WHERE id = 49
UPDATE `job_grades` SET `job_name`= 'offambulance',`grade`=1,`name`='doctor',`label`='Paramedico',`salary`= 175 WHERE id = 50
UPDATE `job_grades` SET `job_name`= 'offambulance',`grade`=2,`name`='chief_doctor',`label`='Medico',`salary`= 200 WHERE id = 51
UPDATE `job_grades` SET `job_name`= 'offambulance',`grade`=3,`name`='boss',`label`='Doctor',`salary`= 225 WHERE id = 52
UPDATE `job_grades` SET `job_name`= 'offambulance',`grade`=4,`name`='bossh',`label`='Jefe del hospital',`salary`= 250 WHERE id = 53

-- Mecanicos
UPDATE `job_grades` SET `job_name`= 'offmechanic',`grade`=0,`name`='recrue',`label`='Alumno',`salary`= 150 WHERE id = 59
UPDATE `job_grades` SET `job_name`= 'offmechanic',`grade`=1,`name`='novice',`label`='Novato',`salary`= 150 WHERE id = 60
UPDATE `job_grades` SET `job_name`= 'offmechanic',`grade`=2,`name`='experimente',`label`='Experimentado',`salary`= 175 WHERE id = 61
UPDATE `job_grades` SET `job_name`= 'offmechanic',`grade`=3,`name`='chief',`label`='Sub-Jefe',`salary`= 200 WHERE id = 62
UPDATE `job_grades` SET `job_name`= 'offmechanic',`grade`=4,`name`='boss',`label`='Jefe de mecanicos',`salary`= 225 WHERE id = 63

-- Taxis
UPDATE `job_grades` SET `job_name`= 'offtaxi',`grade`=0,`name`='recrue',`label`='Alumno',`salary`= 150 WHERE id = 54
UPDATE `job_grades` SET `job_name`= 'offtaxi',`grade`=1,`name`='novice',`label`='Novato',`salary`= 150 WHERE id = 55
UPDATE `job_grades` SET `job_name`= 'offtaxi',`grade`=2,`name`='experimente',`label`='Experimentado',`salary`= 175 WHERE id = 56
UPDATE `job_grades` SET `job_name`= 'offtaxi',`grade`=3,`name`='uber',`label`='Sub-Jefe',`salary`= 200 WHERE id = 57
UPDATE `job_grades` SET `job_name`= 'offtaxi',`grade`=4,`name`='boss',`label`='Jefe de taxistas',`salary`= 225 WHERE id = 58

