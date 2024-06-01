local ignore = {
	"111", -- setting non-standard global variable
	"212/_.*", -- unused argument, for vars with "_" prefix
	"214", -- used variable with unused hint ("_" prefix)
}

