Sequel.migration do
  change do
    alter_table :label_printers do
      add_column :header, File
      add_column :footer, File
    end
  end
end
