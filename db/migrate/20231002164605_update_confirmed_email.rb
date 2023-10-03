class UpdateConfirmedEmail < ActiveRecord::Migration[7.0]
  def up
    User.update_all confirmed_at: DateTime.now
  end
end
