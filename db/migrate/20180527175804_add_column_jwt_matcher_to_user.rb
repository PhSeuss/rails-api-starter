class AddColumnJwtMatcherToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :jwt_matcher, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
