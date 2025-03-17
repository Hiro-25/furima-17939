# README
テーブル設計

## users テーブル
| Column          | Type    | Options |
|----------------|--------|---------|
| id            | integer | PK, 自動生成 |
| nickname      | string  | null: false |
| email         | string  | null: false, unique: true |
| encrypted_password | string | null: false |

## 🔗 Association
- has_many :items
- has_many :purchases

---

## items テーブル
| Column        | Type       | Options |
|--------------|-----------|---------|
| id           | integer   | PK, 自動生成 |
| name         | string    | null: false |
| description  | text      | null: false |
| price        | integer   | null: false |
| user_id      | references | null: false, foreign_key: true |

#### 🔗 Association
- belongs_to :user
- has_one :purchase

---

## purchases テーブル
| Column  | Type       | Options |
|--------|-----------|---------|
| id     | integer   | PK, 自動生成 |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

#### 🔗 Association
- belongs_to :user
- belongs_to :item
- has_one :address

---

## addresses テーブル
| Column        | Type    | Options |
|--------------|--------|---------|
| id           | integer | PK, 自動生成 |
| post_code    | string  | null: false |
| prefecture   | string  | null: false |
| city         | string  | null: false |
| street_address | string  | null: false |
| purchase_id  | references | null: false, foreign_key: true |

#### 🔗 Association
- belongs_to :purchase