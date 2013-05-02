class CreateStaticDocsPages < ActiveRecord::Migration
  def change
    create_table :static_docs_pages do |t|
      t.string :title
      t.string :path
      t.mediumtext :body
      t.string :extension

      t.timestamps
    end
  end
end
