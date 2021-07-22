module side_cover_inner(
    length,
    height,
    width,
    overflow_height, 
    overflow_width,
    overflow_angle,
    thickness
){
    t = thickness;
    q = overflow_height+t-overflow_width/2;
    r = overflow_width/2+t;
    ir = overflow_width/2-t;
    
    difference(){
        // long piece
        cube([length+t, height+2*t, width]);
        // corner - to be able to make it round
        cube([overflow_width+2*t, overflow_width+2*t, 2*width], center = true);
    }
    //overflow
    rotate([0,0,overflow_angle]){
        translate([0,r, 0])
            cube([overflow_width+2*t, q-r, width]);
        // round part at the bottom
        translate([overflow_width/2+t, q, 0])
            cylinder(h=width, r=overflow_width/2+t);
    }
    // round inner corner
    difference(){
        union(){
            translate([overflow_width+2*t-r,height+2*t-r,0])
                cube([ir+r, ir+r+1, width]);
            rotate([0,0,overflow_angle]);
                translate([overflow_width+2*t-r,height+2*t-r,0])
                    cube([ir+r, ir+r, width]);
        }
        
        hull(){
            translate([overflow_width+2*t+ir,height+2*t+ir,0])
                cylinder(h=width, r=ir);
            rotate([0,0,overflow_angle])
                translate([overflow_width+2*t+ir,height+2*t+ir,0])
                    cylinder(h=width, r=ir);
        }
    }
    //round outer corner
    hull(){
        translate([r, r, 0])
            cylinder(h=width, r=r);
        rotate([0,0,overflow_angle])
            translate([r, r, 0])
                cylinder(h=width, r=r);
    }
}

module side_cover(
    length,
    height,
    side_overlap_width,
    overflow_height, 
    overflow_width,
    overflow_angle,
    thickness
){
    difference(){
        side_cover_inner(length,
        height,
        side_overlap_width+thickness,
        overflow_height, 
        overflow_width,
        overflow_angle,
        thickness);
        translate([thickness, thickness, 0])   
            side_cover_inner(length,
            height,
            side_overlap_width,
            overflow_height, 
            overflow_width,
            overflow_angle,
            0);
    }
}



side_cover(215, 20.7, 5, 40, 13, 5, 1.5);