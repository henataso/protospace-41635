class AddUserAndPrototypeToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :users
    add_reference :comments, :prototypes
  end
end