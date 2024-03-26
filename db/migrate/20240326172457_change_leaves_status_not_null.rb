class ChangeLeavesStatusNotNull < ActiveRecord::Migration[7.2]
  def change
    execute "update leaves set status = 'draft' where status is null"
    change_column_null :leaves, :status, false
  end
end
