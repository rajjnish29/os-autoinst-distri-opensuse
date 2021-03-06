# SUSE's openQA tests
#
# Copyright © 2020 SUSE LLC
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.

# Summary: Enable YaST2 Firstboot module - Desktop workstation configuration utility
# Doc: https://en.opensuse.org/YaST_Firstboot
# Maintainer: QA SLE YaST team <qa-sle-yast@suse.de>

use base 'y2_installbase';
use strict;
use warnings;
use testapi;
use utils qw(zypper_call clear_console);
use scheduler 'get_test_suite_data';

sub run {
    my $test_data = get_test_suite_data();
    select_console 'root-console';
    zypper_call "in yast2-firstboot";
    assert_script_run 'touch /var/lib/YaST2/reconfig_system';
    # Use default file from package if no custom file was specified
    if ($test_data->{custom_control_file}) {
        assert_script_run 'wget ' . data_url($test_data->{custom_control_file}) . ' -O /etc/YaST2/firstboot.xml';
    }
    clear_console;
}

1;
