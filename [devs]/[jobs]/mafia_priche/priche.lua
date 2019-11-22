SET @job_name = 'priche';
SET @society_name = 'society_priche';
SET @job_Name_Caps = 'Priche';



INSERT INTO `addon_account` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1),
  ('society_priche_fridge', 'Priche (frigo)', 1)
;

INSERT INTO `addon_inventory_items` (`id`, `inventory_name`, `name`, `count`, `owner`) VALUES (1354, 'society_yakuza_fridge', 'water', 0, NULL);

INSERT INTO `datastore` (name, label, shared) VALUES 
    (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
  (@job_name, @job_Name_Caps, 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  (@job_name, 0, 'pricheseguridad', 'Seguridad', 150, '{}', '{}'),
  (@job_name, 1, 'prichesicario', 'Sicario', 300, '{}', '{}'),
  (@job_name, 2, 'pricheAdalid', 'Adalid', 450, '{}', '{}'),
  (@job_name, 3, 'viceboss', 'Jefe', 600, '{}', '{}'),
  (@job_name, 4, 'boss', 'Lider', 900, '{}', '{}')
;