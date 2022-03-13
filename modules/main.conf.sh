#!/usr/bin/bash

# plugins bash moderen
. lib/moduler.sh
# depencies
Bash.import: util/io.class util/IO.FUNC
Bash.import: util/operator
Bash.import: util/IO.TYPE util/tryCatch

  bi=$(mode.bold: biru)    cy=$(mode.bold: cyan)
  ij=$(mode.bold: hijau)  hi=$(mode.normal: hitam)
  me=$(mode.bold: merah)  un=$(mode.bold: ungu)
  ku=$(mode.bold: kuning) pu=$(mode.bold: putih)
  m=$(mode.bold: pink)    st=$(default.color)

class build;
{
	public: app = ip
	public: app = port

	def: build::ip() {
		echo $(($RANDOM % 250)).$(($RANDOM % 250)).$(($RANDOM % 250)).$(($RANDOM % 250))
	};

	def: build::port() {
		var random : $RANDOM
		((create_port = random - 8))
		@return: create_port
	}
}; class.new: build create
