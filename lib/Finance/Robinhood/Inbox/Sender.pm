package Finance::Robinhood::Inbox::Sender;
our $VERSION = '0.92_003';

=encoding utf-8

=for stopwords watchlist watchlists untradable urls

=head1 NAME

Finance::Robinhood::Inbox::Sender - Represents the Sender of a Single
Conversation Message

=head1 SYNOPSIS

    use Finance::Robinhood;
    my $rh = Finance::Robinhood->new( ... );
    my $messages = $rh->inbox();

    # TODO

=cut

sub _test__init {
    my $rh     = t::Utility::rh_instance(1);
    my $sender = $rh->inbox->threads->current->messages->current->sender;
    isa_ok( $sender, __PACKAGE__ );
    t::Utility::stash( 'SENDER', $sender );    #  Store it for later
}
use Moo;

#use Types::Standard qw[Bool Dict Enum InstanceOf Maybe Num Str StrMatch];
use Types::Standard qw[ArrayRef Bool Dict Enum InstanceOf Maybe Num Str StrMatch];
use experimental 'signatures';
#
use Finance::Robinhood::Types qw[URL UUIDBroken];
#
use overload '""' => sub ( $s, @ ) { $s->id }, fallback => 1;
#
sub _test_stringify {
    t::Utility::stash('SENDER') // skip_all();
    like(
        +t::Utility::stash('SENDER'),
        qr[^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$]i
    );
}
#

=head1 METHODS

=cut

has robinhood => ( is => 'ro', required => 1, isa => InstanceOf ['Finance::Robinhood'] );

=head2 C<avatar_url( )>

If defined, this is a URI object.

=cut

has avatar_url => ( is => 'ro', isa => Maybe [URL], coerce => 1, required => 1 );

=head2 C<display_name( )>

The named for this source. For display.

=cut

has display_name => ( is => 'ro', isa => Str, required => 1 );

=head2 C<id( )>

Returns a UUID (real or fake).

=cut

has id => ( is => 'ro', isa => UUIDBroken, required => 1 );

=head2 C<is_bot( )>

Returns a boolean value. True if this is a bot. False if the message was
generated by a human.

=cut

has is_bot => ( is => 'ro', isa => Bool, coerce => 1, required => 1 );

=head2 C<short_display_name( )>



=cut

has short_display_name => ( is => 'ro', isa => Str, required => 1 );

=head1 LEGAL

This is a simple wrapper around the API used in the official apps. The author
provides no investment, legal, or tax advice and is not responsible for any
damages incurred while using this software. This software is not affiliated
with Robinhood Financial LLC in any way.

For Robinhood's terms and disclosures, please see their website at
https://robinhood.com/legal/

=head1 LICENSE

Copyright (C) Sanko Robinson.

This library is free software; you can redistribute it and/or modify it under
the terms found in the Artistic License 2. Other copyrights, terms, and
conditions may apply to data transmitted through this module. Please refer to
the L<LEGAL> section.

=head1 AUTHOR

Sanko Robinson E<lt>sanko@cpan.orgE<gt>

=cut

1;
