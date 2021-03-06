Factory.define :post do |p|
  p.title "First post"
  p.body "very short body"
  p.association :user
end

#using sequence on email to make sure we wont have problems in test
# since email is unique on db
Factory.define :user do |u|
  u.name  "Test"
  u.sequence(:email) { |n| "test#{n}@test.com" }
  u.password "123456"
end

Factory.define :attachment do |a|
  a.name "Rails Logo"
  a.attachment File.open("spec/fixtures/rails.png")
end

Factory.define :comment do |c|
  c.body "Comment"
  c.association :post
end