if (os_type != os_android) {
    instance_destroy();
}
dpad = input_virtual_create();
dpad.dpad(undefined, "left", "right", "up", "down", true);
accept = input_virtual_create();
accept.button("accept");
cancel = input_virtual_create();
cancel.button("cancel");