#!/usr/local/bin/perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";
use YAML::Syck;

use Travisci::Twitter::Notification;

my $config = YAML::Syck::LoadFile($ARGV[0]);

my $server = Travisci::Twitter::Notification->new();
$server->run($config);
