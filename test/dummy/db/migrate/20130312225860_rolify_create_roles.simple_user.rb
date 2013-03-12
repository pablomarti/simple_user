# This migration comes from simple_user (originally 20130312226960)
class RolifyCreateSimpleUserRoles < ActiveRecord::Migration
  def change
    create_table(:simple_user_roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:simple_user_users_roles, :id => false) do |t|
      t.references :simple_user_admin_user
      t.references :simple_user_role
    end

    add_index(:simple_user_roles, :name)
    add_index(:simple_user_roles, [ :name, :resource_type, :resource_id ])
    add_index(:simple_user_users_roles, [ :simple_user_admin_user_id, :simple_user_role_id ])
  end
end