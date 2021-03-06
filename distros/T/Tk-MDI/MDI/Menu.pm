package Tk::MDI::Menu;

use strict;

my %_fixedMenuEntries = (
			 'Tile Horizontally' => [\&_tile, 'h'],
			 'Tile Vertically'   => [\&_tile, 'v'],
			 'Cascade',	  => [\&_cascade],
			 'Minimize All',	 => [\&_minimizeAll],
			 'Restore All',	  => [\&_restoreAll],
			);

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;

	my $obj = bless {} => $class;

	my %args = @_;
	$obj->{PARENT}	= $args{-parent};
	$obj->{PARENTOBJ} = $args{-parentobj};
	$obj->{MW}	= $args{-mw};
	$obj->{MENUTYPE}  = $args{-type};

	$obj->_createMenuBar;

	return $obj;
}

# possible values for -type are:
# none	- no menus
# popup   - menu accessible only through right mouse button.
# menubar - menu accessible only through menu bar.
# both	- menu accessible through both menu bar and right mouse button.
# menu obj ref - use this menu object as the menu.
#
# PS. I don't like the way I coded this! But it works!

sub _createMenuBar {
	my $obj = shift;

	return if $obj->{MENUTYPE} eq 'none';

	my $popup = my $menubar = 0;

	if (ref $obj->{MENUTYPE}) {
		$obj->{MENU} = $obj->{MENUTYPE};
	} elsif ($obj->{MENUTYPE} eq 'popup') {
		$popup = 1;
	} elsif ($obj->{MENUTYPE} eq 'menubar') {
		$menubar = 1;
	} else {
		$popup = $menubar = 1;
	}

	if ($menubar) {
		if (defined (my $menu = $obj->{MW}->cget('-menu'))) {
			$obj->{MENU} = $menu;
		} else {
			$obj->{MENU} = $obj->{MW}->Menu(qw/-type menubar/);
			$obj->{MW}->configure(-menu => $obj->{MENU});
		}
	}

	if ($popup && !$menubar) {
		$obj->{MENU} = $obj->{MW}->Menu;
	}

	$obj->_populateMenuBar;

	if ($popup) {
		$obj->{PARENTOBJ}->_bindToMenu($obj->{CASCADEMENU});
	}
}

sub _populateMenuBar {
	my $obj = shift;

	$obj->{CASCADEMENU} = $obj->{MW}->Menu(
			-tearoff => 0,
			-postcommand => sub { $obj->_menuPostCommand }
	);

	$obj->{MENU}->add('cascade',
		-label => 'Window',
		-menu  => $obj->{CASCADEMENU},
	);

	for my $key (keys %_fixedMenuEntries) {
	# do I need to sort the above in any way?
		$obj->{CASCADEMENU}->command(
			-label   => $key,
			-command => [@{$_fixedMenuEntries{$key}}, $obj],
		);
	}

	$obj->{CASCADEMENU}->separator;

	$obj->{INDEX}	  = 0;
	$obj->{WINDOWSLISTED}  = 0;
}

# Not sure why this is here-should probably delete?
#sub _newWindow {
#	$_[0]->newWindow;
#}

sub _tile {
	$_[1]->{PARENTOBJ}->_tile($_[0]);
}

sub _cascade {
	$_[0]->{PARENTOBJ}->_cascade($_[0]);
}

sub _minimizeAll {
	$_[0]->{PARENTOBJ}->_minimizeAll($_[0]);
}

sub _restoreAll {
	$_[0]->{PARENTOBJ}->_restoreAll($_[0]);
}

sub _addWindowToList {
	my ($obj, $ref) = @_;
	$obj->{WINDOWLIST}[$obj->{INDEX}++] = $ref;
}

sub _deleteWindowFromList {
	my ($obj, $ref) = @_;

	for my $i (0 .. $obj->{INDEX}) {
		if (defined $obj->{WINDOWLIST}[$i] && $obj->{WINDOWLIST}[$i] eq $ref) {
			$obj->{WINDOWLIST}[$i] = undef;
			last;
		}
	}
}


sub _menuPostCommand {
	my $obj = shift;

	my $w = $obj->{CASCADEMENU};

	if ($obj->{WINDOWSLISTED}) {
		# if we have any windows already in the menu .. delete them.
		my $count = 1 + scalar keys %_fixedMenuEntries; #for the separator
		$w->delete($count, $count + $obj->{WINDOWSLISTED});
		$obj->{WINDOWSLISTED} = 0;
	}

	# Now add the window names to the menu.

	my $j=1; #Counts on left hand side should always be 1..whatever.
	for my $i (0 .. $obj->{INDEX}) {
		my $ref  = $obj->{WINDOWLIST}[$i];
		next unless defined $ref;

		my $name = $ref->_name;

		$name = "($name)" if $ref->_isMin;

		$obj->{WINDOWSLISTED}++;
		$w->command(-label   => "$j. $name",
				-command => sub {
				$ref->_menuFocus;
				});
		$j++;
	}
}

1;
