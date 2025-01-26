local names = {
    male = {
    "Horace", "Buddy", 
    "Randall", "John", 
    "Barnaby", "Barnard", 
    "Dennis", "Edmund", "Miles", 
    "Jacob", "Lester", "Hugo",
    "Damon", "Peter", "Gary", "Shannon",
    "Brian", "Todd", "Joseph", "Ashley", 
    "Patrick", "Julian", "Everett", "Ralph",
    "Darcy", "Julius", "Emil", "David", "Nelson",
    "Reginald", "Terrence", "Shannon", "Jason", 
    "Barnard", "Ronald", "Rodney", "Cornelius", "Osborn", 
    "Roy", "Harry", "Prosper", "Buddy", "Gary", "Andrew", "Emery",
    "Derek", "Ronald", "Kelly", "Donald", "Brian", "Claude", "Curtis", 
    "Ferdinand", "Horace", "Theodore", "Matthew", "Archibald", "Emas", "Jonas",
    "William", "Logan", "Stuart", "Dwayne", "Lester", "Jonas",
    "Abram", "Avaz", "Avvakum", "August", "Augustine", "Avdey", "Abraham", "Autandil", "Agap", 
    "Agafon", "Aggai", "Adam", "Adis", "Adolf", "Adrian", "Azzamat", "Aidar", "Ainur", "Ayrat", "Akim", 
    "Alan", "Aley", "Alexander", "Alexey", "Ali", "Albert", "Alfred", "Amadeus", "Amadeus", "Amayak", "Ambrose", 
    "Ananias", "Anastasius", "Anatoly", "Anwar", "Angel", "Andoim", "Andrew", "Anikita", "Anton", "Aram", "Arius", 
    "Aristarchus", "Arkady", "Arman", "Arno", "Arnold", "Aaron", "Arsen", "Arseniy", "Arslan", "Artem", "Artemiy", "Arthur", 
    "Archippus", "Askar", "Askold", "Aslan", "Athanasius", "Ahmed", "Ashot", "Balthazar", "Bejen", "Benedict", "Berek", "Bernard", 
    "Bertrand", "Bogdan", "Boleslaw", "Boris", "Bronislav", "Bulat", "Vadim", "Valentin", "Valery", "Walter", "Bartholomew", "Vasily", 
    "Vaclav", "Velizar", "Benedict", "Benjamin", "Vikenti", "Victor", "Willy", "William", "Vissarion", "Vitaly", "Vitold", "Vladimir", 
    "Vladislav", "Vladlen", "Volodar", "Waldemar", "Vsevolod", "Vyacheslav", "Gabriel", "Galaktion", "Harry", "Gaston", "Gayas", "Gevor", 
    "Gennady", "Henry", "George", "Heracles", "Herald", "Gerasim", "Herman", "Gleb", "Gordey", "Gordon", "Gorislaus", "Gradimir", 
    "Grigory", "Gury", "Gustav", "David", "Damir", "Daniel", "Daniel", "Daniyar", "Darius", "Dementiy", "Demid", "Demosthenes", "Demyan", 
    "Dennis", "Jamal", "Jordan", "Dmitry", "Dobrynya", "Donald", "Dorofey", "Evgeny", "Evgraf", "Evdokim", "Eusebius", "Eusey", "Eustathius", 
    "Yegor", "Eleazar", "Elisha", "Emelyan", "Jeremiah", "Ermolay", "Erophei", "Euphem", "Ephraim", "Jean", "Zhan", "Georges", "Zachar", "Zinoviy", 
    "Ibrahim", "Ivan", "Ignatius", "Igor", "Illarion", "Ildar", "Il'ya", "Ilya", "Il'ias", "Innokentiy", "Ioann", "Joseph", 
    "Hippolytus", "Iskander", "Islam", "Kamil", "Karim", "Carl", "Kirill", "Klim", "Kondrat", "Konstantin", "Korney", "Kuzma", "Lavr", 
    "Lavrentiy", "Lev", "Leon", "Leonid", "Leontiy", "Leopold", "Luke", "Lukyan", "Lyubim", "Makar", "Maxim", "Maximilian", "Marat", 
    "Mark", "Marcel", "Martin", "Matvey", "Miron", "Miroslav", "Mitrofan", "Mikhail", "Mikhey", "Michel", "Mstislav", "Murad", "Muslim", 
    "Nazar", "Nazariy", "Nail", "Nathan", "Naum", "Nestor", "Nikanor", "Nikita", "Nikifor", "Nikolai", "Nikodim", "Niphont", "Norman", 
    "Ovid", "Olan", "Oleg", "Oles", "Onisim", "Orest", "Osip", "Oscar", "Paul", "Peter", "Plato", "Prokhor", "Ravil", "Radik", 
    "Redmir", "Radomir", "Radu", "Ramazan", "Ramil", "Ratibor", "Ratmir", "Raphael", "Rahim", "Rashid", "Rinat", "Richard", "Robert", 
    "Rodion", "Roland", "Roman", "Rostislav", "Rudolph", "Ruslan", "Rustam", "Sabir", "Sava", "Saveliy", "Salim", "Samvel", "Samson", 
    "Svyatoslav", "Sebastian", "Semyon", "Seraphim", "Sergey", "Solomon", "Spartacus", "Spyridon", "Stanislav", "Stepan", "Stephen", "Suleiman", 
    "Sultan", "Tagir", "Tamerlan", "Taras", "Theodore", "Tigran", "Timothy", "Timur", "Tikhon", "Trofim", "Umar", "Ustin", "Thaddeus", "Farid", 
    "Fedor", "Fedot", "Felix", "Theodosius", "Ferdinand", "Fidel", "Philemon", "Philip", "Flor", "Florentine", "Thomas", "Francis", "Frederick", 
    "Fuad", "Chariton", "Hassan", "Christian", "Christ", "Christopher", "Shamil", "Edward", "Edgar", "Edward", "Eldar", "Emil", "Emin", 
    "Emir", "Emmanuel", "Eric", "Ernest", "Julian", "Julius", "Yuri", "Yusuf", "Yehim", "Yakin", "Jacob", "Jan", "January", "Yaromir", "Yaroslav", "Jason"
    },
    second = {
    "Fowler", "Bailey", "Bisley", "Tate", "Singleton",
    "Dixon", "Warner", "Parrish", "Lloyd", "Ball",
    "Anthony", "Watts", "Neil", "Boyd", "Joseph", "Hampton", "Barrett",
    "Knight", "Warner", "Oliver", "Phillips", "Kane", "Gallagher",
    "Hunter", "Lawson", "Hodges", "Fowler", "Holland", "Ellison",
    "Campbell", "Richards", "Pierce", "Hamilton", "Garrett", "Joseph",
    "Phelps", "Hall", "Strickland", "Norris",
    "Harrington", "Logan", "Anthony", "Adams", "Pitts", "Garrett", "Black",
    "Lindsay", "Fox", "Chapman", "Watson", "King", "Potter", "Davis", "Crawford",
    "Pope", "Butler", "Ferguson", "Bond", "Holt", "Carter", "Jackson", "Parsons",
    "Lamb", "Barton", "Dorsey", "Wiggins", "Wood", "Sims", "Haynes", "Walsh", "Clark", "Joseph",
    "Griffith", "Fields", "Caldwell", "Gordon", "Bishop", "Lynch", "Willis", "Sherman", "Knight", "Martin",
    "Parsons", "Jackson", "Diaz", "Hayes",
    "Smith", "Johnson", "Williams", "Jones", "Brown", "Davis", "Miller", "Wilson", "Moore", "Taylor",
    "Anderson", "Thomas", "Jackson", "White", "Harris", "Martin", "Thompson", "Garcia", "Martinez", "Robinson",
    "Clark", "Rodriguez", "Lewis", "Walker", "Hall", "Allen", "Young", "Hernandez", "King", "Wright", "Lopez",
    "Hill", "Scott", "Green", "Adams", "Baker", "Gonzalez", "Nelson", "Carter", "Mitchell", "Perez", "Roberts",
    "Turner", "Phillips", "Campbell", "Parker", "Evans", "Edwards", "Collins", "Stewart", "Sanchez", "Morris",
    "Rogers", "Reed", "Cook", "Morgan", "Bell", "Murphy", "Bailey", "Rivera", "Cooper", "Richardson", "Howard", "Ward",
    "Torres", "Peterson", "Gray", "Ramirez", "James", "Watson", "Brooks", "Kelly", "Sanders", "Price", "Bennett",
    "Wood", "Barnes", "Ross", "Henderson", "Coleman", "Jenkins", "Perry", "Powell", "Long", "Patterson", "Hughes",
    "Flores", "Washington", "Butler", "Simmons", "Foster", "Gonzalez", "Bryant", "Alexander", "Russell", "Griffin"
    }
}
function FreeName(name) MySQLite.query(string.format([[UPDATE darkrp_player SET rpname = NULL WHERE rpname = %s OR rpname = %s]], MySQLite.SQLStr(name .. utf8.char(8203)), MySQLite.SQLStr(name))) end
function GenerateName(ply)
    local newname = table.Random(names.male).. " "..table.Random(names.second)
    FreeName(newname)
    timer.Simple(.5,function()
        ply:setRPName(newname)
        ply:SetNW2Bool("ChangedName", false)
    end)
end

hook.Add("PlayerInitialSpawn","RetrimeNames",function(ply)
timer.Simple(5, function()
    if !IsValid(ply) then return end
    if ply:getDarkRPVar("rpname") == ply:SteamName() then
        GenerateName(ply)
    end
    end)
end)


