FactoryBot.define do
  factory :teacher, class: User do
    email { "joe_teacher@ait.asia" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :project, class: Ps3Project do
    name { "My favorite project" }
    url { "http://somewhere.com" }
  end

  factory :student, class: Ps3Student do
    name { "Joe Student" }
    studentid { "123456" }
  end
end
