class AddFieldCrimagifySchemaToSimpleUserUsers < ActiveRecord::Migration
  def change
    add_column :simple_user_users, :crimagify_schema, :string
  end
end
