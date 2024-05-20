//GameManager.canMove = true;
//GameManager.alarms[0][0] = 30;
if (array_length(global.nextdialog) > 0) {
    instance_create_depth(x, y, -99, oDialog, global.nextdialog[0]);
	array_shift(global.nextdialog);
}