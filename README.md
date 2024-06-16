# DB 設計

## users table

| Column             | Type                | Options                   |
|--------------------|---------------------|---------------------------|
| nickname           | string              | null: false               |
| email              | string              | null: false, unique: true |
| encrypted_password | string              | null: false               |
| family_name        | string              | null: false               |
| first_name         | string              | null: false               |
| birthday           | date                | null: false               |


### Association

* has_many :items

## items table

| Column                              | Type       | Options                        |
|-------------------------------------|------------|--------------------------------|
| category                            | string     | null: false                    |
| condition                           | string     | null: false                    |
| delivery_charge                     | string     | null: false                    |
| shipping_source                     | string     | null: false                    |
| date_of_shipment                    | string     | null: false                    |
| explanation                         | text       | null: false                    |
| user                                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :purchase


## purchases table

| Column                | Type       | Options                        |
|-----------------------|------------|--------------------------------|
| card_number_credit    | string     | null: false                    |
| date_of_expiry        | string     | null: false                    |
| security              | string     | null: false                    |
| destination           | text       | null: false, foreign_key: true |
| item                  | references | null: false, foreign_key: true |

### Association

- has_one :item
- has_one :destination

## destination table

| Column          | Type       | Options                        |
|-----------------|------------|--------------------------------|
| post_code       | string     | null: false                    |
| prefecture      | string     | null: false                    |
| municipalities  | string     | null: false                    |
| street_address  | string     | null: false                    |
| building_name   | text       | null: false                    |
| tel             | text       | null: false                    |

### Association

- belongs_to :purchase