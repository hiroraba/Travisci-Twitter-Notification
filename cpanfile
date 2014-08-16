requires 'perl', '5.008001';
requires 'Class::Accessor::Lite';
requires 'JSON';
requires 'Plack::Request';
requires 'Plack::Runner';
requires 'Net::Twitter';


on 'test' => sub {
    requires 'HTTP::Request::Common';
    requires 'Plack::Test';
    requires 'Test::More', '0.98';
    requires 'Test::Mock::Guard';
};

