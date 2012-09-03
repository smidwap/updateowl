class AddSpanishTranslation < ActiveRecord::Migration
  def change
    add_column :parents, :spanish_speaking, :boolean, default: false
    add_column :messages, :spanish_body, :text
  end
end
