var video_ID = "iuJDhFRDx9M" // ID de la video Youtube
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
	"name": "AMON 031 MANCOSRP", // Le nom qui va apparête
	"duration": "2:23",
	"file": "AMON-031MANCOSRP" // Le nom du fichier MP3 (Il ne doit pas contenir d'espace ou de caractère spéciaux.
}, {
	"track": 2, // Position dans la liste
	"name": "Niska - Du lundi au lundi", // Le nom qui va apparête
	"duration": "2:42",
	"file": "niska-du-lundi-au-lundi-clip-officiel" // Le nom du fichier MP3 (Il ne doit pas contenir d'espace ou de caractère spéciaux.
}, {
	"track": 3,
	"name": "Rim'K - Air Max ft. Ninho",
	"duration": "3:28",
	"file": "rimk-air-max-ft-ninho"
}, {
	"track": 4,
	"name": "Enzo Salvaggi - 20 ( prod. Call Me G )",
	"duration": "2:55",
	"file": "enzo-salvaggi-20-prod-call-me-g"
}, {
	"track": 5,
	"name": "Enzo Salvaggi - FENDI ( Lyric Video ) ( prod. Rapas )",
	"duration": "2:24",
	"file": "enzo-salvaggi-fendi-lyric-video-prod-rapas"
}]