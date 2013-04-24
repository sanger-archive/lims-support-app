::Sequel.migration do
  up do
    create_table? :labellables do
      primary_key :id
      String :name
      String :type
    end

    create_table? :labels do
      primary_key :id
      foreign_key :labellable_id, :labellables, :key => :id
      String :type
      String :position
      String :value
    end
  end

  down do
    drop_table(:labels)
    drop_table(:labellables)
  end
end
