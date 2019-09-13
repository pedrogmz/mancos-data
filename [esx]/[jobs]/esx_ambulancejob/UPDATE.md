 --
 Actualizar el inventory, las imagenes.
 --
 Actualizacion medicos;
 
 Crear comida para medicos, los que seran dados gratuitamente como normal general.
 --Hospital nuevo ( con Camillas ).
 --Dispensador de Comida 
 --Taquillas ( Guardar las cosas ).
 --Poder cerrar puertas para operación ( Como las puertas de los policias ).
 --Mas tiempo de reaparición o 4 o 5 minutos, si le das a la E una vez hayan pasado esos minutos que lo pierdas todo )
 --Traje EMS ( Traje ya predefinido y que dependiendo del color del traje de EMS tengas un rango, ya estan las fotos para la combinación que hay que llevar en #normativa_interna ).
 -------------------------------------------
 Faltan rangos nuevos;
 -------------------------------------------
SET @job_name = 'ambulance';

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  (@job_name, 0, 'practicas', 'Practicas', 150, '{}', '{}'),
  (@job_name, 1, 'paramedico', 'Paramedico', 300, '{}', '{}'),
  (@job_name, 2, 'medico', 'Medico', 450, '{}', '{}'),
  (@job_name, 3, 'cirujano', 'Cirujano', 600, '{}', '{}'),
  (@job_name, 4, 'psicologo', 'Psicologo', 600, '{}', '{}'),
  (@job_name, 5, 'viceboss', 'Jefe de Cirugia', 600, '{}', '{}'),
  (@job_name, 6, 'boss', 'Director del Hospital', 900, '{}', '{}')
;
 -------------------------------------------
Practicas 
Paramedico
Medico
Cirujano
Psicologo
Jefe de Cirugia
Director de Hospital
--------------------------------------------
Revisar el sistema del hospital y configurar las camas y el resto del funcionamiento.
 ---------------------------
 Añadir en items, mysql
 INSERT INTO `items` (name, label, `limit`) VALUES
 	('medagua','Agua pequeña', 10),
	('medbocata','Bocata pequeño', 10),
	('gauze','Gasa', 10),
	('bandage','Vendaje', 10),
	('firstaid','Primeros Auxilios', 10),
	('medkit','Medkit', 5),
	('vicodin','Vicodin', 5),
	('hydrocodone','Hydrocodone', 5),
	('morphine','Morfina', 5)
;
 ---------------------------
 Uso de objetos;
gauze = si el sujeto sangra, -1 de sangrado al usarlo.
bandage = cura a si mismo un X% de vida formula:(vidaactual+vidamaximad / 16)
firstaid = mismo sistema que en bandage, pero divide entre 8
medkit = quita el daño en el personaje (comprobar si lo tiene que usar en otra persona)
vicodin = el personaje tendra menos probabilidad de desmayarse de dolores
hydrocodone = doble efecto que vicodin 
morphine = la droga farmaceutica mas fuerte para ignorar dolores (no se cura el personaje)
 ---------------------------
 -- añadir en basicneeds;
 ---------------------------
 ESX.RegisterUsableItem('medbocata', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('medbocata', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_medbocata'))
end)

ESX.RegisterUsableItem('medagua', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('medagua', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 50000)
	TriggerClientEvent('esx_status:add', source, 'hunger', 10000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_medagua'))
end)

------------------------
Skins
------------------------
Paremdico y practicas mujer EMS
{"sex":1,"tshirt_1":159,"tshirt_2":0,"torso_1":258,"torso_2":1,"chain_1":96,"chain_2":0,"decals_2":0,"decals_1":66,"arms":160,"arms_2":0,"pants_1":23,"pants_2":10,"shoes_2":0,"shoes_1":57}
Medico y cirujano mujer EMS
{"sex":1,"tshirt_1":159,"tshirt_2":0,"torso_1":258,"torso_2":0,"chain_1":96,"chain_2":0,"decals_2":1,"decals_1":66,"arms":160,"arms_2":0,"pants_1":23,"pants_2":0,"shoes_2":0,"shoes_1":57}


Paramedico y practicas Hombres
{"skin":0,"tshirt_1":129,"tshirt_2":0,"torso_1":250,"torso_2":1,"chain_1":126,"chain_2":0,"decals_2":1,"decals_1":58,"arms":85,"arms_2":0,"pants_1":24,"pants_2":3,"shoes_2":1,"shoes_1":66}
Medico y cirujano Hombres
{"skin":0,"tshirt_1":129,"tshirt_2":0,"torso_1":250,"torso_2":0,"chain_1":126,"chain_2":0,"decals_2":0,"decals_1":58,"arms":85,"arms_2":0,"pants_1":24,"pants_2":5,"shoes_2":1,"shoes_1":66}
Jefe cirujano y psicologo HOmbre
{"skin":0,"tshirt_1":15,"tshirt_2":0,"torso_1":13,"torso_2":2,"chain_1":126,"chain_2":0,"decals_2":0,"decals_1":57,"arms":92,"arms_2":0,"pants_1":24,"pants_2":5,"shoes_2":1,"shoes_1":66}
JEFE Hospital
{"skin":0,"tshirt_1":15,"tshirt_2":0,"torso_1":13,"torso_2":0,"chain_1":126,"chain_2":0,"decals_2":0,"decals_1":57,"arms":92,"arms_2":0,"pants_1":24,"pants_2":0,"shoes_2":1,"shoes_1":66}