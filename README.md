WPTool
======

The WPtool is suite of (SSH) bash functions to administer Wordpress installs. With this tool you will be able to determine problems and make changes that we find to be most common among Wordpress user. I will be showing you how to enable the WPtool Toolkit as well as commands you can run.

Once you have made a SSH connection to an account with wordpress installed run this command:

    . <(curl -sS https://raw.githubusercontent.com/bagley/wptool/master/wptool)

If the toolkit has been enabled you should have a response like this:

> Injected WPtool into current bash session. For details, type 'wptool'.

Commands and features

Features:

1. Auto removal of tool once SSH session ends. 

2. Man pages for each command for quick syntax references. Command --help

***Commands***

**wptool:** A quick guide to a list of commands injected by the wptool kit.

> wptool

**wpstats:** This tool returns a basic overview of the Wordpress install.

*Usage*

wpstats flag

General wordpress overview

Additional Flags: None

**wpurl:** This tool returns the current URL settings in the database, or updates them to a specified URL.

Usage

wpurl flag

Current Wordpress URL

Additional Flags:

wpurl url

URL to change the site to. If the URL does not start with 'http://' or 'https://' it will automatically prepend 'http://'.

**wptheme:** This tool returns the current theme, as well as listing any available ones found in the wp-content/themes folder. It also can change to a specified stylesheet, template, both, or to a new copy of twentytwelve.

Usage

    wptheme flag

Outputs current used theme and available themes to choose from.

Additional Flags:

    wptheme Name

Update theme and style sheet to new theme

    wptheme Name -s

Update wordpress style sheet only

    wptheme Name -t

Update the template only

    wptheme fresh

Installs a brand new twentytweleve theme for testing and renames the old one

wpdb: This tool tests the database connectivity based on settings in the wp-config.php file, and can import/export a database based on its settings.

Usage

    wpdb flag

Lists out database connection information.

Additional Flags

    wpdb -i file

Uses wp-config.php to import database.

    wpdb -e FIle

exports current database to wordpress home.

wpplug: This tool does basic plugin functions, such as displaying active and available plugins, or disabling them all.

Usage

    wpplug flag

Lists currently enabled/disabled plugins of the current install.

Additional Flags

    wpplug -d

Disables plugins by renaming the plugin folder

wpht: This tool uses wordpress to create a fresh .htaccess file with required wordpress settings. Please note that the original .htaccess is renamed.

Usage

    wpht flag

Renames and recreates .htaccess file.

Additional Flags: None

wpcore: This tool downloads the latest core, a new core of the current version, or a specified version while leaving wp-config.php and wpcontent untouched.

Usage

wpcore flag

Downloads latest core files for wordpress

Additional Flags:

wpcore cur

Downloads core wordpress files based on the version specified in files.

Wpcore db

Downloads core wordpress files based on the database version.

wpcore VERSION

    VERSION

        download version VERSION of the Wordpress core, in the form of 

        #.# or 'cur' for current version 

wpfix: This tool runs various built-in Wordpress functions and fixes.

Usage

wpfix flag

Generates a fix report

Additional Flags: None

wpuser: This tool performs various user functions, including returning info for a specified user, changing usernames, passwords, changing a user to an admin, creating new admin users, and deleting users.

Usage

wpuser flag

Returns a list of current users/ID# for that wordpress install.

Additional Flags:

wpuser USERID #

    Returns details about specified user USERID 

wpuser USERID # -u NAME

    change username of user USERID to NAME 

wpuser USERID # -p PASS

    change password of user USERID to PASS 

wpuser USERID # -a

    promote user USERID to admin 

wpuser USERID # -d

    delete user USERID 

    wpuser -n, new

        create new admin user 

Dev: Thomas Bradshaw Script pimp: Jacob Cloutier Checked and approved by RVD, Brent Lundell and Jason Earl. .
