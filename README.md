# README

## users

|Column          |Type      |Options                    |
|----------------|----------|---------------------------|
| nickname       | string   | null: false              |
| email          | string   | null: false, unique:true |
| password       | string   | null: false              |
| last_name.     | string   | null: false              |
| first_name.    | string   | null: false              |
| last_name_kana | string   | null: false              |
| first_name_kana| string   | null: false              |
| birth_date     | string   | null: false              |
| created_at     | datetime | null: false              |
| update_at      | datetime | null: false              |



### Association
has_many :items
has_many :orders


## items

|Column          |Type       |Options                         |
|----------------|-----------|--------------------------------|
| name           | string    | null: false                   |
| description    | text      | null: false                   |
| category       | string    | null: false                   |
| condition      | string    | null: false                   |
| shipping_charge| string    | null: false                   |
| prefecture     | string    | null: false                   |
| shipping_day   | string    | null: false                   |
| price          | string    | null: false                   |
| user_id        | integer   | null: false, foreign_key:true |
| created_at     | datetime  | null: false                   |
| update_at      | datetime  | null: false                   |



### Association

belongs_to :user
has_one :order


## orders

|Column      |Type      |Options                         |
|------------|----------|--------------------------------|
| user_id    | integer  | null: false, foreign_key:true |
| item_id    | integer  | null: false, foreign_key:true |
| created_at | datetime | null: false                   |
| updated_at | datetime | null: false                   |


### Association

belongs_to :user
belongs_to :item
has_one :shipping_information





## shipping_informations

|Column         |Type      |Options                       |
|---------------|----------|------------------------------|
| postal_code   | string   | null:false                   |
| prefecture    | string   | null:false                   |
| city          | string   | null:false                   |
| address       | string   | null:false                   |
| building_name | string   | null:true                    |
| phone_number  | string   | null:false                   |
| created_at    | datetime | null:false                   |
| updated_at    | datetime | null:false                   |
| order_id      | integer  | null:false, foreign_key:true |


### Association
belongs_to :order


