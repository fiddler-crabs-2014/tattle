# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#seed database data

scraper = ScraperService.new

scraper.ftf_get_certs
scraper.ftusa_get_certs
scraper.rainforest_alliance_get_certs
scraper.usda_organics