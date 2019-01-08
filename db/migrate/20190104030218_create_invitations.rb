class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    enable_extension :citext

    create_table :invitations do |t|
      t.citext :first_name
      t.citext :last_name
      t.citext :email
      t.integer :status, :default => 0, :null => false
      t.citext :code, :null => false
      t.string :dj_name

      t.timestamps
    end

    add_index :invitations, :code, :unique => true
  end
end
