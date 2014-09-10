class AddChallengedIdToUser < ActiveRecord::Migration
  def change
    add_column :hangmen, :challenged_id, :integer
  end
end
