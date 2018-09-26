#Create Teams

#Team.first
oilers = Team.create(name: "Oilers", password: "oilers123")
#Team.second
flames = Team.create(name: "Flames", password: "flames123")

#Create Players & assign to team  - OILERS
mcdavid = Player.create(name: "Connor McDavid")
nurse = Player.create(name: "Darnell Nurse")
lucic = Player.create(name: "Milan Lucic")
strome = Player.create(name: "Ryan Strome")
sekera = Player.create(name: "Andrej Sekera")
talbot = Player.create(name: "Cam Talbot")

oilers.players << mcdavid
oilers.players << nurse
oilers.players << lucic
oilers.players << strome
oilers.players << sekera
oilers.players << talbot

oilers.save

#Create Players & assign to team - FLAMES
gaudreau = Player.create(name: "Johnny Gaudreau")
monohan = Player.create(name: "Sean Monohan")
neal = Player.create(name: "James Neal")
giordano = Player.create(name: "Mark Giordano")
brodie = Player.create(name: "TJ Brodie")
smith = Player.create(name: "Mike Smith")

flames.players << gaudreau
flames.players << monohan
flames.players << neal
flames.players << giordano
flames.players << brodie
flames.players << smith
flames.save

#Create Positions
c = Position.create(position: "Center")
rw = Position.create(position: "Right Wing")
lw = Position.create(position: "Left Wing")
d = Position.create(position: "Defense")
g = Position.create(position: "Goalie")

#Assign positions
lw.players << Player.find_by_name("Johnny Gaudreau")
rw.players << Player.find_by_name("Johnny Gaudreau")
lw.players << Player.find_by_name("Milan Lucic")
rw.players << Player.find_by_name("Ryan Strome")
lw.players << Player.find_by_name("Ryan Strome")
rw.players << Player.find_by_name("James Neal")
c.players << Player.find_by_name("Connor McDavid")
c.players << Player.find_by_name("Sean Monohan")
d.players << Player.find_by_name("Darnell Nurse")
d.players << Player.find_by_name("Mark Giordano")
d.players << Player.find_by_name("TJ Brodie")
d.players << Player.find_by_name("Andrej Sekera")
g.players << Player.find_by_name("Cam Talbot")
g.players << Player.find_by_name("Mike Smith")

lw.save
c.save
d.save
rw.save

#Create Salaries
s1 = Salary.create(range: "$100k < $1 million")
s2 = Salary.create(range: "$1 - $3 million")
s3 = Salary.create(range: "$3 - $6 million")
s4 = Salary.create(range: "$6 - $10 million")
s5 = Salary.create(range: "> $10 million")

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

