# lib/tasks/reset_db.rake
namespace :db do
  desc "Drop, create, migrate, and seed the database"
  task reset: :environment do
    puts "Dropping database..."
    system("rails db:drop")

    puts "Creating database..."
    system("rails db:create")

    puts "Migrating database..."
    system("rails db:migrate")

    puts "Seeding database..."
    system("rails db:seed")

    puts "Database reset complete."
  end
end
