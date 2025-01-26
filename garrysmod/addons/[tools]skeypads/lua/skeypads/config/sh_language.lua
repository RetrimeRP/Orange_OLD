
local languages = {}

languages["english"] = { --English (Default)
    systemName = "Superior Keypads",


    --Toolgun Strings
    toolgunName = "Keypad Placer",
    toolgunDescription = "Spawn and set up your own keypad",
    toolgunSelectFadingDoor = "Select target entity",
    toolgunPlaceKeypad = "Place the keypad where you are looking",
    toolgunDeleteKeypad = "Delete a keypad",
    toolgunCancelPlacement = "Cancel Placement",
    toolgunUpdateSettings = "Update a keypad's settings",
    toolgunAddFadingDoor = "Add a fading door",
    toolgunRemoveFadingDoor = "Remove a fading door",
    toolgunCancelEdit = "Exit fading door editor",
    toolgunDontOwnDoor = "You don't own this door.",


    --Toolgun Menu Strings
    menuOutputType = "Output Type:",
    menuTypeFadingDoor = "Fading Door",
    menuTypeDoor = "Map Door",
    menuTypeKeybind = "Keybind",
    menuTypeWiremod = "Wiremod",
    menuSuccessKey = "Success Key",
    menuFailKey = "Fail Key",
    menuAutoLock = "Auto Lock:",
    menuWireOutputOn = "Output On:",
    menuWireOutputOff = "Output Off:",
    menuAutoLockHint = "Automatically locks/unlocks the door on trigger.",
    menuMapDoorHint = "Click on a door you own to select it as a keypad output.",
    menuPassword = "Password:",
    menuPasswordHint = "4 digit maximum, numerical passwords only.",
    menuSecureMode = "Enable Secure Mode:",
    menuSecureModeHint = "Hides the password when you type it.",
    menuFadeMaterial = "Fade Material:",
    menuFadeMaterialHint = "The material to make your fading door turn into when faded.",
    menuFadeTime = "Output Time:",
    menuFadeTimeHint = "How long the output should stay activated.",
    menuPriceToEntry = "Price to enter:",
    menuPriceToEntryCurrency = "£",
    menuPaidEntry = "Paid Entry:",
    --Keypad Strings
    keypadClear = "CLR",
    keypadEnter = "ENTER",


    --Keypad Cracker Strings
    crackerScreenHint = "Click on a keypad\nto crack it",
    crackerDescription = "Click on a keypad a wait to crack it",
    crackerCrackingMessage = "Cracking Keypad...",


    --Keypad Checker Strings
    checkerName = "Keypad Checker",
    checkerDescription = "Click on a keypad to see info about it and it's connected fading door.",
    checkerHint = "Left Click on a keypad to see info about it and it's connected fading door.\nRight Click to deselect.",
    checkerShowData = "Keypad Type: %t\nProtected: %p\nOwner: %o",


    --Friends Menu Strings
    friendsMenuName = "Keypad Friends",
    friendsMenuTopHint = "The friends you set here will be able to use the fingerprint scanner on your keypads.\nThese will save across different servers and restarts.",
    friendsListTitle = "Your friends:",
    friendsPlayerSteamID = "SteamID64",
    friendsPlayerName = "Name",
    friendsRemove = "Remove Friend",
    friendsAddSteamID = "Add SteamID64",
    friendsAddOnlinePlayer = "Add online player:",
    friendsNoPlayersAvail = "[No available players]",
    friendsTooMany = "You have too many friends, truncating!",
    friendsAddTitle = "Add a friend",
    friendsAddInputString = "Enter the SteamID64 of the friend you want to add:",
    friendsAddButton = "Add",
    friendsAddCancelButton = "Cancel",
    friendsRefresh = "Refresh",


    --Cleanup Strings
    keypadUndone = "Undone Superior Keypad",
    keypadCleanupName = "Superior Keypads",
    keypadCleanedUp = "Cleaned up all Superior Keypads",
    keypadReachedLimit = "You've reached the Superior Keypads limit!",
    keypadReachedPersonalLimit = "You've reached your personal Superior Keypads limit!",
    keypadReachedMaxFadingDoors = "You've reached the maximum amount of fading doors for this keypad."
}

languages["dutch"] = { --Dutch translation by Zeo (https://www.gmodstore.com/users/zeo)
    systemName = "sKeypads",


    --Toolgun Strings
    toolgunName = "Keypad Plaatser",
    toolgunDescription = "Plaats en stel je eigen keypad in.",
    toolgunSelectFadingDoor = "Selecteer een prop om het in een fading door te veranderen",
    toolgunPlaceKeypad = "Plaats een keypad waar je kijkt",
    toolgunDeleteKeypad = "Haal een keypad weg",
    toolgunCancelPlacement = "Annuleer plaatsing",
    toolgunUpdateSettings = "Werk de instellingen van de keypad bij",


    --Toolgun Menu Strings
    menuPassword = "Wachtwoord:",
    menuPasswordHint = "4 cijfers maximaal, alleen numerieke wachtwoorden.",
    menuSecureMode = "Veiligheidsmodus:",
    menuSecureModeHint = "Verberg het wachtwoord tijdens het intypen",
    menuFadeMaterial = "Fading door materiaal:",
    menuFadeMaterialHint = "Het materiaal waarin je fading door verandert wanneer vervaagd.",
    menuFadeTime = "Vervaag tijd:",
    menuFadeTimeHint = "Hoelang de fading door open blijft.",


    --Keypad Cracker Strings
    crackerDescription = "Klik op een keypad en wacht om het te hacken.",
    crackerCrackingMessage = "Hacking keypad...",


    --Keypad Checker Strings
    checkerName = "sKeypad Checker",
    checkerDescription = "Klik op een keypad om informatie over het te zien en om te zien aan welke fading door het verbonden is.",
    checkerHint = "Linker muisknop om informatie over het te zien en om te zien aan welke fading door het verbonden is.\n Rechter muisknop om te deselecteren.",
    checkerShowData = "Keypad Type: %t\nBeschermd: %p\nEigenaar: %o",


    --Friends Menu Strings
    friendsMenuName = "Keypad Vrienden",
    friendsMenuTopHint = "De vrienden die je hier selecteerd zijn in staat de vingerprint scanner te gebruiken op je keypads.\nDit slaat op over alle servers en restarts.",
    friendsListTitle = "Je vrienden:",
    friendsPlayerSteamID = "SteamID64",
    friendsPlayerName = "Naam",
    friendsRemove = "Verwijder Friend",
    friendsAddSteamID = "Voeg SteamID64 toe",
    friendsAddOnlinePlayer = "Voeg online spelers toe:",
    friendsNoPlayersAvail = "[Geen spelers beschikbaar]",
    friendsTooMany = "Je hebt te veel vrienden, afkappen!",
    friendsAddTitle = "Voeg een vriend toe",
    friendsAddInputString = "Voer het SteamID64 van de vriend die je wil toevoegen in:",
    friendsAddButton = "Voeg toe",
    friendsAddCancelButton = "Annuleer",
    friendsRefresh = "Vernieuw",


    --Cleanup Strings
    keypadUndone = "sKeypad ongedaan gemaakt",
    keypadCleanupName = "sKeypads",
    keypadCleanedUp = "Alle keypads zijn verwijdered!",
    keypadReachedLimit = "Je hebt je sKeypad limiet bereikt!",
    keypadReachedPersonalLimit = "Je hebt je persoonlijke sKeypad limiet bereikt!"
}

languages["german"] = { --German translation by Aevoa (https://www.gmodstore.com/users/76561198120882898), JustPlayer (https://www.gmodstore.com/users/76561198118140425) and Retr0 (https://www.gmodstore.com/users/76561198198262662)
    systemName = "Superior Keypads",


    --Toolgun Strings
    toolgunName = "Keypad Platzierer",
    toolgunDescription = "Spawne und richte deine eigenes Keypad ein",
    toolgunSelectFadingDoor = "Wähle ein Prop aus, welches eine Fading Door werden soll",
    toolgunPlaceKeypad = "Platziere das Keypad dort, wo du hinschaust",
    toolgunDeleteKeypad = "Keypad Löschen",
    toolgunCancelPlacement = "Platzierung abbrechen",
    toolgunUpdateSettings = "Keypad Einstellungen Updaten",
    toolgunAddFadingDoor = "Füge eine Fading Door hinzu",
    toolgunRemoveFadingDoor = "Entferne eine Fading Door",
    toolgunCancelEdit = "Verlasse den Fading Door Editor",
    toolgunDontOwnDoor = "Dir gehört diese Tür nicht.",


    --Toolgun Menu Strings
    menuOutputType = "Ausgangs Typ:",
    menuTypeFadingDoor = "Fading Door",
    menuTypeDoor = "Map Door",
    menuTypeKeybind = "Keybind",
    menuTypeWiremod = "Wiremod",
    menuSuccessKey = "Erfolgs Taste",
    menuFailKey = "Fehlgeschlagen Taste",
    menuAutoLock = "Automatische Sperre:",
    menuWireOutputOn = "Ausgangs An:",
    menuWireOutputOff = "Ausgangs Aus:",
    menuAutoLockHint = "Sperrt/Entsperrt die Tür automatisch bei Auslösung.",
    menuMapDoorHint = "Klick auf eine Tür, die du besitzt, um sie als Keypad-Output auszuwählen.",
    menuPassword = "Passwort:",
    menuPasswordHint = "4 Zeichen maximal, nur Zahlen erlaubt.",
    menuSecureMode = "Sicherheitsmodus einschalten:",
    menuSecureModeHint = "Versteckt das Passwort beim eingeben.",
    menuFadeMaterial = "Fadeing Material:",
    menuFadeMaterialHint = "Das Material, welches die tür beim Öffnen annimmt.",
    menuFadeTime = "Fade Zeit:",
    menuFadeTimeHint = "Die Zeit über die die Tür offen bleibt.",


    --Keypad Strings
    keypadClear = "CLR",
    keypadEnter = "ENTER",


    --Keypad Cracker Strings
    crackerScreenHint = "Klicke auf ein keypad\nto um es zu knacken",
    crackerDescription = "Klicke auf ein Keypad um es zu knacken",
    crackerCrackingMessage = "Hacking Keypad...",


    --Keypad Checker Strings
    checkerName = "Keypad Checker",
    checkerDescription = "Klicke auf ein Keypad um informationen über es zu erhalten und die Verbundene Tür anzuzeigen.",
    checkerHint = "Linksklick auf ein Keypad um Informationen und die Verbundene Tür anzuzeigen.\nRechtsklick um Abzuwählen.",
    checkerShowData = "Keypad Typ: %t\nGeschützt: %p\nBesitzer: %o",


    --Friends Menu Strings
    friendsMenuName = "Keypad Freunde",
    friendsMenuTopHint = "Freunde die du hier einträgst werden den Fingerabdruck auf dem Keypad benutzen können.\nDies speichert über Server restarts und wird auf anderen Servern übernommen.",
    friendsListTitle = "Deine Freunde:",
    friendsPlayerSteamID = "SteamID64",
    friendsPlayerName = "Name",
    friendsRemove = "Freund Entfernen",
    friendsAddSteamID = "SteamID64 hinzufügen",
    friendsAddOnlinePlayer = "Online Spieler hinzufügen:",
    friendsNoPlayersAvail = "[Keine Spieler verfügbar]",
    friendsTooMany = "Du hast zu viele Freunde!",
    friendsAddTitle = "Freund hinzufügen",
    friendsAddInputString = "Trage eine SteamID64 eines Freundes ein, welchen du hinzufügen möchtest:",
    friendsAddButton = "Hinzufügen",
    friendsAddCancelButton = "Abbrechen",
    friendsRefresh = "Aktualisieren",


    --Cleanup Strings
    keypadUndone = "Keypad Rückgängig gemacht",
    keypadCleanupName = "Superior Keypads",
    keypadCleanedUp = "Alle Superior Keypads entfernt",
    keypadReachedLimit = "Du hast das Superior Keypad limit erreicht!",
    keypadReachedPersonalLimit = "Du hast dein Perönliches Superior Keypad limit erreicht!",
    keypadReachedMaxFadingDoors = "Du hast die maximale Anzahl für fading doors an diesem Keypad erreicht."
}

languages["french"] = { --French translation by Azlok (https://www.gmodstore.com/users/azlok)
    systemName = "sKeypads",


    --Filières de pistolet à outils
    toolgunName = "Keypad Placer",
    toolgunDescription = "Créer et configurer votre propre keypad",
    toolgunSelectFadingDoor = "Sélectionner un accessoire pour se transformer en fading door",
    toolgunPlaceKeypad = "Placez le keypad là où vous regardez",
    toolgunDeleteKeypad = "Supprimer un keypad",
    toolgunCancelPlacement = "Annuler le placement",
    toolgunUpdateSettings = "Mettre à jour les paramètres d'un keypad",


    --Les chaînes de menu du pistolet à outils
    menuPassword = "Mot de passe :",
    menuPasswordHint = "4 chiffres maximum, mots de passe numériques uniquement",
    menuSecureMode = "Activer le mode sécurisé :",
    menuSecureModeHint = "Cache le mot de passe lorsque vous le tapez",
    menuFadeMaterial = "Fade Material :",
    menuFadeMaterialHint = "Le matériau dans lequel votre porte se décolore se transforme lorsqu'elle est décolorée",
    menuFadeTime = "Fade Time :",
    menuFadeTimeHint = "Le temps de garder votre porte ouverte",


    --Cordes de craquage du clavier
    crackerDescription = "Cliquer sur un keypad et attendre pour le piratage",
    crackerCrackingMessage = "Piratage du keypad...",


    --Cordes de vérification du clavier
    checkerName = "sKeypad Checker",
    checkerDescription = "Cliquer sur un keypad pour voir les informations le concernant et voir s'il est connecté à une fading door",
    checkerHint = "Cliquez à gauche sur un keypad pour voir les informations le concernant et s'il est connecté à une fading door.\nCliquez à droite pour désélectionner",
    checkerShowData = "Type de keypad : %t\nProtégé : %p\nPropriétaire : %o",



    --Chaînes de menu des amis
    friendsMenuName = "Amis du keypad",
    friendsMenuTopHint = "Les amis que vous avez définis ici pourront utiliser le scanner d'empreintes digitales de vos keypad. Ils pourront enregistrer sur différents serveurs et redémarrer.",
    friendsListTitle = "Vos amis:",
    friendsPlayerSteamID = "SteamID64",
    friendsPlayerName = "Nom",
    friendsRemove = "Supprimer un ami",
    friendsAddSteamID = "Ajouter SteamID64",
    friendsAddOnlinePlayer = "Ajouter un joueur en ligne:",
    friendsNoPlayersAvail = "[Pas de joueurs disponibles]",
    friendsTooMany = "Vous avez trop d'amis, vous tronquez!",
    friendsAddTitle = "Ajouter un ami",
    friendsAddInputString = "Entrez le SteamID64 de l'ami que vous voulez ajouter:",
    friendsAddButton = "Ajouter",
    friendsAddCancelButton = "Annuler",
    friendsRefresh = "Rafraîchir",


    --Filières de nettoyage
    keypadUndone = "Undone sKeypad",
    keypadCleanupName = "sKeypads",
    keypadCleanedUp = "Supprimer tous les keypad",
    keypadReachedLimit = "Vous avez atteint la limite du sKeypad!",
    keypadReachedPersonalLimit = "Vous avez atteint votre limite personnelle sKeypad!"
}

languages["turkish"] = { --Turkish translation by POWER (https://www.gmodstore.com/users/76561198356384264)
    systemName = "sKeypads",


    --Toolgun Strings
    toolgunName = "Klavye yerleştirici",
    toolgunDescription = "Kendi tuş takımınızı oluşturun ve ayarlayın",
    toolgunSelectFadingDoor = "Fading Door'a dönüşecek bir destek seçin",
    toolgunPlaceKeypad = "Klavye baktığınız yere yerleştirin",
    toolgunDeleteKeypad = "Klavyeyi siliniz",
    toolgunCancelPlacement = "Yerleşimi İptal Et",
    toolgunUpdateSettings = "Klavye ayarlarını güncelleme",


    --Toolgun Menu Strings
    menuPassword = "Şifre:",
    menuPasswordHint = "Maksimum 4 haneli, yalnızca sayısal şifreler.",
    menuSecureMode = "Güvenli Modu Etkinleştir:",
    menuSecureModeHint = "Şifreyi yazarken gizler.",
    menuFadeMaterial = "Fade Malzeme:",
    menuFadeMaterialHint = "Fading Dooru soluk hale getirecek malzeme.",
    menuFadeTime = "Fade Zamanı:",
    menuFadeTimeHint = "Fading Dooru açık tutma zamanı.",


    --Keypad Cracker Strings
    crackerDescription = "Klavyeye tıklayıp cracklenmesini bekleyin",
    crackerCrackingMessage = "Klavye crackleniyor...",


    --Keypad Checker Strings
    checkerName = "sKeypad Denetleyicisi",
    checkerDescription = "Click on a keypad to see info about it and it's connected fading door.",
    checkerHint = "Sol tuşuna tıklayınız Klavyedeki ile ilgili bilgileri görmek için  ve Fading door için.\nSeçimi kaldırmak için Sağ Tıklayın.",
    checkerShowData = "Klavye tipi: %t\nProtected: %p\nOwner: %o",


    --Friends Menu Strings
    friendsMenuName = "Klavye Arkadaşları",
    friendsMenuTopHint = "Burada ayarladığınız arkadaşlar, Klavyedeki parmak izi tarayıcısını kullanabilecektir. \n Bu, farklı sunucular arasında tasarruf sağlayacak ve yeniden başlayacak.",
    friendsListTitle = "Arkadaşların:",
    friendsPlayerSteamID = "SteamID64",
    friendsPlayerName = "İsim",
    friendsRemove = "Arkadaşı Kaldır",
    friendsAddSteamID = "SteamID64 ekle",
    friendsAddOnlinePlayer = "Çevrimiçi oyuncu ekle:",
    friendsNoPlayersAvail = "[Kullanılabilir oyuncu yok]",
    friendsTooMany = "Çok fazla arkadaşın var, ekleyemezsin!",
    friendsAddTitle = "Arkadaş ekleyin!",
    friendsAddInputString = "Eklemek istediğiniz arkadaşınızın SteamID64 kodunu girin:",
    friendsAddButton = "Ekle",
    friendsAddCancelButton = "İptal et",
    friendsRefresh = "Yenile",


    --Cleanup Strings
    keypadUndone = "Yapılmamış sKeypad",
    keypadCleanupName = "sKeypadleri",
    keypadCleanedUp = "sKeypadleri temizle",
    keypadReachedLimit = "sKeypadlerin sınırına ulaştınız!",
    keypadReachedPersonalLimit = "Kişisel sKeypad sınırına ulaştınız!"
}

languages["russian"] = { --Russian translation by LOyoujoLI (https://www.gmodstore.com/users/LOyoujoLI)
    systemName = "sKeypads",


    --Toolgun Strings
    toolgunName = "Установка кейпада",
    toolgunDescription = "Спавнит и устанавливает ваш кейпад",
    toolgunSelectFadingDoor = "Выберите проп, чтобы он был прозрачным",
    toolgunPlaceKeypad = "Поместить кейпад туда, куда вы смотрите",
    toolgunDeleteKeypad = "Удалить кейпад",
    toolgunCancelPlacement = "Отмена установки",
    toolgunUpdateSettings = "Обновить настройки",


    --Toolgun Menu Strings
    menuPassword = "Код:",
    menuPasswordHint = "4 значный код. Используйте только цифры!",
    menuSecureMode = "Включить защищённый режим:",
    menuSecureModeHint = "Скрывает ваш код.",
    menuFadeMaterial = "Материал:",
    menuFadeMaterialHint = "Используется, когда проп становится прозрачным.",
    menuFadeTime = "Таймер:",
    menuFadeTimeHint = "Сколько держать пропы прозрачными?",


    --Keypad Cracker Strings
    crackerDescription = "Наведитесь на кейпад и нажмите ЛКМ, чтобы его взломать",
    crackerCrackingMessage = "Взламываю кейпад...",


    --Keypad Checker Strings
    checkerName = "sKeypad Checker",
    checkerDescription = "Наведитесь на кейпад чтобы узнать информацию о подключённых пропах.",
    checkerHint = "ЛКМ, чтобы узнать информацию об подключённых пропах\nПКМ для отмены.",
    checkerShowData = "Тип кейпада: %t\nЗащищён: %p\nВладелец: %o",


    --Friends Menu Strings
    friendsMenuName = "Друзья",
    friendsMenuTopHint = "Друзья смогут проходить с помощью сканнера отпечатка пальца.\nЭто сохраняется на всех серверах.",
    friendsListTitle = "Ваши друзья:",
    friendsPlayerSteamID = "SteamID64",
    friendsPlayerName = "Имя",
    friendsRemove = "Удалить друга",
    friendsAddSteamID = "Доб. SteamID64" or "Добавить SteamID64",
    friendsAddOnlinePlayer = "Добавить игрока в сети:",
    friendsNoPlayersAvail = "[Нет доступных игроков]",
    friendsTooMany = "У вам много друзей!",
    friendsAddTitle = "Добавить друга",
    friendsAddInputString = "Введите SteamID64 друга которого вы хотите добавить:",
    friendsAddButton = "Доб." or "Добавить",
    friendsAddCancelButton = "Отмена",
    friendsRefresh = "Обновить",


    --Cleanup Strings
    keypadUndone = "Удалён sKeypad",
    keypadCleanupName = "sKeypads",
    keypadCleanedUp = "Удалить все sKeypad",
    keypadReachedLimit = "Вы достигли лимита по кейпадам!",
    keypadReachedPersonalLimit = "Вы достигли персонального лимита по кейпадам!"
}

languages["ukraine"] = {
    systemName = "sKeypads",



    --Toolgun Strings
    toolgunName = "Keypad Placer",
    toolgunDescription = "Spawn and set up your own keypad",
    toolgunSelectFadingDoor = "Select a prop to turn into a fading door",
    toolgunPlaceKeypad = "Place the keypad where you are looking",
    toolgunDeleteKeypad = "Delete a keypad",
    toolgunCancelPlacement = "Cancel Placement",
    toolgunUpdateSettings = "Update a keypad's settings",



    --Toolgun Menu Strings
    menuPassword = "Password:",
    menuPasswordHint = "4 digit maximum, numerical passwords only.",
    menuSecureMode = "Enable Secure Mode:",
    menuSecureModeHint = "Hides the password when you type it.",
    menuFadeMaterial = "Fade Material:",
    menuFadeMaterialHint = "The material to make your fading door turn into when faded.",
    menuFadeTime = "Fade Time:",
    menuFadeTimeHint = "The time to keep your fading door open.",


    --Keypad Cracker Strings
    crackerDescription = "Click on a keypad a wait to crack it",
    crackerCrackingMessage = "Cracking Keypad...",


    --Keypad Checker Strings
    checkerName = "sKeypad Checker",
    checkerDescription = "Click on a keypad to see info about it and it's connected fading door.",
    checkerHint = "Left Click on a keypad to see info about it and it's connected fading door.\nRight Click to deselect.",
    checkerShowData = "Keypad Type: %t\nProtected: %p\nOwner: %o",



    --Friends Menu Strings
    friendsMenuName = "Keypad Friends",
    friendsMenuTopHint = "The friends you set here will be able to use the fingerprint scanner on your keypads.\nThese will save across different servers and restarts.",
    friendsListTitle = "Your friends:",
    friendsPlayerSteamID = "SteamID64",
    friendsPlayerName = "Name",
    friendsRemove = "Remove Friend",
    friendsAddSteamID = "Add SteamID64",
    friendsAddOnlinePlayer = "Add online player:",
    friendsNoPlayersAvail = "[No available players]",
    friendsTooMany = "You have too many friends, truncating!",
    friendsAddTitle = "Add a friend",
    friendsAddInputString = "Enter the SteamID64 of the friend you want to add:",
    friendsAddButton = "Add",
    friendsAddCancelButton = "Cancel",
    friendsRefresh = "Refresh",


    --Cleanup Strings
    keypadUndone = "Undone sKeypad",
    keypadCleanupName = "sKeypads",
    keypadCleanedUp = "Cleaned up all sKeypads",
    keypadReachedLimit = "You've reached the sKeypad limit!",
    keypadReachedPersonalLimit = "You've reached your personal sKeypad limit!"

}

local selectedLang = languages[sKeypads.Config.language]
if not selectedLang then return end

sKeypads.Lang = table.Merge(languages["english"], selectedLang)
