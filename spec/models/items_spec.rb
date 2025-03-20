RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '価格のバリデーション' do
    it '価格が300円未満だと登録できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price は¥300〜¥9,999,999の範囲で入力してください')
    end

    it '価格が9,999,999円を超えると登録できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price は¥300〜¥9,999,999の範囲で入力してください')
    end

    it '価格が空だと登録できない' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it '価格が半角数値でないと登録できない' do
      @item.price = '１０００' # 全角数字
      @item.valid?
      expect(@item.errors.full_messages).to include('Price は¥300〜¥9,999,999の範囲で入力してください')
    end

    it '価格が半角英字では登録できない' do
      @item.price = 'abc'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price は¥300〜¥9,999,999の範囲で入力してください')
    end

    it '価格が半角英数混合では登録できない' do
      @item.price = 'abc123'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price は¥300〜¥9,999,999の範囲で入力してください')
    end
  end
end
