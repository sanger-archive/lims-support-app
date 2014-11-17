Sequel.migration do
  change do
    alter_table :barcodes do
      add_column :print_count, Integer, :default => 0
    end
  end
end
