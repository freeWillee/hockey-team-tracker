###### OILERS ######

#Create Teams
oilers = Team.create(name: "Oilers", password: "oilers123")
flames = Team.create(name: "Flames", password: "flames123")

#Create Players  - OILERS
oilers.players.build(name: "Connor McDavid")
oilers.players.build(name: "Darnell Nurse")
oilers.players.build(name: "Milan Lucic")
oilers.players.build(name: "Ryan Strome")
oilers.players.build(name: "Andrej Sekera")
oilers.players.build(name: "Cam Talbot")
oilers.save

#Create Players  - FLAMES
flames.players.build(name: "Johnny Gaudreau")
flames.players.build(name: "Sean Monohan")
flames.players.build(name: "James Neal")
flames.players.build(name: "Mark Giordano")
flames.players.build(name: "TJ Brodie")
flames.players.build(name: "Mike Smith")
flames.save

#Create Positions
c = Position.create(position: "Center")
rw = Position.create(position: "Right Wing")
lw = Position.create(position: "Left Wing")
d = Position.create(position: "Defense")
g = Position.create(position: "Goalie")

#Assign positions
lw.players < Player.find_by_name("Johnny Gaudreau")
rw.players < Player.find_by_name("Johnny Gaudreau")
lw.players < Player.find_by_name("Milan Lucic")
rw.players < Player.find_by_name("Ryan Strome")
lw.players < Player.find_by_name("Ryan Strome")
rw.players < Player.find_by_name("James Neal")
c.players < Player.find_by_name("Connor McDavid")
c.players < Player.find_by_name("Sean Monohan")
d.players < Player.find_by_name("Darnell Nurse")
d.players < Player.find_by_name("Mark Giordano")
d.players < Player.find_by_name("TJ Brodie")
d.players < Player.find_by_name("Andrej Sekera")
g.players < Player.find_by_name("Cam Talbot")
g.players < Player.find_by_name("Mike Smith")

lw.save
c.save
d.save
rw.save

#Create Salaries
s1 = Salary.create(range: "$< $1 million")
s2 = Salary.create(range: "$1 - $3 million")
s3 = Salary.create(range: "$3 - $6 million")
s4 = Salary.create(range: "$6 - $10 million")
s5 = Salary.create(range: "> $10 million")

#Create Staff - OILERS
Staff.create(name: "Todd McLellan", role: "Head Coach")
Staff.create(name: "Glen Gulutzan", role: "Assistant Coach")

#Create Staff - FLAMES
Staff.create(name: "Bill Peters", role: "Head Coach")
Staff.create(name: "Ryan Huska", role: "Assistant Coach")

