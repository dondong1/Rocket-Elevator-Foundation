# Week 9 - Consolidation of Achievements

Improve de application rails and RestAPI

Deployed URL:  https://dondongnguyen.com   

Deployed RESTAPI on Heroku   https://donnguyen.herokuapp.com/api/Interventions

RESTAPI Git Repo: https://github.com/dondong1/Rocket_ELevators_RESTAPI.git

WEB APP REPO: https://github.com/dondong1/Rocket-Elevator-Foundation.git

PRESENTATION VIDEO: https://drive.google.com/file/d/1FAH57OnZ5hbZbIneiU9m_rcNy58Zx_GP/view?usp=sharing


#### First Create a scaffold intervention
It's generate views, model, controller and migration
```sh 
rails generate scaffold Intervention
```
#### Modify the model intervention
Explanations to comments in the code block
```rb
class Intervention < ApplicationRecord
  #belongs_to link to the intervention to other tables, the name of column is the table_id
  # for exemple for :customer the name of the column in the table interventions is customer_id
  belongs_to :customer
  belongs_to :building
  belongs_to :battery, optional: true
  belongs_to :column, optional: true
  belongs_to :elevator, optional: true
  belongs_to :employee, optional: true
  belongs_to :author, class_name: "Employee"    #class name permit to link the author_id to a employee
  
end
```
#### Modify the models who belongs the table intervention
Explanations to comments in the code block
We take the model employee for exemple:
```rb
class Employee < ApplicationRecord
  belongs_to :user
  has_many :batteries
  has_many :interventions   #has_many permit to have multiples interventions

  # Method for format how we show in the dropdown form
  def full_name
    "#{first_name} #{last_name}"
  end
end
```

#### Modify the migration of create intervention
Explanations to comments in the code block
```rb
class CreateInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      #the method :default permit to put a default value when the intervention is create
      t.datetime :start_date_intervention, :default => nil
      t.datetime :end_date_intervention, :default => nil
      t.string :result, :default => "Incomplete"
      t.text :report
      t.string :status, :default => "Pending"

      t.timestamps
    end
  end
```

#### Create a migration for add references to the database
```sh
rails g migration AddInterventionReference
```
Explanations to comments in the code block
```rb
class AddInterventionReference < ActiveRecord::Migration[5.2]
  def change
    add_reference :interventions, :customer, foreign_key: true
    add_reference :interventions, :building, foreign_key: true
    add_reference :interventions, :battery, foreign_key: true
    add_reference :interventions, :column, foreign_key: true
    add_reference :interventions, :elevator, foreign_key: true
    add_reference :interventions, :employee, foreign_key: true
    add_reference :interventions, :author, foreign_key: {to_table: :employees}
  end
end

## Request Rest API
#### Generate Model & Controller Intervention
dotnet ef dbcontext scaffold "Server=localhost;Port=3306;Database=RailsApp_development;Uid=root;Pwd=Codeboxx1!;" Mysql.Data.EntityFrameworkCore -o Models -f

(-f for forcing to overwrite those current tables - if clean scaffold then no need -f at the end)

#### First Request
GET: Returns all fields of all Service Request records that do not have a start date and are in "Pending" status.

#### Second Request
PUT: Change the status of the intervention request to "InProgress" and add a start date and time (Timestamp).

#### Third Request
PUT: Change the status of the intervention request to "InProgress" and add a start date and time (Timestamp).



