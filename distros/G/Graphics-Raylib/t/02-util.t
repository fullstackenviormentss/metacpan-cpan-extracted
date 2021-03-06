use Test::More tests => 38;

BEGIN {
    use_ok 'Graphics::Raylib::Util', ':objects';
}

my @vector2 = (10, -12);
my $vector2 = vector(@vector2);
is ref($vector2), 'Graphics::Raylib::XS::Vector2';
is length $$vector2, 8;
is "$vector2", '(10, -12)';
is $vector2->x, $vector2[0];
is $vector2->y, $vector2[1];
is vector(1,2,3), vector(1,2,3);
is abs($vector2), sqrt(10**2 + (-12)**2);

my @vector3 = (10, -12, 9);
my $vector3 = vector(@vector3);
is ref($vector3), 'Graphics::Raylib::XS::Vector3';
is length $$vector3, 12;
is "$vector3", '(10, -12, 9)';
is $vector3->x, $vector3[0];
is $vector3->y, $vector3[1];
is $vector3->z, $vector3[2];
is abs($vector3), sqrt(10**2 + (-12)**2 + 9**2);

my $vector4 = vector($vector3);
is length $$vector4, 12;
is $vector4, $vector3;

my $vector5 = vector([10, -12, 9]);
is length $$vector5, 12;
is $vector5, $vector3;

my $rect = rectangle(x=>10, y=>-12, width => 2, height => 3);
is ref($rect), 'Graphics::Raylib::XS::Rectangle';
is "$rect", '(x: 10, y: -12, width: 2, height: 3)';
is length $$rect, 16;
is $rect->x, 10;
is $rect->y, -12;
is $rect->width, 2;
is $rect->height, 3;
is rectangle(position => vector(10, -12), size => vector(2, 3)), $rect;
ok rectangle(x=>10, y=> -12, width=> 1, height => 3) x $rect, 'Collision';
ok !(rectangle(x=>10, y=> 10, width=> 1, height => 3) x $rect), 'No collision';

my $cam = camera(position=>vector(4,2,0), target=>[5,6,7], up => $vector3, fovy => 3.5);
is ref($cam), 'Graphics::Raylib::XS::Camera';
is length $$cam, 40;
isnt $cam->position, vector(2,2,0);
is $cam->position, vector(4,2,0);
is $cam->target, vector(5,6,7);
is $cam->up, $vector3;
is $cam->fovy, 3.5;
is "$cam", "(position: (4, 2, 0), target: (5, 6, 7), up: $vector3, fovy: 3.5)";

my $cam2 = ${vector(4,2,0)}.${vector(5,6,7)}.$$vector3.pack('f', 3.5);
is $$cam, $cam2;
