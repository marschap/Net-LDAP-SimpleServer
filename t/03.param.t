use Test::More tests => 0;

__DATA__

use Net::LDAP::SimpleServer;

sub _check_param {
    eval { Net::LDAP::SimpleServer->new(@_) };
}

sub check_param_success {
    my $p = _check_param(@_);
    ok($p);
}

sub check_param_failure {
    my $p = _check_param(@_);
    ok( not $p );
}

diag("Testing parameters for the constructor\n");

check_param_failure('name/of/a/file/that/will/never/ever/exist!');

use File::HomeDir;
use File::Spec::Functions qw(catfile);

my $cfgfile =
  catfile( home(), Net::Squid::Auth::Plugin::SimpleLDAP::DEFAULT_CONFIG_FILE );

if ( -r $cfgfile ) {
    diag( "Using default cfg file: " . $cfgfile );
    check_param_success();
}
else {
    diag("Default cfg file not found");
    check_param_failure();
}

#SKIP: {
#    skip "Not messing with your default configuration file", 1
#        if -r $cfgfile;
