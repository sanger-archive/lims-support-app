::Sequel.migration do
  up do
    create_table(:uuid_resources) do
      primary_key :id
      String :uuid, :fixed => true, :size => 64
      String :model_class
      Integer :key
    end
  end

  down do
    drop_table(:uuid_resources)
  end
end
