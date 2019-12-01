-- TriggerEvent('esx_policedog:openMenu') to open menu

Config = {
    Job = 'police',
    Command = 'k9', -- set to false if you dont want to have a command
    Model = 1318032802,
    TpDistance = 50.0,
    Sit = {
        dict = 'creatures@Shepherd@amb@world_dog_sitting@base',
        anim = 'base'
    },
    Drugs = {'weed', 'cocaine', 'meth'}, -- add all drugs here for the dog to detect
}

Strings = {
    ['not_police'] = '¡~r~No ~s~eres Policía!',
    ['menu_title'] = 'Perro policía',
    ['take_out_remove'] = 'Guardar perro policía',
    ['deleted_dog'] = 'Perro policía ~r~guardado ~s~',
    ['spawned_dog'] = 'Perro policía ~r~activo~s~',
    ['sit_stand'] = 'Haz al perro sentarse/levantarse',
    ['no_dog'] = "No tienes ningún perro",
    ['dog_dead'] = 'Tu perro está muerto :/',
    ['search_drugs'] = 'Busca a la persona más cercana las drogas',
    ['no_drugs'] = 'No tiene drogas.', 
    ['drugs_found'] = 'Drogas ~r~encontradas ~s~',
    ['dog_too_far'] = '¡El perro está muy lejos!',
    ['attack_closest'] = 'Ataca a la persona más cercana',
    ['toggle_vehicle'] = 'Entrar/Salir del vehículo'
}

-- Restricts the dog to getting into certain vehicles
Config.VehicleRestriction = false
Config.VehiclesList = {
	
}