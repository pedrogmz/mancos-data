var video_ID = "UdB4ytHvX8o" // ID de la video Youtube
var mp3_player = true // Si true, le lecteur MP3 sera utilisé et le son de vidéo youtube coupé

var start = 22 // Permets de définir à partir de combien de secondes la vidéo Youtube doit commencer

var img = "Logotipo.png" // Le nom de fichier du logo de votre serveur (* Il doit se situer dans le dossier : Assets/IMG *)

var Discord_link = "https://discord.gg/gXvFDyt" // Lien de vôtre server Discord

var red_text = '' // Texte en rouge
var blue_text = '' // Texte en bleu

// N'oubliez d'ajouter vos musiques dans le __resource.lua
// Placez vos musiques dans le dossier : Assets/AUIDO
var tracks
tracks = [{
	"track": 1, // Position dans la liste
	"name": "Niska - Du lundi au lundi", // Le nom qui va apparête
	"duration": "2:42",
	"file": "niska-du-lundi-au-lundi-clip-officiel" // Le nom du fichier MP3 (Il ne doit pas contenir d'espace ou de caractère spéciaux.
}, {
	"track": 2,
	"name": "Rim'K - Air Max ft. Ninho",
	"duration": "3:28",
	"file": "rimk-air-max-ft-ninho"
}]