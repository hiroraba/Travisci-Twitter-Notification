package Travisci::Twitter::Notification::Post;

use Net::Twitter;

sub new {
    my($self, $config) = @_;
    print $config->{consumer_key};
    $nt = Net::Twitter->new(
	ssl => 1,
        traits => ['API::RESTv1_1'],
        consumer_key => $config->{consumer_key},
        consumer_secret => $config->{consumer_secret},
        access_token => $config->{token},
        access_token_secret => $config->{token_secret},
	);
    bless {nt => $nt},$self;
}

sub post {
    my $self = shift;
    my $mes = shift;
    $self->{'nt'}->update($mes);
}
1;
