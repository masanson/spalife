# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.find_or_create_by!(email: "awsedrftg153@example.com") do |admin|
  admin.password = ENV['ADMIN_KEY']
end

genre1 = Genre.find_or_create_by!(name: "その他") do |genre|
  genre.name = "その他"
end

genre2 = Genre.find_or_create_by!(name: "露天風呂") do |genre|
  genre.name = "露天風呂"
end

genre3 = Genre.find_or_create_by!(name: "足湯") do |genre|
  genre.name = "足湯"
end

hot_spring1 = HotSpring.find_or_create_by!(name: "○○温泉") do |hot_spring|
  hot_spring.hot_spring_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-hotspring1.jpg"), filename:"sample-hotspring1.jpg")
  hot_spring.name = "○○温泉"
  hot_spring.introduction = "足湯が有名。"
  hot_spring.postal_code = "1465463"
  hot_spring.prefecture_id = 23
  hot_spring.address = "長久手市荒田687-15"
  hot_spring.telephone_number = "035681346"
  hot_spring.access = "藤が丘駅からバス10分。"
end

hot_spring2 = HotSpring.find_or_create_by!(name: "XX旅館") do |hot_spring|
  hot_spring.hot_spring_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-hotspring2.jpg"), filename:"sample-hotspring2.jpg")
  hot_spring.name = "XX旅館"
  hot_spring.introduction = "綺麗な景色が見れます。"
  hot_spring.postal_code = "4258362"
  hot_spring.prefecture_id = 15
  hot_spring.address = "新潟市"
  hot_spring.telephone_number = "3428695210"
  hot_spring.access = "新潟駅から車で30分。"
end

hot_spring3 = HotSpring.find_or_create_by!(name: "○○旅館") do |hot_spring|
  hot_spring.hot_spring_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-hotspring3.jpg"), filename:"sample-hotspring3.jpg")
  hot_spring.name = "○○旅館"
  hot_spring.introduction = "檜の湯舟が良い。"
  hot_spring.postal_code = "3189675"
  hot_spring.prefecture_id = 13
  hot_spring.address = "東村山市青葉町1-295-15"
  hot_spring.telephone_number = "06534931368"
  hot_spring.access = "東村山駅から徒歩20分。"
end

end_user1 = EndUser.find_or_create_by!(email: "enduser1@example.com") do |end_user|
  end_user.last_name = "遊佐"
  end_user.first_name = "一"
  end_user.last_name_kana = "ゆざ"
  end_user.first_name_kana = "はじめ"
  end_user.user_name = "user1"
  end_user.introduction = "温泉大好き！"
  end_user.sex = 0
  end_user.postal_code = "3681254"
  end_user.address = "岐阜県関市西欠ノ下411-2"
  end_user.telephone_number = "0835126348"
  end_user.password = ENV['USER_KEY1']
  end_user.user_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-enduser1.jpg"), filename:"sample-enduser1.jpg")
end

end_user2 = EndUser.find_or_create_by!(email: "enduser2@example.com") do |end_user|
  end_user.last_name = "遊佐"
  end_user.first_name = "二海"
  end_user.last_name_kana = "ゆざ"
  end_user.first_name_kana = "ふたみ"
  end_user.user_name = "user2"
  end_user.introduction = "温泉初心者です。"
  end_user.sex = 1
  end_user.postal_code = "4256897"
  end_user.address = "鳥取県鳥取市気高町宿715-20"
  end_user.telephone_number = "0245368954"
  end_user.password = ENV['USER_KEY2']
  end_user.user_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-enduser2.jpg"), filename:"sample-enduser2.jpg")
end

end_user3 = EndUser.find_or_create_by!(email: "enduser3@example.com") do |end_user|
  end_user.last_name = "遊佐"
  end_user.first_name = "三美郎"
  end_user.last_name_kana = "ゆざ"
  end_user.first_name_kana = "さんびろう"
  end_user.user_name = "user3"
  end_user.introduction = "美肌に良い温泉はどこですか？"
  end_user.sex = 2
  end_user.postal_code = "3458265"
  end_user.address = "石川県能美郡川北町上先出486-5"
  end_user.telephone_number = "04715632846"
  end_user.password = ENV['USER_KEY3']
  end_user.user_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-enduser3.jpg"), filename:"sample-enduser3.jpg")
end

hot_post1 = HotPost.find_or_create_by!(title: "○○温泉レビュー") do |hot_post|
  hot_post.title = "○○温泉レビュー"
  hot_post.body = "足湯が気持ち良かった。"
  hot_post.end_user = end_user1
  hot_post.genre = genre3
  hot_post.hot_spring = hot_spring1
end

HotPost.find_or_create_by!(title: "XX旅館レビュー") do |hot_post|
  hot_post.hot_post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-hotpost1.jpg"), filename:"sample-hotpost1.jpg")
  hot_post.title = "XX旅館レビュー"
  hot_post.body = "露天風呂良かった。"
  hot_post.end_user = end_user2
  hot_post.genre = genre2
  hot_post.hot_spring = hot_spring2
end

HotPost.find_or_create_by!(title: "○○旅館レビュー") do |hot_post|
  hot_post.hot_post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-hotpost2.jpg"), filename:"sample-hotpost2.jpg")
  hot_post.title = "○○旅館レビュー"
  hot_post.body = "檜の風呂以外も中々良かった。"
  hot_post.end_user = end_user3
  hot_post.genre = genre1
  hot_post.hot_spring = hot_spring3
end

HotPost.find_or_create_by!(title: "温泉レビュー下書き") do |hot_post|
  hot_post.title = "温泉レビュー下書き"
  hot_post.body = "下書き中"
  hot_post.status = 1
  hot_post.end_user = end_user1
  hot_post.genre = genre1
end

Comment.find_or_create_by!(id: 1) do |comment|
  comment.content = "足湯気持ちよかったですよ！"
  comment.hot_post = hot_post1
  comment.end_user = end_user2
end

Comment.find_or_create_by!(id: 2) do |comment|
  comment.content = "ここ露天風呂も良かったですよ！"
  comment.hot_post = hot_post1
  comment.end_user = end_user3
end