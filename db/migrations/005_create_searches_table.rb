::Sequel.migration do
  up do
    create_table? :searches do
      primary_key :id
      String :description
      String :filter_type
      String :model
      blob :filter_parameters
    end
  end

  down do
    drop_table(:searches)
  end
end
