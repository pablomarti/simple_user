# This migration comes from simple_user (originally 20130312226960)
class RolifyCreateRoles < ActiveRecord::Migration
  def change
    create_table(:roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_roles, :id => false) do |t|
      t.references :simple_user_admin_user
      t.references :role
    end

    add_index(:roles, :name)
    add_index(:roles, [ :name, :resource_type, :resource_id ], :name => "roles_n_rt_rid")
    add_index(:users_roles, [ :simple_user_admin_user_id, :role_id ], :name => "user_role_i_auid_urid")
  end
end