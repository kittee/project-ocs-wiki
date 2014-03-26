# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create([
  { name: "person" },
  { name: "inside_joke" },
  { name: "student" },
  { name: "teacher" },
  { name: "mentor" },
  { name: "supporting_employer" },
  { name: "business" },
  { name: "location" },
  { name: "coding_language" },
  { name: "miscellaneous" }
])