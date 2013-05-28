::Sequel.migration do
  up do
    create_table(:kits) do
      primary_key :id
      String :process
      String :aliquot_type
      Date :expires
      Integer :amount
    end
  end

  down do
    drop_table(:kits)
  end
end
