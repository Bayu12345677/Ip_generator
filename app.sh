#!/usr/bin/bash

# Author  : polygon
# github  : https://github.com/Bayu12345677
# youtube : https://youtube.com/channel/UCtu-GcxKL8kJBXpR1wfMgWg

# plugins bash moderen
. lib/moduler.sh
# depencies
@require modules/main.conf.sh

var bg : '\e[1;41;37m'
var bg_info : '\e[1;41;32m'
var bg_err : '\e[1;42;31m'

def: exit_int() {
	echo
	Tulis.strN "${ku}[${bg}Speedrun${st}${ku}]${st} Ctrl-c detected"
	Tulis.strN "${ku}[${bg}Speedrun${st}${ku}]${st} script has stopped"; echo; exit
}
trap exit_int INT SIGINT
# checker ip
class checker
{
	public: app = locate;# mencari lokasi server ip tersebut
	public: app = live;# mengcek ip apakah hidup apa mati
}
{
	# definisi locate
	def: checker::locate() {
		global: __internet__proto = $(@return: $@);

		# search for hosting locations using whois
		var locat : $(whois $__internet__proto|grep "NetName"|sed 's;[[:space:]];'';g'|cut -d ":" -f2)
		%% validasi variable
		var locat : ${locat:-None}
		# display to screen
		try {
		  [[ ! -z "$locat" ]]
		  @return: locat
		} catch {
			dummy=
		}
	};
	 %% checker live ip
	def: checker::live() {
	  global: __internet__proto = $(@return: $@);
	  Tulis.strN "${ku}[\e[1;41;5;37mSpeedrun\e[0m${ku}]${pu} ${b}[\e[1;41;5;32mFOUND\e[0m${b}]${ku}-${me}>${pu} ${__internet__proto} ${un}-> ${bg}$(checker::locate $@)${st}";
	};

}
class.new: checker ip
try {
    command -v whois &> /dev/null
  } catch {
    apt-get install inetutils -y &> /dev/null
  }
#check depencies
var::array: depen = { "curl" "wget" "ncurses-utils" "dnsutils" }
for depencies in ${depen[@]}
    do
    try {
  		  command -v ${depencies} &> /dev/null
  	  } catch {
  		  try {
  			  apt-get install ${depencies} -y &> /dev/null
  		  } catch {
  			  println_info " failed to install ${depencies}"; exit $?
  		  };
  	  }
    done

    class main
    {
	public: app = banner;
	public: app = run;
}
    {
	
	def: main::banner() {
		Tulis.strN "${cy}◈${ku} Author   ${me}:${hi} polygon\n${un}◆${ij} github   ${me}:${hi} Bayu12345677\n${ij}◈ ${cy}youtube  ${me}: ${m}pejuang kentang\n${cy}● ${ku}language ${me}:${hi} Bash${st}"; echo; echo

		Tulis.strN "${ku}•${pu} Info script  ${me}:${pu} Generator ip"
		Tulis.strN "${ku}•${pu} lookup using ${me}:${pu} whois ${ij}(${me}inetutils${ij})${st}"
		Tulis.strN "${ku}•${pu} checker ip   ${me}:${pu} host ${ij}(${me}dnsutils${ij})${st}"
		
	};

	def: main::run() {
		clear; main::banner
		echo; echo

		if [[ ! -d "FOUND/" ]]; then %% validasi derectory FOUND
			Tulis.str "${ku}[${me}?${ku}]${pu} make derectory found "
			if (mkdir FOUND &> /dev/null); then
				Tulis.str "${ku}[\e[1;41;37mCOMPLETE\e[0m${ku}]${st}"
			else
				Tulis.str "${ku}[\e[1;41;37mFAILED\e[0m${ku}]${st}"
			fi;
		fi; echo

		Tulis.str "\r${ku}[${bg}Speedrun${st}${ku}]${pu} Checking internet "
		sleep 1
		try {
			curl -s "google.com" &> /dev/null
			Tulis.str "${ku}[${st}${bg_info}Complete${st}${ku}]${st}"
		} catch {
			echo
			println_info " internet not found"; exit
		};echo
			Tulis.strN "${ij}[\e[1;41;37mSpeedrun${st}${ij}] ${pu}start printing ip${st} ${me}:${st} ${cy}[${bg_info}looking for valid ip${st}${cy}]${st}"
			echo
			var i : 0
			var a : 0
			let value=5000
			while ((i<=value)); do
				let i++
				let a++
				var::command ip = create.ip
				for x in {1..1}; do
					whois $ip &> /dev/null
					#declare headers=(
					#	'content-type: application/json'
					#	'sec-ch-ua: "Google Chrome";v="93", " Not;A Brand";v="99", "Chromium";v="93"'
					#	'origin: https://www.nslookup.io'
					#	'sec-fetch-site: same-origin'
					#	'sec-fetch-mode: cors'
					#	'sec-fetch-dest: empty'
					#); var data : "{\"domain\":\"${ip}\",\"dnsServer\":\"cloudflare\"}"
					 # cloudflare=$(
					  #				curl -sX POST -L --tcp-fastopen --tcp-nodelay https://www.nslookup.io/api/v1/records \
					  #				-H "${headers[0]}" \
					  #				-H "${headers[1]}" \
					  #				-H "${headers[2]}" \
					  #				-H "${headers[3]}" \
					  #				-H "${headers[4]}" \
					  #				-H "${headers[5]}" -d "${sa}" --insecure --compressed | jq . | 
					  #			)
					# Tulis.str "\r${cy}[${me}◆${ij}◆${cy}]${pu} looking for valid ip ${ku}[${pu}Proses${me}:${hi}${i}${ku}]${cy} ${iframe:a:1}"
					var validasi : $(host $ip|grep -o "not")
					if [[ $validasi == not ]]; then
						dummy=
					else
						ip.live ip
						locate=$(ip.locate ip)
						echo "$ip = [${locate:-None}]" >> FOUND/ip.txt
					fi;
				done
						if [[ $a == ${#iframe} ]]; then
							var a : 0
						fi;
				done;
	}
}
    class.new: main command

    Namespace: app.sh
    {
	var this : $(IO.func);
	var::command port = create.port
}
    try {
		$this.NAME command.run && command.run
		echo
		Tulis.strN "${un}•${pu} process has been completed"
		Tulis.strN "${un}•${pu} my contacts ${me}:${bg}+6285731184377${st}"
		Tulis.strN "${un}•${pu} tanks has put on my tool :)"; echo; exit $?
	} catch {
		true
	}
