class AddUserAndPrototypeToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :user_id, :integer
    add_reference :comments, :prototype_id, :integer
  end
end
