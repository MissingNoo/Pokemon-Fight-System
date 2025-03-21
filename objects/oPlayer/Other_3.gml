PlayerData.inventory_data = "";
array_foreach(PlayerData.inventory.items, function(e, i) {
	PlayerData.inventory_data = string_concat(PlayerData.inventory_data, ";", e.name, ":", e.quantity);
});
struct_remove(PlayerData, "inventory");
json_save(PlayerData, "pdata.gme");