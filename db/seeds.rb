path_to_seeds = Rails.root.join('db', 'seeds', '*.rb')
seed_files = Dir[path_to_seeds]
seed_files.each { |seed_file| require seed_file }

if Rails.env.development?
  Seeds::CreateMany.courses
  Seeds::CreateMany.rooms
  Seeds::CreateMany.people
end
