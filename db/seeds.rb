# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
uo_account = Account.create(name: 'Urban Outlets')
uo_account.record_transactions.create!(record_count: 1000000)

features = {
  account_management: true,
  feature_management: true,
  super_admin: true,
  count_timings: true,
  download_list: true
}

seed_users = [
  {
    first_name: 'Test',
    last_name: 'Admin',
    email: 'admin@test.com',
    password: 'm1k&Yb24',
    role: :admin,
    account_id: uo_account.id,
    features: features
  }]

  User.create(seed_users)
