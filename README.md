WPTool
======

The WPtool is suite of (SSH) bash functions to administer Wordpress installs. With this tool you will be able to determine problems and make changes that we find to be most common among Wordpress users.

**Features**

* Auto removal of tool once SSH session ends.
* Login as any user on the site, or make a new user. (wpuser)
* Reinstall/fix core files in a single command (wpcore)
* Fix common problems and htaccess issues (wpfix/wpht)
* Test for issues and find problems (wptests/wptrace)
* Show the latest site errors (wperr)
* List and change theme (wptheme)
* List and activate/deactivate plugins (wpplug)
* Change the url address and update that url in posts (wpurl)
* Quickly backup and restore the site (wpbackup/wprestore)
* Scan for malware (wpscan)
* Man pages for each command for quick syntax references:
    command -h


##How to load it

Once you have made a SSH connection to an account with wordpress installed run this command:

    . <(curl -sS https://raw.githubusercontent.com/bagley/wptool/master/wptool)

If the toolkit has been enabled you should have a response like this:

> Injected WPtool into current bash session. For details, type 'wptool'.
>
> Recent Changes:
>     [Any important changes or new features are displayed here]

If you would like to use newer features you can use the devel branch. Or you can easily use previous versions. Useful if you find something broken that was working before. See the Developent Versions and Previous Versions sections for move info.

*Hosting Note: If you plan on putting wptool on your own server/website, like onto a hosting account you have, please see the note in the "Hosting WPTool" section before doing so.*


##Commands

Here is a list of all the commands and how to use them.

###wptool
This tool shows a quick guide and lists the commands injected by the wptool kit.

    wptool

---------

###wpstats

This tool returns a basic overview of the Wordpress install.

    wpstats

---------

###wpurl

This tool returns the current URL settings in the database, or updates them to a specified URL. It can also be used to replace existing urls in posts (useful in site moves).

Show the site's url:

    wpurl

Change the site to a different url:

    wpurl url

Search and replace every instance of oldurl with newurl in the posts and postsmeta tables.

    wpurl oldurl newurl

Set the siteurl to [url]

	--setsite [url]   

Set the homeurl to [url]

	--sethome [url]
  
You may also use --site and --home to get just the siteurl and home.

*Note: If the URL does not start with 'http://' or 'https://' it will automatically be prepended with 'http://'..*

---------

###wptheme

This tool returns the current theme, as well as listing any available ones found in the wp-content/themes folder. It also can change to a specified stylesheet, template, both, or to a new copy of twentytwelve.

Outputs the current used theme and available themes to choose from:

    wptheme

Update theme and style sheet to new theme

    wptheme ThemeName

Update wordpress style sheet only

    wptheme ThemeName -s

Update the template only

    wptheme ThemeName -t

Installs a brand new twentytweleve theme for testing and renames the old one. Useful if none of the themes are working.

    wptheme fresh

---------

###wpdb

This tool tests the database connectivity based on settings in the wp-config.php file, and can import/export a database based on its settings.

List database name, credentials, hostname, and other information.

    wpdb

Uses wp-config.php to import database.

    wpdb -i file

exports current database to wordpress home.

    wpdb -e FIle

-------

###wpplug

This tool does basic plugin functions, such as displaying active and available plugins, or disabling them all.

List currently enabled/disabled plugins of the current install.

    wpplug

Disables plugins by renaming the plugin folder

    wpplug -d


---------

###wpht

This tool uses wordpress to create a fresh .htaccess file with required wordpress settings. Please note that the original .htaccess is renamed. This command has no options.

    wpht

--------


###wpcore

This tool downloads the latest core, a new core of the current version, or a specified version while leaving wp-config.php and wpcontent untouched.

Only download the latest archive of core files for wordpress.

    wpcore

Download and install/replace the core wordpress files based on the version specified in wp-includes/version.php

    wpcore cur

Download and install/replace the core wordpress files based on the database version. Useful if enough wordpress files are missing that the above 'cur' method can't figure out the version number, or is getting the wrong version number.

    wpcore db

Download and install/replace the newest version of the core wordpress files. This option can also be used to install a brand new wordpress version.

    wpcore new

Download and install/replace a specific version of the Wordpress core, in the form of #.#.#

    wpcore #.#.#
    
    # example:
    wpcore 4.0.0

-------

###wpfix

This tool runs various built-in Wordpress functions and fixes. It has no options.

Generate a fix report

    wpfix

---------

###wpuser

This tool performs various user functions, including creating access links to allow you to enter wordpress as any user, returning info for a specified user, changing usernames, passwords, changing a user to an admin, creating new admin users, and deleting users.

Return a list of current users/ID# for that wordpress install.

    wpuser

Create a link that will allow you to enter the  WordPress site as the given user in your chosen browser.

    wpuser USERID -l
    # example: get a link to login as user 1
    wpuser 1 -l

 Return details about specified user USERID
     
    wpuser USERID
    # example: get the info of user 1
    wpuser 1
    
Change username of user USERID to NAME

    wpuser USERID -u NAME
    # example: change the name of user 1 to mark
    wpuser 1 -u mark

Change password of user USERID to PASS 

    wpuser USERID -p PASS
    # example: change the password of user 4
    wpuser 4 -p My@New%Prase!

Promote user USERID to admin 

    wpuser USERID -a

Delete user USERID 

    wpuser USERID -d

Create a new admin user. The user will be called 'deleteme' and will be given a random password.

    wpuser -n
    wpuser new

-----

###wperr

This tool shows the last few lines of the error_log and wp-admin/error_log if they exist. It has no options.

    wperr

--------

###wpscan

This tool will scan the site for signs of malware. Note that is is **not** a complete solution. It only helps you out in determining if you have breaking. It does not fix it. It will give you several false positives. But it's helpful.

*Note! Scanning can take a huge amount of cpu and disk drive. If you abuse your provider's resources, they may shut you down.*

Scans the core files, plugins, and themes:

    wpscan quick

Scan all files in the current directory and down:

    wpscan full

Only show the actual phrase being matched. Not the whole line:

    wpscan [quick|full] quiet

wpscan uses strings to find bad files. By default it will load a default set when a scan is run, if none are already loaded.

In short, the following methods are optional.

Show a list of the scan strings that are currently loaded.

	wpscan show-strings
		
Optional method to set the strings back to the default list. Optionally specify devel or alpha to use the strings located in those branches. They might be new, or they might not.

	wpscan default-strings [devel|alpha]

You may also override the strings with your own set(s).

Set any custom strings to this variable to be included in the scan. Use single quotes (') and separate each with a '\n':

  extra_strings='strings'
  
For example:

  # first set the extra strings to use:
  extra_strings='string1\nstring2\nstring3'
  # then run the scan. It will automatically add the strings to the current list.
  wpscan full

Load your own strings from the given address. See the scanstrings file for an example. Default strings are not be added if you do this first, as they are only loaded on a empty string list. So do this after loading the default strings if you want to use those.

	wpscan add-strings [url]

Clear out all scan strings.

	wpscan clear-strings


---------		

###wpbackup

This tool creates a backup of db and/or files.

    wpbackup [files|db|all]

Makes a backup of files.		 

    wpbackup files

Makes a backup of the database.		 

    wpbackup db|database

Makes a backup of database and files.		 

    wpbackup all

------

###wprestore

This too restores the database. It is a shortcut to wpdb -i /file.

    wprestore [db|forcedb|forcegz]

Restores from a regular .sql/.sql.gz file.		  

    wprestore db <file>

Restores from a sql file w/o checking it's type.		 

    wprestore forcedb <file>

Restores from a sql.gz file w/o checking it's type.	 

    wprestore forcegz <file>

--------

###wpver

This tool shows the WordPress file and database versions.

---------


##Previous Versions

This is how to use previous versions, which is useful if I change or break something (I am human). As we are using git, it makes it trivial to to this.

####Browse for the file

This way may be the simplest. Either click on Commits or Releases, and then click the one you want. Then click on the 'wptool' file. It will shows the code, but we want the Raw file. So click where it says Raw. It will then show the file. Copy the link and replace ADDRESS with it below:

    . <(curl -sS ADDRESS)

####By Version

To use a particular version number, just substitute VERSION below with the version you would like to use:

    . <(curl -sS https://raw.githubusercontent.com/bagley/wptool/VERSION/wptool)

For example, to use version v1.7.5.1 we would use:

    . <(curl -sS https://raw.githubusercontent.com/bagley/wptool/v1.7.5.1/wptool)

####By Commit

 You can either browse the commits and get the file path, or if you get the commit hash just put it in:

    # put the hash in where <commit> is:
    . <(curl -sS https://raw.githubusercontent.com/bagley/wptool/<commit>/wptool)

For example, to use commit b0381758e548cb8bf6bca8ef209ff4869dca89ff we would use:

    . <(curl -sS https://raw.githubusercontent.com/bagley/wptool/b0381758e548cb8bf6bca8ef209ff4869dca89ff/wptool)

--------

##Development Versions

The devel and alpha branches contain the most recent changes that are being tested out before rolling out a release. I do this because the main code is constantly being used by people on various sites. I can't just roll out a change and "hope for the best."

####Development Branch

The Development branch (devel) is code that while being new, has been tested and used by me. It may still have issues, but most of the bugs should be gone.

If you would like to try the devel branch, we just substitute "devel" for "master" in the regular link, as follows:

    . <(curl -sS https://raw.githubusercontent.com/bagley/wptool/devel/wptool)

#### Alpha Branch

The Alpha branch (alpha) is where I put the most recent changes. Just so you know, the code here is usually not tested, and may contain lots of bugs. It may be completely broken and not even load.

But if you want the latest and greatest, or you want to help out, or you are just feeling brave, you can load it with the following line:

    . <(curl -sS https://raw.githubusercontent.com/bagley/wptool/alpha/wptool)

------

##Hosting WPTool

WPTool is free software, and you are welcome to copy it to your host/website/etc as you see fit.

Just know that you don't have to host wptool to use it. Just run the command under "How to load it" and you will have the necessary tools.

The only issue with hosting is that "scanstrings" file has strings in it that a hosting provider may think are bad. But these strings are just to look for bad website files. And they don't have any effect if you just load the program as described in "How to load it." They only can effect your hosting account if you copy the "scanstrings" file onto the actual account.

WPTool itself does not have any of these strings. I kept them separate on purpose.

So before you copy the "scanstrings" file onto your hosting account, you need to verify with your hosting provider whether or not they are going to flag it. Or just copy WPTool over, and it will fetch the file from here. Also note that the .git folder will contain these strings.

Again, the strings have no effect on the accounts that the script is loaded into, only if you actually copy the "scanstrings" file onto the hosting account's filesystem. When we only load the strings via the wpscan command, we are only loading it into the user's shell. When the shell is closed, the whole program with the strings are cleared out.

--------

##Credits

Developers: Thomas Bradshaw and Matt Bagley

Script pimp: Jacob Cloutier 

Checked and approved by RVD, Brent Lundell and Jason Earl.

This version/fork is maintained by Matt Bagley.
