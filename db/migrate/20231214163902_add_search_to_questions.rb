class AddSearchToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :search, :string
  end
end
