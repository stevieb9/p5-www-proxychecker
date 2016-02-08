#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;
use WWW::FreeProxyListsCom;
use WWW::ProxyChecker;
use Test::More;

my $p = WWW::FreeProxyListsCom->new(timeout => 10);
my $checker = WWW::ProxyChecker->new(debug => 1);

$p->get_list(type => 'us');

my $prox_list;

eval { $prox_list = $p->filter(latency => qr/\d{2,3}$/, is_https => 'false'); };

if ($@){
    plan skip_all => "timeout occurred, skipping";
}

@$prox_list = @$prox_list[0..15];

my @data;

for (@$prox_list){
    push @data, join '', 'http://', join ':', @$_{qw(ip port)};
}

$checker->check(\@data);

my $fastest = $checker->fastest;

print "$_\n" for @$fastest;

done_testing();

