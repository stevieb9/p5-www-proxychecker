use strict;
use warnings;

use WWW::FreeProxyListsCom;
use WWW::ProxyChecker;

my $fpl = WWW::FreeProxyListsCom->new;
my $checker = WWW::ProxyChecker->new;

$fpl->get_list(type => 'us');

$checker->check($fpl->urls);

for (@{ $checker->fastest }){
    print "$_\n";
}
