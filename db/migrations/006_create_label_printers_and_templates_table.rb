::Sequel.migration do
  up do
    create_table :label_printers do
      primary_key :id
      String :name
      String :label_type
    end

    create_table :templates do
      primary_key :id
      foreign_key :label_printer_id, :label_printers, :key => :id
      String :name
      String :description
      String :content
    end
  end

  down do
    drop_table(:templates)
    drop_table(:label_printers)
  end
end
