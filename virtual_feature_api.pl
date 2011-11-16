# Defines functions for this feature

# feature_name()
# Returns a short name for this feature
sub feature_name
{
}

# feature_losing(&domain)
# Returns a description of what will be deleted when this feature is removed
sub feature_losing
{
}

# feature_disname(&domain)
# Returns a description of what will be turned off when this feature is disabled
sub feature_disname
{
}

# feature_label(in-edit-form)
# Returns the name of this feature, as displayed on the domain creation and
# editing form
sub feature_label
{
}

# feature_hlink(in-edit-form)
# Returns a help page linked to by the label returned by feature_label
sub feature_hlink
{
}

# feature_check()
# Returns undef if all the needed programs for this feature are installed,
# or an error message if not
sub feature_check
{
}

# feature_depends(&domain)
# Returns undef if all pre-requisite features for this domain are enabled,
# or an error message if not
sub feature_depends
{
}

# feature_warnings(&domain, [&old-domain])
# Called before a virtual server is created or modified. If any potential but
# non-fatal problems are found, should return a warning message. If not,
# returns undef
sub feature_warnings
{
}

# feature_clash(&domain)
# Returns undef if there is no clash for this domain for this feature, or
# an error message if so
sub feature_clash
{
}

# feature_suitable([&parentdom], [&aliasdom], [&subdom])
# Returns 1 if some feature can be used with the specified alias,
# parent and sub domains
sub feature_suitable
{
}

# feature_setup(&domain)
# Called when this feature is added, with the domain object as a parameter
sub feature_setup
{
}

# feature_modify(&domain, &olddomain)
# Called when a domain with this feature is modified
sub feature_modify
{
}

# feature_delete(&domain)
# Called when this feature is disabled, or when the domain is being deleted
sub feature_delete
{
}

# feature_disable(&domain)
# Called when this feature is temporarily disabled for a domain
# (optional)
sub feature_disable
{
}

# feature_enable(&domain)
# Called when this feature is re-enabled for a domain
# (optional)
sub feature_enable
{
}

# feature_inputs_show([&domain])
# Returns 1 if feature inputs should be shown for this domain, this may be
# undef if it doesn't exist yet.
# (optional)
sub feature_inputs_show
{
}

# feature_inputs([&domain])
# Returns HTML for use in a ui_table block for additional options that are
# available when adding or editing this feature in a domain. The domain object
# may be undef if it doesn't exist yet.
# (optional)
sub feature_inputs
{
}

# feature_inputs_parse(&domain, &in)
# Updates a domain object based on form parameters from feature_inputs. If any
# errors are detected, returns an error message. If all OK, returns undef.
# These values can then be used in feature_setup
# (optional)
sub feature_inputs_parse
{
}

# feature_args(&domain)
# Returns a list of hash refs for extra command-line arguments for this feature,
# for use in create-domain.pl. Each must contain the keys 'name' (the full arg
# name), 'desc' (a description of it), 'value' (a short name for the value)
# and 'opt' (if not manadatory).
# (optional)
sub feature_args
{
}

# feature_args_parse(&domain, &args)
# Updates a domain object based on argument values as defined by feature_args.
# Should set the same fields in the domain object as feature_inputs_parse.
# If all OK, returns undef.
# (optional)
sub feature_args_parse
{
}

# feature_bandwidth(&domain, start, &bw-hash)
# Searches through log files for records after some date, and updates the
# day counters in the given hash
sub feature_bandwidth
{
}

# feature_webmin(&main-domain, &all-domains)
# Returns a list of webmin module names and ACL hash references to be set for
# the Webmin user when this feature is enabled
# (optional)
sub feature_webmin
{
}

# feature_import(domain-name, user-name, db-name)
# Returns 1 if this feature is already enabled for some domain being imported,
# or 0 if not
sub feature_import
{
}

# feature_limits_input(&domain)
# Returns HTML for editing limits related to this plugin
sub feature_limits_input
{
}

# feature_limits_parse(&domain, &in)
# Updates the domain with limit inputs generated by feature_limits_input
sub feature_limits_parse
{
}

# feature_links(&domain)
# Returns an array of link objects for webmin modules for this feature
sub feature_links
{
}

# feature_always_links(&domain)
# Returns an array of link objects for webmin modules, regardless of whether
# this feature is enabled or not
sub feature_always_links
{
}

# feature_backup(&domain, file, &opts, &all-opts)
# Called to backup this feature for the domain to the given file. Must return 1
# on success or 0 on failure
sub feature_backup
{
}

# feature_backup_opts(&opts)
# Returns HTML for selecting options for a backup of this feature
sub feature_backup_opts
{
}

# feature_backup_parse(&in)
# Return a hash reference of backup options, based on the given HTML inputs
sub feature_backup_parse
{
}

# feature_restore(&domain, file, &opts, &all-opts)
# Called to restore this feature for the domain from the given file. Must
# return 1 on success or 0 on failure
sub feature_restore
{
}

# feature_restore_opts(&opts)
# Returns HTML for selecting options for a restore of this feature
sub feature_restore_opts
{
}

# feature_restore_parse(&in)
# Return a hash reference of restore options, based on the given HTML inputs
sub feature_restore_parse
{
}

# feature_backup_name()
# Returns a description for what is backed up for this feature
sub feature_backup_name
{
}

# feature_validate(&domain)
# Checks if this feature is properly setup for the virtual server, and returns
# an error message if any problem is found
sub feature_validate
{
}

# feature_setup_alias(&domain, &alias)
# Called when an alias of this domain is created, to perform any required
# configuration changes. Only useful when the plugin itself does not implement
# an alias feature.
sub feature_setup_alias
{
}

# feature_delete_alias(&domain, &alias)
# Called when an alias of this domain is deleted, to perform any required
# configuration changes. Only useful when the plugin itself does not implement
# an alias feature.
sub feature_delete_alias
{
}

# feature_modify_alias(&domain, &alias, &old-alias)
# Called when an alias of this domain is deleted, to perform any required
# configuration changes. Only useful when the plugin itself does not implement
# an alias feature.
sub feature_modify_alias
{
}

# feature_provides_web()
# Returns 1 if this plugin provides a website feature
sub feature_provides_web
{
}

# feature_web_supported_php_modes([&domain])
# If a feature provides a website, this function must return the list of 
# possible PHP execution modes
sub feature_web_supported_php_modes
{
}

# feature_get_web_php_mode(&domain)
# If a feature provides a website, this function must return the PHP execution
# mode (one of mod_php, cgi or fcgid)
sub feature_get_web_php_mode
{
}

# feature_save_web_php_mode(&domain)
# If a feature provides a website, this function must change the PHP execution
# mode to one of mod_php, cgi or fcgid. Can call error if mode isn't valid.
sub feature_save_web_php_mode
{
}

# feature_get_web_php_children(&domain)
# If a feature provides a website, this function must return the number of
# FastCGI PHP child processes
sub feature_get_web_php_children
{
}

# feature_save_web_php_children(&domain, children)
# If a feature provides a website, this function must change the number of 
# FastCGI PHP child processes
sub feature_save_web_php_children
{
}

# feature_list_web_php_directories(&domain)
# If a feature provides a website, this function must return a list of hash
# refs, one per directory with 'dir', 'version' and 'mode' keys.
sub feature_list_web_php_directories
{
}

# feature_save_web_php_directory(&domain, dir, version)
# Sets the PHP version to use for a directory.
sub feature_save_web_php_directory
{
}

# feature_delete_web_php_directory(&domain, dir)
# Removes the custom PHP version to use for a directory.
sub feature_delete_web_php_directory
{
}

# feature_get_fcgid_max_execution_time(&domain)
# Returns the max execution time for FastCGI scripts in this domain
sub feature_get_fcgid_max_execution_time
{
}

# feature_set_fcgid_max_execution_time(&domain, max)
# Sets the max execution time for FastCGI scripts in this domain
sub feature_set_fcgid_max_execution_time
{
}

# feature_restart_web_php(&domain)
# Will be called by Virtualmin when some PHP config change is made, like
# installing a new module
sub feature_restart_web_php
{
}

# feature_restart_web_command([&domain])
# Returns a command to restart the webserver, typically used after log file
# rotation
sub feature_restart_web_command
{
}

# feature_setup_web_for_php(&domain, &script, php-version)
# Called to set any PHP variables needed by a script that are set in the 
# webserver config.
sub feature_setup_web_for_php
{
}

# feature_get_web_suexec(&domain)
# Returns 1 if this domain's website runs scripts as the domain owner
sub feature_get_web_suexec
{
}

# feature_save_web_suexec(&domain, enabled)
# Enables or disables running of scripts as the domain owner
sub feature_save_web_suexec
{
}

# feature_get_web_default_website(&domain)
# Returns 1 if this website is the default for its IP
sub feature_get_web_default_website
{
}

# feature_save_web_default_website(&domain)
# Makes a website the default for it's IP
sub feature_save_web_default_website
{
}

# feature_startstop()
# If this feature has a server process, this function should return a hash
# with 'status', 'desc' and 'links' keys.
sub feature_startstop
{
}

# feature_stop_service()
# Stops the server process associated with this plugin
sub feature_stop_service
{
}

# feature_start_service()
# Starts the server process associated with this plugin
sub feature_start_service
{
}

# mailbox_inputs(&user, new, &domain)
# Returns HTML for additional inputs on the mailbox form. These should be
# formatted to appear inside a table.
sub mailbox_inputs
{
}

# mailbox_validate(&user, &old-user, &in, new, &domain)
# Validates inputs generated by mailbox_inputs, and returns either undef on
# success or an error message
sub mailbox_validate
{
}

# mailbox_save(&user, &old-user, &in, new, &domain)
# Updates the user based on inputs generated by mailbox_inputs. Returns 1 if
# this feature was enabled, 0 if not
sub mailbox_save
{
}

# mailbox_modify(&user, &old-user, &domain)
# Called when a user is modified by some program other than the Edit User
# page, in order to make any other updates needed by this plugin.
sub mailbox_modify
{
}

# mailbox_delete(&user, &domain)
# Removes any extra features for this user
sub mailbox_delete
{
}

# mailbox_header(&domain)
# Returns a column header for the user display, or undef for none
sub mailbox_header
{
}

# mailbox_column(&user, &domain)
# Returns the text to display in the column for some user
sub mailbox_column
{
}

# mailbox_defaults_inputs(&defs, &domain)
# Returns HTML for editing defaults for plugin-related settings for new
# users in this virtual server
sub mailbox_defaults_inputs
{
}

# mailbox_defaults_parse(&defs, &domain, &in)
# Parses the inputs created by mailbox_defaults_inputs, and updates a config
# file internal to this module to store them
sub mailbox_defaults_parse
{
}

# virtusers_ignore(&domain)
# Returns a list of virtuser addresses (like foo@bar.com) that are created by
# this plugin and should not be displayed or included in counts
sub virtusers_ignore
{
}

# database_name()
# Returns the name for this type of database
sub database_name
{
}

# database_list(&domain)
# Returns a list of databases owned by a domain, according to this plugin
sub database_list
{
}

# databases_all([&domain])
# Returns a list of all databases on the system, possibly limited to those
# associated with some domain
sub databases_all
{
}

# database_clash(&domain, name)
# Returns 1 if the named database already exists
sub database_clash
{
}

# database_create(&domain, dbname)
# Creates a new database for some domain. May call the $print functions to
# report progress
sub database_create
{
}

# database_delete(&domain, dbname)
# Creates an existing database for some domain. May call the *print functions to
# report progress
sub database_delete
{
}

# database_size(&domain, dbname)
# Returns the on-disk size and number of tables in a database
sub database_size
{
}

# database_users(&domain, dbname)
# Returns a list of usernames and passwords for users who can access the
# given database.
sub database_users
{
}

# database_create_user(&domain, &dbs, username, password)
# Creates a user with access to the specified databases
sub database_create_user
{
}

# database_modify_user(&domain, &olddbs, &dbs, oldusername, username, [pass])
# Updates a user, changing his available databases, username and password
sub database_modify_user
{
}

# database_delete_user(&domain, username)
# Deletes a user and takes away his access to all databases
sub database_delete_user
{
}

# database_user(name)
# Returns a username converted or truncated to be suitable for this database
sub database_user
{
}

# template_input(&template)
# Returns HTML for editing per-template options for this plugin
sub template_input
{
}

# template_parse(&template, &in)
# Updates the given template object by parsing the inputs generated by
# template_input. All template fields must start with the module name.
sub template_parse
{
}

# settings_links()
# If defined, should return a list of additional System Settings section links
# related to this plugin, typically for configuring global settings. Each
# element must be a hash ref containing link, title, icon and cat keys.
sub settings_links
{
}

# theme_sections()
# If defined, should return a list of extra sections to be displayed (typically
# on the right-hand frame) of a theme. Each must be a hash ref containing the
# keys 'title' (section heading), 'html' (contents of the section) and
# 'status' (open or not by default). It can also contain 'for_master',
# 'for_reseller' and 'for_owner' flags, indicating if the section should be
# visible to master admins, resellers and domain owners.
sub theme_sections
{
}

# scripts_list()
# If defined, should return a list of script names supported by this plugin.
# For each, the directory must contain a .pl file with the same name in standard
# script format.
sub scripts_list
{
}

1;

