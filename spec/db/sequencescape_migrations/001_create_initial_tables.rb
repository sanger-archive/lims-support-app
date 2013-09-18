::Sequel.migration do
  change do
    create_table "assets" do
      primary_key :id
      String      :barcode
    end

    add_index "assets", [:barcode], :name => "index_assets_on_barcode"

    create_table "asset_barcodes" do
      primary_key :id
    end
  end
end
