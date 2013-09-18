::Sequel.migration do
  change do
    create_table "seq_dnaplate" do
      primary_key :id
      Integer     :nextval
    end
  end
end
