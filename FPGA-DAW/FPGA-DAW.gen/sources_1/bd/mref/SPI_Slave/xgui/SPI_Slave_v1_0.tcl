# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "SPI_MODE" -parent ${Page_0}


}

proc update_PARAM_VALUE.SPI_MODE { PARAM_VALUE.SPI_MODE } {
	# Procedure called to update SPI_MODE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SPI_MODE { PARAM_VALUE.SPI_MODE } {
	# Procedure called to validate SPI_MODE
	return true
}


proc update_MODELPARAM_VALUE.SPI_MODE { MODELPARAM_VALUE.SPI_MODE PARAM_VALUE.SPI_MODE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SPI_MODE}] ${MODELPARAM_VALUE.SPI_MODE}
}

