use strict;
use warnings;
use utf8;

use Test::More 0.98;
use Plack::Test;
use HTTP::Request::Common;
use Test::Mock::Guard qw/mock_guard/;

use Travisci::Twitter::Notification;

subtest 'notification server' => sub {

  my $mock = mock_guard 'Travisci::Twitter::Notification::Post',
  +{
	post => sub { 
             my $self = shift;
             return 1;
  	},
  };


  my $receiver = Travisci::Twitter::Notification->new;
  my $app = $receiver->to_app;

  test_psgi $app => sub {
      my $cb = shift;
      my $req = POST '/', [
        payload => '{"name":"travis"}',
      ];

      my $res = $cb->($req);
      is $res->content, 'OK';
  };

  test_psgi $app => sub {
    my $cb = shift;
    my $req = POST '/', [
      payloaddddddd => '{"name":"travis"}',
    ];

    my $res = $cb->($req);
    is $res->content, 'BAD REQUEST';
  };
};
done_testing;
