# README
テーブル設計

## users テーブル
| Column          | Type    | Options |
|--------------–--|--------|---------|
| nickname         | string  | null: false              |
| email           | string  | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name       | string  | null: false               |
| first_name      | string  | null: false               |
| last_name_kana  | string  | null: false               |
| first_name_kana | string  | null: false               |
| birthday        | date    | null: false |

## 🔗 Association
- has_many :items
- has_many :orders
- has_many :comments

---

## items テーブル
| Column        | Type       | Options |
|--------------|------––-----|----–––––––––––––––––––––––-----|
| image        | string      | null: false                    |
| name         | string      | null: false                    |
| description  | text        | null: false                    |
| category_id  | integer     | null: false                    |
| condition_id | integer     | null: false                    |
| shipping_fee_id | integer  | null: false                    |
| prefecture_id | integer    | null: false                    |
| delivery_day_id | integer  | null: false                    |
| price        | integer     | null: false                    |
| user         | references  | null: false, foreign_key: true |

#### 🔗 Association
- belongs_to :user
- has_one :order
- has_many :comments

---

## orders テーブル
| Column  | Type       | Options |
|--------|-----------|---------|
| user | references | null: false, foreign_key: true |
| item | references | null: false, foreign_key: true |

#### 🔗 Association
- belongs_to :user
- belongs_to :item
- has_one :address

---

## addresses テーブル
| Column        | Type    | Options |
|--------------|--------|---------|
| post_code    | string  | null: false |
| prefecture_id | integer  | null: false                   |
| city         | string    | null: false                   |
| street_address | string  | null: false                   |
| building_name | string   |                               |
| phone_number  | string   | null: false                   |
| order     | references | null: false, foreign_key: true  |

#### 🔗 Association
- belongs_to :order

## Comments テーブル
| Column   | Type       | Options                          |
|---------|-----------|----------------------------------|
| content | text       | null: false                     |
| user    | references | null: false, foreign_key: true  |
| item    | references | null: false, foreign_key: true  |

#### **🔗 Association**
- belongs_to :user
- belongs_to :item