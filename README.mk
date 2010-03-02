erlips is a demonstration project for erlang otp development.
you can learn how to develop an practial erlang application. this 
project is for the fourth ECUG (Erlang China User Conference).

First you must install the erlang otp, just got the erlang otp offical
website to download the source tarball. http://www.erlang.org.

our erlips also use the mochiweb as the http server tookit, so you need to 
download that code. we supply a tiny shell scripts to install the mochiweb codes for you.
you just run the shell with root premission: # ./install_mochiweb.sh

Third, you must has the geoip binary database file, you can get it 
use the script scripts/get_geoip.sh : # ./get_geoip.sh

after above operaction, you can compile and run the erlips:
	$ make test && make
	$ ./erlipsctl live

now you can access our ip services by broswer or curl:

	$ curl http://localhost:8080/ips/geoip?ip=200.10.0.1

if you want build a release by reltool, you can use the erlips/release/gen_release script,
in the first step, makesure change the line '''{lib_dirs, ["/home/litao/codes/myproj/2009"]},''',
the lib_dirs must be your local erlips parrent directory. based the original erlips.config lib_dirs
my directory tree is:

	/home/litao/codes/myproj ---
							 |-2009
							 	|-erlips
