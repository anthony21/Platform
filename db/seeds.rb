
test_account = Account.create(name: 'Test Organization')
test_account.record_transactions.create!(record_count: 1000000)

uo_account = Account.create(name: 'Urban Outlets')
uo_account.record_transactions.create!(record_count: 1000000)

features = {
  account_management: true,
  feature_management: true,
  super_admin: true,
  count_timings: true,
  ping: true,
  download_list: true
}

seed_users = [
  {
    first_name: 'Test',
    last_name: 'Admin',
    email: 'admin@test.com',
    password: 'testtest',
    role: :admin,
    account_id: test_account.id,
    features: features
  },
  {
    first_name: 'Test',
    last_name: 'User 1',
    email: 'user1@test.com',
    password: 'testtest',
    role: :user,
    account_id: test_account.id
  },
  {
    first_name: 'Test',
    last_name: 'User 2',
    email: 'user2@test.com',
    password: 'testtest',
    role: :user,
    account_id: test_account.id
  },
  {
    first_name: 'UO',
    last_name: 'Admin',
    email: 'admin@urbanoutlets.com',
    password: 'testtest',
    role: :admin,
    account_id: uo_account.id,
    features: features
  },
  {
    first_name: 'UO',
    last_name: 'Help',
    email: 'help@urbanoutlets.com',
    password: 'testtest',
    role: :user,
    account_id: uo_account.id
  }
]

User.create(seed_users)
