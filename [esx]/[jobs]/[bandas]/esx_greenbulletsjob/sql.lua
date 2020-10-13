SET @job_name = 'greenbullets';
SET @society_name = 'society_greenbullets';
SET @society_name_black = 'society_greenbullets_black';
SET @job_Name_Caps = 'Green Bullets';
SET @job_Name_Caps_Black = 'Green Bullets (Black Money)';

INSERT INTO `addon_account` (name, label, shared) VALUES
	(@society_name, @job_Name_Caps, 1),
	(@society_name_black, @job_Name_Caps, 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	(@society_name, @job_Name_Caps, 1),
	('society_greenbullets_fridge', 'Green Bullets (nevera)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	 (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
	(@job_name, @job_Name_Caps, 1)
;

INSERT INTO `items` (`name`, `label`, `limit`) VALUES ('key_greenbullets', 'Llave Green Bullets', '2');

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	(@job_name, 0, 'recruit', 'Pandillero', 300, '{}', '{}'),
	(@job_name, 1, 'employer', 'Teniente', 450, '{}', '{}'),
	(@job_name, 2, 'viceboss', 'Capo', 600, '{}', '{}'),
	(@job_name, 3, 'boss', 'Jefe', 900, '{}', '{}')
;