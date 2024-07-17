require 'rails_helper'

RSpec.describe PurchaseDestination, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_destination = FactoryBot.build(:purchase_destination, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入情報の保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_destination).to be_valid
      end

      it '建物名が空でも保存できること' do
        @purchase_destination.building_name = ''
        expect(@purchase_destination).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空では保存できないこと' do
        @purchase_destination.post_code = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors[:post_code]).to include("can't be blank")
      end

      it '郵便番号が「3桁ハイフン4桁」の形式でないと保存できないこと' do
        @purchase_destination.post_code = '1234567'
        @purchase_destination.valid?
        expect(@purchase_destination.errors[:post_code]).to include("should be in the format 123-4567")
      end

      it '都道府県を選択していないと保存できないこと' do
        @item.shipping_source_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping source can't be blank")
      end

      it '市区町村が空では保存できないこと' do
        @purchase_destination.municipality = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Municipality can't be blank")
      end

      it '番地が空だと保存できないこと' do
        @purchase_destination.street_address = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Street address can't be blank")
      end

      it '電話番号が空では保存できないこと' do
        @purchase_destination.tel = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Tel can't be blank")
      end

      it '電話番号が9桁以下の場合は保存できないこと' do
        @purchase_destination.tel = '123456789'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Tel should be 10 or 11 digit numbers")
      end
      
      it '電話番号が12桁以上の場合は保存できないこと' do
        @purchase_destination.tel = '123456789012'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Tel should be 10 or 11 digit numbers")
      end
      
      it '電話番号に半角数値以外が含まれている場合は保存できないこと' do
        @purchase_destination.tel = '12345a7890'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Tel should be 10 or 11 digit numbers")
      end

      it "tokenが空では登録できないこと" do
        @purchase_destination.token = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが紐づいていないと保存できないこと' do
        @purchase_destination.user_id = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが紐づいていないと保存できないこと' do
        @purchase_destination.item_id = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end

