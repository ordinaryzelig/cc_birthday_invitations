class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    execute 'CREATE EXTENSION citext'

    create_table :invitations do |t|
      t.citext :first_name
      t.citext :last_name
      t.citext :email
      t.integer :status, :default => 0, :null => false
      t.citext :code, :null => false

      t.timestamps
    end
  end
end
