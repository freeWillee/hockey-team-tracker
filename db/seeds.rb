#Create Teams

#Team.first
oilers = Team.create(name: "Edmonton Oilers")
#Team.second
flames = Team.create(name: "Calgary Flames")

#Create Players & assign to team  - OILERS
mcdavid = Player.create(name: "Connor McDavid")
nurse = Player.create(name: "Darnell Nurse")
lucic = Player.create(name: "Milan Lucic")
strome = Player.create(name: "Ryan Strome")
sekera = Player.create(name: "Andrej Sekera")

oilers.players << mcdavid
oilers.players << nurse
oilers.players << lucic
oilers.players << strome
oilers.players << sekera

oilers.save

#Create Players & assign to team - FLAMES
gaudreau = Player.create(name: "Johnny Gaudreau")
monohan = Player.create(name: "Sean Monohan")
neal = Player.create(name: "James Neal")
giordano = Player.create(name: "Mark Giordano")
brodie = Player.create(name: "TJ Brodie")

flames.players << gaudreau
flames.players << monohan
flames.players << neal
flames.players << giordano
flames.players << brodie
flames.save

#Create Positions
f = Position.create(position: "Forward")
d = Position.create(position: "Defense")

#Assign positions
f.players << Player.find_by_name("Johnny Gaudreau")
f.players << Player.find_by_name("Johnny Gaudreau")
f.players << Player.find_by_name("Milan Lucic")
f.players << Player.find_by_name("Ryan Strome")
f.players << Player.find_by_name("Ryan Strome")
f.players << Player.find_by_name("James Neal")
f.players << Player.find_by_name("Connor McDavid")
f.players << Player.find_by_name("Sean Monohan")
d.players << Player.find_by_name("Darnell Nurse")
d.players << Player.find_by_name("Mark Giordano")
d.players << Player.find_by_name("TJ Brodie")
d.players << Player.find_by_name("Andrej Sekera")

f.save
d.save

#Create salaries

#Assign salaries
mcdavid.salary = s5
mcdavid.save
nurse.salary = s2
nurse.save
lucic.salary = s3
lucic.save
strome.salary = s2
strome.save
sekera.salary = s3
sekera.save
talbot.salary = s3
talbot.save

gaudreau.salary = s4
gaudreau.save
monohan.salary = s4
monohan.save
neal.salary = s3
neal.save
giordano.salary = s4
giordano.save
brodie.salary = s3
brodie.save
smith.salary = s2
smith.save


#Create Staff - OILERS
todd = Staff.create(name: "Todd McLellan", role: "Head Coach")
todd.team = Team.first
todd.salary = s3
glen = Staff.create(name: "Glen Gulutzan", role: "Assistant Coach")
glen.team = Team.first
glen.salary = s2
todd.save
glen.save

#Create Staff - FLAMES
bill = Staff.create(name: "Bill Peters", role: "Head Coach")
bill.team = Team.second
bill.salary = s3
ryan = Staff.create(name: "Ryan Huska", role: "Assistant Coach")
ryan.team = Team.second
ryan.salary = s2
bill.save
ryan.save

