require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '正常系' do
      it '全ての項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '異常系' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したメールアドレスは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        expect(another_user).not_to be_valid
      end

      it 'メールアドレスに@が含まれない場合は登録できない' do
        @user.email = 'testexample.com'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'パスワードが空では登録できない' do
        @user.password = ''
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードが6文字未満では登録できない' do
        @user.password = 'a1b2c'
        @user.password_confirmation = 'a1b2c'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it '英字のみのパスワードでは登録できない' do
        @user.password = 'abcdef'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it '数字のみのパスワードでは登録できない' do
        @user.password = '123456'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'ａｂｃ123'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'パスワードとパスワード確認が一致しないと登録できない' do
        @user.password_confirmation = 'different'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '姓（全角）が空では登録できない' do
        @user.last_name = ''
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it '姓（全角）に半角文字が含まれていると登録できない' do
        @user.last_name = 'Yamada'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters')
      end

      it '名（全角）が空では登録できない' do
        @user.first_name = ''
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it '名（全角）に半角文字が含まれていると登録できない' do
        @user.first_name = 'Taro'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters')
      end

      it '姓（カナ）が空では登録できない' do
        @user.last_name_kana = ''
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it '姓（カナ）にカタカナ以外の文字が含まれていると登録できない' do
        @user.last_name_kana = 'やまだ'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters')
      end

      it '名（カナ）が空では登録できない' do
        @user.first_name_kana = ''
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it '名（カナ）にカタカナ以外の文字が含まれていると登録できない' do
        @user.first_name_kana = 'たろう'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters')
      end

      it '生年月日が空では登録できない' do
        @user.birthday = nil
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
