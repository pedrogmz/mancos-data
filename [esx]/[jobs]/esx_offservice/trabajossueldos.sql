
INSERT INTO `jobs` (name, label) VALUES
   ('offpolice','Fuera de servicio'),
   ('offambulance','Fuera de servicio'),
    ('offmechanic','Fuera de servicio'),
    ('offtaxi','Fuera de servicio')
  
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES

    ('offpolice',0,'alumn','Alumno',175,'{}','{}'),
    ('offpolice',1,'agent','Agente',175,'{}','{}'),
    ('offpolice',2,'oficial3','Oficial III',225,'{}','{}'),
    ('offpolice',3,'oficial2','Oficial II',250,'{}','{}'),
    ('offpolice',4,'oficial1','Oficial I',250,'{}','{}'),
    ('offpolice',5,'sargento2','Sargento II',250,'{}','{}'),
   
    ('police',6,'sargento1','Sargento I',250,'{}','{}'),
    ('police',7,'teniente','Teniente',250,'{}','{}'),
    ('police',8,'capitan3','Capitan III',250,'{}','{}'),
    ('police',9,'capitan2','Capitan II',250,'{}','{}'),
    ('police',10,'capitan1','Capitan I',250,'{}','{}'),
    ('police',11,'subinspector','Sub Inspector',250,'{}','{}'),
    ('police',12,'inspector','Inspector',250,'{}','{}'),
    ('police',13,'comisario','Comisario',250,'{}','{}'),
    
    ('offambulance',0,'practicas','Prácticas',175,'{}','{}'),
    ('offambulance',1,'paramedico','Paramédico',175,'{}','{}'),
    ('offambulance',2,'medico','Médico',200,'{}','{}'),
    ('offambulance',3,'cirujano','Cirujano',225,'{}','{}'),
    ('offambulance',4,'fisiotera','Fisioterapeuta',225,'{}','{}'),
    ('offambulance',5,'pisco','Psicólogo',225,'{}','{}'),
    ('offambulance',6,'boss','Director del hospital',225,'{}','{}'),    
     
    ('offtaxi',0,'recrue','Alumno',150,'{}','{}'),
    ('offtaxi',1,'novice','Novato',150,'{}','{}'),
    ('offtaxi',2,'experimente','Experimentado',175,'{}','{}'),
    ('offtaxi',3,'uber','Sub-Jefe',200,'{}','{}'),
    ('offtaxi',4,'boss','Jefe de taxistas',225,'{}','{}'),
    ('offmechanic',0,'recrue','Alumno',150,'{}','{}'),
    ('offmechanic',1,'novice','Novato',175,'{}','{}'),
    ('offmechanic',2,'experimente','Experimentado',200,'{}','{}'),
    ('offmechanic',3,'chief','Sub-Jefe',225,'{}','{}'),
    ('offmechanic',4,'boss','Jefe de mecanicos',225,'{}','{}')  

;
