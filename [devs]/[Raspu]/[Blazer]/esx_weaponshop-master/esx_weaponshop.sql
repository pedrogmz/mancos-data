USE `essentialmode`;

CREATE TABLE `weashops` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`zone` varchar(255) NOT NULL,
	`item` varchar(255) NOT NULL,
	`price` int(11) NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `licenses` (`type`, `label`) VALUES
	('weapon', "Permis de port d'arme")
;

INSERT INTO `weashops` (`zone`, `item`, `price`) VALUES
	('GunShop','WEAPON_KNIFE', 1000000),
	('GunShop', 'WEAPON_MACHETE', 1000000000),
	('GunShop', 'WEAPON_FIREEXTINGUER', 1000000),
	('GunShop', 'WEAPON_BAT', 1000000),
	
;
weashops