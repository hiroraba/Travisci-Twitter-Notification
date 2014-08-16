package Travisci::Twitter::Notification;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use JSON;
use Plack::Request;
use Plack::Runner;
use Travisci::Twitter::Notification::Post;
use Class::Accessor::Lite (
    new => 1,
);

sub to_app {
    my $self = shift;
    my $config = shift;
    sub {
	my $env = shift;
	my $req = Plack::Request->new($env);
	if  ($req->method eq 'POST' and my $payload = eval { decode_json($req->param('payload'))}) {

	    my $message = $payload->{'message'};
	    
	    my $tw = Travisci::Twitter::Notification::Post->new($config);
	    $tw->post($message);

	    [200, [], ['OK']];
	} else {
	    [400, [], ['BAD REQUEST']];
	}
    };
}

sub run {
    my $self= shift;
    my $config = shift;
    my $runner = Plack::Runner->new();
    $runner->run($self->to_app($config));
}

1;
__END__

=encoding utf-8

=head1 NAME

Travisci::Twitter::Notification - It's new $module

=head1 SYNOPSIS

    use Travisci::Twitter::Notification;

=head1 DESCRIPTION

Travisci::Twitter::Notification is ...

=head1 LICENSE

Copyright (C) hiroraba.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

hiroraba E<lt>xornelius0313@gmail.comE<gt>

=cut

