User.create(fullname: "Jeff Bai", username: "jeffbai996", password: "123456")
User.create(fullname: "Bob Choe", username: "bob_choe", password: "123456")
User.create(fullname: "Ryan Hicks", username: "r_hicks123", password: "123456")
User.create(fullname: "Dan Porter", username: "dporter55", password: "123456")
User.create(fullname: "Linda Brown", username: "lbrown87", password: "123456")

Log.create(user_id: 1, date: "March 17 2020", pilot_in_command: "Jeff Bai", aircraft_type: "C172", aircraft_rego: "N172SP", origin: "CZBB", destination: "CZBB", landings: 1, remarks: "seed")
Log.create(user_id: 2, date: "April 8 2020", pilot_in_command: "Bob Choe", aircraft_type: "SR22", aircraft_rego: "C-GWPP", origin: "CZBB", destination: "CZBB", landings: 2, remarks: "seed")
Log.create(user_id: 3, date: "May 14 2020", pilot_in_command: "Ryan Hicks", aircraft_type: "C152", aircraft_rego: "C-GBJK", origin: "CZBB", destination: "CZBB", landings: 4, remarks: "seed")
Log.create(user_id: 4, date: "August 1 2020", pilot_in_command: "Dan Porter", aircraft_type: "C162", aircraft_rego: "N588SC", origin: "CZBB", destination: "CZBB", landings: 1, remarks: "seed")
Log.create(user_id: 5, date: "September 12 2020", pilot_in_command: "Linda Brown", aircraft_type: "SR20", aircraft_rego: "N262CD", origin: "CZBB", destination: "CZBB", landings: 1, remarks: "seed")