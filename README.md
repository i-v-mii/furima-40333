# DB 設計

## users table

| Column             | Type                | Options                   |
|--------------------|---------------------|---------------------------|
| nickname           | string              | null: false               |
| email              | string              | null: false, unique: true |
| encrypted_password | string              | null: false               |
| family_name        | string              | null: false               |
| first_name         | string              | null: false               |
| family_name_kana   | string              | null: false               |
| first_name_kana    | string              | null: false               |
| birthday           | date                | null: false               |


### Association

- has_many :items
- has_many :purchases


## items table

| Column                              | Type       | Options                        |
|-------------------------------------|------------|--------------------------------|
| product_name                        | string     | null: false                    |
| price                               | integer    | null: false                    |
| category_id                         | integer    | null: false                    |
| condition_id                        | integer    | null: false                    |
| delivery_charge_id                  | integer    | null: false                    |
| shipping_source_id                  | integer    | null: false                    |
| date_of_shipment_id                 | integer    | null: false                    |
| explanation                         | text       | null: false                    |
| user                                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase


## purchases table

| Column                | Type       | Options                        |
|-----------------------|------------|--------------------------------|
| user                  | references | null: false, foreign_key: true |
| item                  | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :destination

## destinations table

| Column                 | Type       | Options                        |
|------------------------|------------|--------------------------------|
| post_code              | string     | null: false                    |
| shipping_source_id    | integer    | null: false                    |
| municipality           | string     | null: false                    |
| street_address         | string     | null: false                    |
| building_name          | string     |                                |
| tel                    | string     | null: false                    |
| purchase               | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase