require 'rails_helper'

RSpec.describe Message, type: :model do #この書き方何? 頭のRSpecとtypeの指定
  describe '#create' do
    context 'can save' do #これで区切るのね
      # 1. contentとimageが存在すれば登録できる
      it "is valid with a content and image" do
        # message = build(:message)
        # message.valid?
        expect(build(:message)).to be_valid #上の2行を省略
      end

      # 2. contentがあれば登録できる
      it "is valid with a content " do
        # message = build(:message, image: nil)
        # message.valid?
        expect(build(:message, image: nil)).to be_valid
      end
      
      # 3. imageがあれば登録できる
      it "is valid with a content, image" do
        # message = build(:message, content: nil)
        # message.valid?
        expect(build(:message, content: nil)).to be_valid
      end
    end

    context 'can not save' do
        #4 contentとimageがなければ登録できない
      it "is invalid without a content and image" do
        message = build(:message, content: nil, image: nil)
        message.valid?
        expect(message.errors[:content]).to include("を入力してください")
      end

      # 5. group_idが空では登録できな
      it "is invalid without a group_id" do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください") #group_idと記述しない
      end

      # 6. user_idが空では登録できな
      it "is invalid without a user_id" do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end
    end

  end
end