set_global_assignment -entity "pllsystem" -library "lib_pllsystem" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "pllsystem" -library "lib_pllsystem" -name IP_TOOL_VERSION "19.1"
set_global_assignment -entity "pllsystem" -library "lib_pllsystem" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_pllsystem" -name SPD_FILE [file join $::quartus(sip_path) "pllsystem.spd"]

set_global_assignment -library "lib_pllsystem" -name MISC_FILE [file join $::quartus(sip_path) "pllsystem_sim/pllsystem.vho"]
