FactoryBot.define do

  factory :message do
    content    {Faker::Lorem.sentence}
    image      {File.open("#{Rails.root}/public/images/test_image.jpg")}
    user #user_idのこと?ダミーデータを作っていないのは、自動で決まるから? 項目だけ用意した?
    group
  end

end

# 未完成