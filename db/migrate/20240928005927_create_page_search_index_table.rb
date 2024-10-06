class CreatePageSearchIndexTable < ActiveRecord::Migration[8.0]
  def change
    create_virtual_table "page_search_index", "fts5", [ "body", "tokenize='porter'" ]

    Page.reindex_all
  end
end
