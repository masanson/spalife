class AddIntroductionToEndUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :end_users, :introduction, :text, default: 'よろしくお願いします。'
  end
end
