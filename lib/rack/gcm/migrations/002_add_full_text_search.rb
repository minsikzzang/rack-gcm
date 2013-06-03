Sequel.migration do
  up do
    add_column :gcm_devices, :tsv, 'TSVector'
    add_index :gcm_devices, :tsv, type: "GIN"
    create_trigger :gcm_devices, :tsv, :tsvector_update_trigger,
      args: [:tsv, :'pg_catalog.english', :token, :alias, :locale, :timezone],
      events: [:insert, :update],
      each_row: true
  end

  down do
    drop_column :gcm_devices, :tsv
    drop_index :gcm_devices, :tsv
    drop_trigger :gcm_devices, :tsv
  end
end
