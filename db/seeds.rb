require 'faker'

path_to_seeds = Rails.root.join('db', 'seeds', '*.rb')
seed_files = Dir[path_to_seeds]
seed_files.each { |seed_file| require seed_file }

env = Rails.env

if env.development? || env.production?
  Seeds::CreateMany.rooms
  Seeds::CreateMany.courses
  Seeds::CreateMany.people
  Seeds::CreateMany.enrollments
  Seeds::CreateMany.meetings
end
