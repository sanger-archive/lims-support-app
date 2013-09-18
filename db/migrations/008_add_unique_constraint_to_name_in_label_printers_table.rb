Sequel.migration do
  change do
    alter_table :label_printers do
      add_unique_constraint [:name]
    end
  end
end
