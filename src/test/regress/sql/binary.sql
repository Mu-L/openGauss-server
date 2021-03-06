SET synchronous_commit = on;

execute direct on (datanode1)'SELECT ''init'' FROM pg_create_logical_replication_slot(''regression_slot'', ''test_decoding'');';
-- succeeds, textual plugin, textual consumer
execute direct on (datanode1)'SELECT data FROM pg_logical_slot_get_changes(''regression_slot'', NULL, NULL, ''force-binary'', ''0'', ''skip-empty-xacts'', ''1'');';
-- fails, binary plugin, textual consumer
execute direct on (datanode1)'SELECT data FROM pg_logical_slot_get_changes(''regression_slot'', NULL, NULL, ''force-binary'', ''1'', ''skip-empty-xacts'', ''1'');';
-- succeeds, textual plugin, binary consumer
execute direct on (datanode1)'SELECT data FROM pg_logical_slot_get_binary_changes(''regression_slot'', NULL, NULL, ''force-binary'', ''0'', ''skip-empty-xacts'', ''1'');';
-- succeeds, binary plugin, binary consumer
execute direct on (datanode1)'SELECT data FROM pg_logical_slot_get_binary_changes(''regression_slot'', NULL, NULL, ''force-binary'', ''1'', ''skip-empty-xacts'', ''1'');';

execute direct on (datanode1)'SELECT ''init'' FROM pg_drop_replication_slot(''regression_slot'');';
