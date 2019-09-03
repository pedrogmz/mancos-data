petrolCanPrice = 25

lang = "en"
-- lang = "fr"

settings = {}
settings["en"] = {
	openMenu = "Pressiona ~g~E~w~ para abrir el menu.",
	electricError = "~r~Tienes un vehiculo electrico.",
	fuelError = "~r~No estas en el buen lugar.",
	buyFuel = "comprar combustible",
	liters = "litros",
	percent = "porcentaje",
	confirm = "Confirmar",
	fuelStation = "Gasolinera",
	boatFuelStation = "Gasolinera De Barcos",
	avionFuelStation = "Gasolinera De Aviones ",
	heliFuelStation = "GasolineraDe Helicopteros",
	getJerryCan = "Pressiona ~g~E~w~ comprar una Bidon de gasolina ("..petrolCanPrice.."$)",
	refeel = "Pressiona ~g~E~w~ repostar el auto.",
	YouHaveBought = "Usted ha comprado ",
	fuel = " litros de combustible",
	price = "precio"
}

settings["fr"] = {
	openMenu = "Appuyez sur ~g~E~w~ pour ouvrir le menu.",
	electricError = "~r~Vous avez une voiture électrique.",
	fuelError = "~r~Vous n'êtes pas au bon endroit.",
	buyFuel = "acheter de l'essence",
	liters = "litres",
	percent = "pourcent",
	confirm = "Valider",
	fuelStation = "Station essence",
	boatFuelStation = "Station d'essence | Bateau",
	avionFuelStation = "Station d'essence | Avions",
	heliFuelStation = "Station d'essence | Hélicoptères",
	getJerryCan = "Appuyez sur ~g~E~w~ pour acheter un bidon d'essence ("..petrolCanPrice.."$)",
	refeel = "Appuyez sur ~g~E~w~ pour remplir votre voiture d'essence.",
	YouHaveBought = "Vous avez acheté ",
	fuel = " litres d'essence",
	price = "prix"
}


showBar = true
showText = true


hud_form = 1 -- 1 : Vertical | 2 = Horizontal
hud_x = 0.184 
hud_y = 0.884

text_x = 0.275
text_y = 0.975


electricityPrice = 1 -- NOT RANOMED !!

randomPrice = true --Random the price of each stations
price = 1 --If random price is on False, set the price here for 1 liter