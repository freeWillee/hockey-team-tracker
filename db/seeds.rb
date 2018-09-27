#Create User (GMs)
peter = User.create(username: "peter", email: "peter@mail.com", password: "peter123")
brad = User.create(username: "brad", email: "brad@mail.com", password: "brad123")

#Create Teams
oilers = Team.create(name: "Edmonton Oilers")
flames = Team.create(name: "Calgary Flames")

#Create salaries
s1 = Salary.create(amount: 1000000)
s2 = Salary.create(amount: 2000000)
s3 = Salary.create(amount: 3000000)
s4 = Salary.create(amount: 4000000)
s5 = Salary.create(amount: 5000000)
s6 = Salary.create(amount: 6000000)

#Create goaltargets
g1 = GoalTarget.create(target: 20)
g2 = GoalTarget.create(target: 40)
g3 = GoalTarget.create(target: 60)

#Create assisttargets
a1 = AssistTarget.create(target: 30)
a2 = AssistTarget.create(target: 40)
a3 = AssistTarget.create(target: 50)

#Create Players - OILERS
mcdavid = Player.create(name: "Connor McDavid", goals: 2, assists: 3, birth_year: 1997)
nurse = Player.create(name: "Darnell Nurse", goals: 2, assists: 3, birth_year: 1995)
lucic = Player.create(name: "Milan Lucic", goals: 2, assists: 3, birth_year: 1988)
strome = Player.create(name: "Ryan Strome", goals: 2, assists: 3, birth_year: 1993)
sekera = Player.create(name: "Andrej Sekera", goals: 2, assists: 3, birth_year: 1986)

#Create Players - FLAMES
gaudreau = Player.create(name: "Johnny Gaudreau", goals: 2, assists: 3, birth_year: 1993)
monohan = Player.create(name: "Sean Monohan", goals: 2, assists: 3, birth_year: 1994)
neal = Player.create(name: "James Neal", goals: 2, assists: 3, birth_year: 1987)
giordano = Player.create(name: "Mark Giordano", goals: 2, assists: 3, birth_year: 1983)
brodie = Player.create(name: "TJ Brodie", goals: 2, assists: 3, birth_year: 1990)

#Create Positions
f = Position.create(position: "Forward")
d = Position.create(position: "Defense")

#Assign user to team
flames.users << brad
oilers.users << peter

flames.save
oilers.save

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

# Assign players to teams
oilers.players << mcdavid
oilers.players << nurse
oilers.players << lucic
oilers.players << strome
oilers.players << sekera

oilers.save

flames.players << gaudreau
flames.players << monohan
flames.players << neal
flames.players << giordano
flames.players << brodie

flames.save

#Assign salaries
s6.players << mcdavid
s6.players << gaudreau
s5.players << lucic
s5.players << giordano
s5.players << monohan
s4.players << strome
s4.players << neal
s3.players << sekera
s2.players << nurse
s2.players << brodie

s2.save
s3.save
s4.save
s5.save
s6.save

#Assign targets
g3.players << mcdavid
a3.players << mcdavid
g3.players << gaudreau
a2.players << gaudreau
g2.players << lucic
a3.players << lucic
a3.players << giordano
g2.players << giordano
g3.players << monohan
a2.players << monohan
g2.players << strome
a3.players << strome
g1.players << neal
a1.players << neal
g2.players << sekera
a3.players << sekera
g1.players << nurse
a2.players << nurse
g1.players << brodie
a2.players << brodie

g1.save
g2.save
g3.save
a1.save
a2.save
a3.save
