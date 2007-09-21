#!/usr/local/bin/perl
# index.cgi
# Display a list of domains managed by this module

require './virtual-server-lib.pl';

$vtitle = &text('index_versionmode', $module_info{'version'},
		&master_admin() ? $text{'index_mastermode'} :
		&reseller_admin() ? $text{'index_resellermode'} :
		$single_domain_mode ? $text{'index_mailmode'} :
				      $text{'index_usermode'});
if ($single_domain_mode) {
	# This user can edit just a single domain, so show only a menu of
	# icons for options he can use
	$d = &get_domain($single_domain_mode);
	&ui_print_header(&domain_in($d), $text{'index_title2'}, "", undef, 1, 1,
			 0, undef, undef, undef, $vtitle);
	@links = ( "list_users.cgi?dom=$single_domain_mode",
		   "list_aliases.cgi?dom=$single_domain_mode",
		   "view_domain.cgi?dom=$single_domain_mode", );
	@titles = ( $text{'users_title'}, $text{'aliases_title'},
		    $text{'view_title'}, );
	@icons = ( "images/users.gif", "images/aliases.gif", "images/view.gif" );
	&icons_table(\@links, \@titles, \@icons);
	&ui_print_footer("/", $text{'index'});
	exit;
	}

&ui_print_header(undef, $text{'index_title'}, "", "index", 1, 1, 0,
	undef, undef, undef, $vtitle);

# Check if server module configuration has been checked
if (&need_config_check() && &can_check_config()) {
	# Not since last config change .. force it now
	print &ui_form_start("check.cgi");
	print "<b>$text{'index_needcheck'}</b><p>\n";
	print &ui_submit($text{'index_srefresh'});
	print &ui_form_end();

	if (@plugins) {
		print &ui_form_start("edit_newplugin.cgi");
		print &ui_submit($text{'index_plugins'});
		print &ui_form_end();
		}

	print &ui_form_start("edit_newtmpl.cgi");
	print &ui_submit($text{'index_tmpls'});
	print &ui_form_end();

	&ui_print_footer("/", $text{'index'});
	exit;
	}

# Setup the licence cron job
print &licence_warning_message();

# Display local users
if ($config{'localgroup'} && &can_edit_local()) {
	print &ui_subheading($text{'index_header1'});
	@lusers = &list_domain_users(undef, 0, 1);
	if (@lusers) {
		print "<a href='edit_user.cgi?new=1&dom=0'>",
		      "$text{'index_uadd'}</a><br>\n";
		&users_table(\@lusers);
		}
	else {
		print "<b>$text{'index_nousers'}</b><p>\n";
		}
	print "<a href='edit_user.cgi?new=1&dom=0'>",
	      "$text{'index_uadd'}</a><p>\n";
	print "<hr>\n";
	}

# Display domains
if ($current_theme ne "virtual-server-theme" &&
    !$main::basic_virtualmin_menu) {
	print &ui_subheading($text{'index_header2'});
	}
@alldoms = &list_domains();
@doms = grep { &can_edit_domain($_) } @alldoms;
if ($config{'display_max'} && @doms > $config{'display_max'}) {
	# Too many domains to display, so show a search form
	print "<b>$text{'index_toomany'}</b><p>\n";
	print &ui_form_start("search.cgi");
	print "<b>$text{'index_search'}</b>\n";
	print &ui_select("field", "dom",
		[ [ "dom", $text{'index_search_dom'} ],
		  [ "user", $text{'index_search_user'} ],
		  [ "ip", $text{'index_search_ip'} ],
		  [ "parent", $text{'index_search_parent'} ],
		  [ "template", $text{'index_search_template'} ],
		  $virtualmin_pro ?
			( [ "reseller", $text{'index_search_reseller'} ] ) :
			( ) ]),"\n";
	print "<b>$text{'index_contains'}</b>\n";
	print &ui_textbox("what", undef, 30),"\n";
	print &ui_submit($text{'index_searchok'});
	print &ui_form_end();

	print &ui_form_start("domain_form.cgi");
	}
elsif (@doms) {
	# Show domains in a table
	print &ui_form_start("domain_form.cgi");
	if ($current_theme ne "virtual-server-theme" &&
	    !$main::nocreate_virtualmin_menu) {
		&create_links(1);
		}
	foreach $d (@doms) {
		$canconfig ||= &can_config_domain($d);
		}
	@links = ( );
	if ($canconfig && $virtualmin_pro) {
		push(@links, &select_all_link("d"),
			     &select_invert_link("d"));
		}
	print &ui_links_row(\@links);
	&domains_table(\@doms, $virtualmin_pro);
	print &ui_links_row(\@links);
	$shown_table = 1;
	}
else {
	if (@alldoms) {
		print "<b>$text{'index_none2'}</b><p>\n";
		}
	else {
		print "<b>$text{'index_none'}</b><p>\n";
		}
	print &ui_form_start("domain_form.cgi");
	}
if ($current_theme ne "virtual-server-theme" &&
    !$main::nocreate_virtualmin_menu) {
	&create_links(2);
	}
if ($shown_table && $canconfig && $virtualmin_pro) {
	# Show mass delete / change buttons
	print &ui_submit($text{'index_delete'}, "delete"),"\n";
	print &ui_submit($text{'index_mass'}, "mass"),"\n";
	if (&can_disable_domain($doms[0])) {
		print "&nbsp;&nbsp;\n";
		print &ui_submit($text{'index_disable'}, "disable"),"\n";
		print &ui_submit($text{'index_enable'}, "enable"),"\n";
		}
	}
print &ui_form_end();
print "<p>\n";

# When using the Virtualmin Pro framed theme, the rest of the page is not needed
if ($current_theme eq "virtual-server-theme" ||
    $main::basic_virtualmin_menu) {
	goto PAGEEND;
	}

# Show icons for editing various global settings
if (&can_edit_templates()) {
	print "<hr>\n";
	print &ui_subheading($text{'index_header3'});
	($tlinks, $ttitles, $ticons) = &get_template_pages();
	&icons_table($tlinks, $ttitles, $ticons, 5);
	}

# Show current status
if (&can_view_status()) {
	print "<hr>\n";
	print &ui_subheading($text{'index_sheader'});
	print "<table width=100%>\n";

	# Show enabled features and plugins
	print "<tr> <td nowrap><b>$text{'index_sfeatures'}</b></td> <td>\n";
	print join(", ", (map { $text{"feature_".$_} }
		          grep { $config{$_} && $_ ne "unix" && $_ ne "dir" }
				@features),
			 (map { &plugin_call($_, "feature_name") }
			      @plugins)
		  );
	print "</td> </tr>\n";

	@dis = grep { !$config{$_} } @opt_features;
	if (@dis) {
		# Show disabled features
		print "<tr> <td nowrap><b>$text{'index_snfeatures'}</b></td> <td>\n";
		print join(", ", map { $text{"feature_".$_} }
				 @dis),"</td> </tr>\n";
		}

	print "<tr> <td nowrap><b>$text{'index_squotas'}</b></td> <td>\n";
	if (!$config{'quotas'}) {
		# Quotas manually disabled
		print "$text{'index_squotas1'}\n";
		}
	elsif ($config{'home_quotas'} &&
	       $config{'home_quotas'} eq $config{'mail_quotas'}) {
		# Both quota filesystems are the same
		print &text($config{'group_quotas'} ? 'index_squotas5g' : 'index_squotas5', "<tt>$config{'home_quotas'}</tt>"),"\n";
		}
	elsif ($config{'home_quotas'} && $config{'mail_quotas'}) {
		# Quota filesystems are different
		print &text($config{'group_quotas'} ? 'index_squotas4g' : 'index_squotas4', "<tt>$config{'home_quotas'}</tt>", "<tt>$config{'mail_quotas'}</tt>"),"\n";
		}
	elsif ($config{'home_quotas'}) {
		# Only for home
		print &text($config{'group_quotas'} ? 'index_squotas3g' : 'index_squotas3', "<tt>$config{'home_quotas'}</tt>"),"\n";
		}
	else {
		# Not active at all
		print "$text{'index_squotas2'}\n";
		}
	print "</td> </tr>\n";

	if ($config{'mail'}) {
		print "<tr nowrap> <td><b>$text{'index_smail'}</b></td> <td>\n";
		print &mail_system_name();
		print "</td> </tr>\n";
		}

	if (&can_check_config()) {
		print "<tr>",&ui_form_start("check.cgi");
		print "<td colspan=2 align=right>",
			&ui_submit($text{'index_srefresh'}),"</td>\n";
		print &ui_form_end(),"</form></tr>\n";
		}

	print "</table>\n";
	}

# Show system information
if (&can_view_sysinfo()) {
	print "<hr>\n";
	print &ui_subheading($text{'index_header5'});
	print "<table width=100%>\n";
	foreach my $f ("virtualmin", @features) {
		if ($config{$f} || $f eq "virtualmin") {
			local $ifunc = "sysinfo_$f";
			push(@info, &$ifunc()) if (defined(&$ifunc));
			}
		}
	for($i=0; $i<@info; $i++) {
		print "<tr>\n" if ($i%2 == 0);
		print "<td width=20%><b>$info[$i]->[0]</b></td>\n";
		print "<td width=30%>$info[$i]->[1]</td>\n";
		print "</tr>\n" if ($i%2 == 1);
		}
	print "</table>\n";
	}

# Show backup and restore buttons
if (&can_backup_domains()) {
	print "<hr>\n";
	print &ui_subheading($text{'index_header4'});
	print &ui_buttons_start();

	# Button to backup now
	print &ui_buttons_row("backup_form.cgi", $text{'index_backup'},
			      $text{'index_backupdesc'});

	# Button to setup scheduled backup
	print &ui_buttons_row("backup_form.cgi", $text{'index_sched'},
			      $text{'index_scheddesc'},
			      &ui_hidden("sched", 1));

	# Button to restore
	print &ui_buttons_row("restore_form.cgi", $text{'index_restore'},
			      $text{'index_restoredesc'});

	print &ui_buttons_end();
	}

# Show start/stop buttons
if (&can_stop_servers()) {
	@ss = &get_startstop_links();
	if (@ss) {
		print "<hr>\n";
		print &ui_buttons_start();
		foreach $status (@ss) {
			print &ui_buttons_row($status->{'status'} ?
				"stop_feature.cgi" : "start_feature.cgi",
				$status->{'desc'},
				$status->{'longdesc'},
				&ui_hidden("feature", $status->{'feature'}),
				undef,
				$status->{'status'} ? "<img src=images/up.gif>"
					: "<img src=images/down.gif>");
			}
		print &ui_buttons_end();
		}
	}

PAGEEND:
&ui_print_footer("/", $text{'index'});

# create_links(num)
sub create_links
{
local ($dleft, $dreason, $dmax, $dhide) = &count_domains("realdoms");
local ($cannot_add, $limit_reason);
if ($dleft == 0) {
	# Need to show reason for hitting the limit
	$cannot_add = &text('index_noadd'.$dreason, $dmax);
	}
elsif ($dleft != -1 && $_[0] == 1 && !$dhide) {
	# Tell the user how close they are to the limit, and why
	$limit_reason = &text('index_canadd'.$dreason, $dleft);
	}
if (!&can_create_master_servers() && &can_create_sub_servers()) {
	# Can just add sub-server
	if (!$cannot_add) {
		print "<b>$limit_reason</b><p>\n" if ($limit_reason);
		print "<input type=submit name=add$_[0] value='$text{'index_add1'}'>\n";
		}
	elsif ($_[0] == 1) {
		print "<b>",$cannot_add,"</b><br>\n";
		}
	}
elsif (&can_create_master_servers()) {
	# Can add either master or sub-server
	if (!$cannot_add) {
		print "<b>$limit_reason</b><p>\n" if ($limit_reason);
		print "<input type=submit name=add$_[0] value='$text{'index_add2'}'>\n";
		print "<select name=parentuser$_[0]>\n";
		print "<option value=''>$text{'index_newuser'}\n";
		foreach $u (sort(&unique(map { $_->{'user'} }
					 grep { $_->{'unix'} } @doms))) {
			print "<option>$u\n";
			}
		print "</select>\n";
		}
	elsif ($_[0] == 1) {
		print "<b>",$cannot_add,"</b><br>\n";
		}
	}
if (&can_import_servers()) {
	print "<input type=submit name=import value='$text{'index_import'}'>\n";
	}
if (&can_migrate_servers()) {
	print "<input type=submit name=migrate value='$text{'index_migrate'}'>\n";
	}
if ((&can_create_master_servers() || &can_create_sub_servers()) &&
    $virtualmin_pro && &can_create_batch()) {
	print &ui_submit($text{'index_batch'}, "batch"),"\n";
	}
print "&nbsp;\n" if (!$cannot_add);
}

