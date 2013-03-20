::Sequel.migration do
  up do
    create_table(:barcodes) do
      primary_key :id
      String :labware
      String :role
      String :contents
    end
  end

  down do
    drop_table(:barcodes)
  end
end