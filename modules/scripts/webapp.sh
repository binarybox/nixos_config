name=$1
url=$2

if [ -z $name ]; then
	echo "name not set"
	echo "first parameter must be the name"
	exit 1
fi

if [ -z $url ]; then
	echo "url not set"
	echo "second parameter must be a url"
	exit 1
fi

folder=$PWD/.config/webapp/$name

if [ ! -d $folder ]; then
	mkdir -p $folder
	mkdir -p $folder/chrome
	touch $folder/user.js
	touch $folder/chrome/userChrome.css
	echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);' >> $folder/user.js
	echo '@namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul");
	#TabsToolbar {visibility: collapse;}
	#navigator-toolbox {visibility: collapse;}
	browser {margin-right: -14px; margin-bottom: -14px;}"' >> $folder/chrome/userChrome.css
	echo "$name does not exist"
fi

firefox --profile $folder $url
