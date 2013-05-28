# This migration comes from simple_user (originally 20130312215950)
class CreateSimpleUserAuthentications < ActiveRecord::Migration
  def change
    create_table :simple_user_authentications do |t|
      t.string :provider
      t.string :token
      t.string :uid
      t.references :user

      t.timestamps
    end
    add_index :simple_user_authentications, :user_id
  end
end
