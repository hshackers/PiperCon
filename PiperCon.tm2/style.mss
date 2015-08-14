// Languages: name (local), name_en, name_fr, name_es, name_de
@name: '[name_en]';

// Fonts //
@fallback: 'Arial Unicode MS Regular';
@sans: 'Super Grotesk Offc Pro Regular', 'Arial Unicode MS Regular';
@sans_md: 'Super Grotesk Offc Pro Medium', 'Arial Unicode MS Regular';
@sans_bd: 'Super Grotesk Offc Pro Bold','Arial Unicode MS Bold';
@sans_it: 'Tartine Script Offc Pro Bold', 'Arial Unicode MS Regular';
@sans_bdit: 'HolmenOT BoldItalic','Arial Unicode MS Bold';

/*
This style is designed to be easily recolored by adjusting the color
variables below. For predicatable feature relationships,
maintain or invert existing value (light to dark) scale.
*/

// Color palette //
@brand: #70AD47;
@road:  lighten(@brand, 15%);
@land:  @brand;

@fill1: lighten(@brand, 10%);
@fill2: @brand;
@fill3: lighten(@brand, 10%);
@fill4: #ffffff;
@fill5: lighten(@brand, 10%);

@text: darken(@brand,10%);

Map { background-color: darken(@brand, 5%); buffer-size: 3000; }

// Political boundaries //
#admin[admin_level=2][maritime=0] {
  line-join: round;
  line-color: @fill5;
  line-width: 1;
  [zoom>=5] { line-width: 1.4; }
  [zoom>=6] { line-width: 1.8; }
  [zoom>=8] { line-width: 2; }
  [zoom>=10] { line-width: 3; }
  [disputed=1] { line-dasharray: 4,4; }
}

#admin[admin_level>2][maritime=0] {
  line-join: round;
  line-color: @fill5;
  line-width: 1;
  line-dasharray: 3,2;
  [zoom>=6] { line-width: 1.5; }
  [zoom>=8] { line-width: 1.8; }
}

// Land Features //
#landuse[class='cemetery'],
#landuse[class='park'],
#landuse[class='wood'],
#landuse_overlay {
  polygon-fill: darken(@land,3);
  [zoom>=15] { polygon-fill:mix(@land,@fill4,95); }
}

#landuse[class='pitch'],
#landuse[class='sand'] { 
  polygon-fill: mix(@land,@fill4,90);
}

#landuse[class='hospital'],
#landuse[class='industrial'],
#landuse[class='school'] { 
  polygon-fill: mix(@land,@fill1,95);
}

#building { 
  polygon-fill: mix(@fill2,@land,25);
  [zoom>=16]{ polygon-fill: mix(@fill2,@land,50);}
}

#aeroway {
  ['mapnik::geometry_type'=3][type!='apron'] { 
    polygon-fill: mix(@fill2,@land,25);
    [zoom>=16]{ polygon-fill: mix(@fill2,@land,50);}
  }
  ['mapnik::geometry_type'=2] { 
    line-color: mix(@fill2,@land,25);
    line-width: 1;
    [zoom>=13][type='runway'] { line-width: 4; }
    [zoom>=16] {
      [type='runway'] { line-width: 6; }
      line-width: 3;
      line-color: mix(@fill2,@land,50);
    }
  }
}

// Water Features //
#water {
  ::shadow {
    polygon-fill: darken(@brand, 15%); // rgba(89, 173, 184, 1); // mix(@land,@fill4,75);
    
  }
  ::fill {
    // a fill and overlay comp-op lighten the polygon-
    // fill from ::shadow.
    polygon-fill: @land;
    comp-op: soft-light;
    // blurring reveals the polygon fill from ::shadow around
    // the edges of the water
    image-filters: agg-stack-blur(10,10);
    image-filters-inflate: true;
  }
}

// Water color is calculated by sampling the resulting color from
// the soft-light comp-op in the #water layer style above. 
@water: lighten(@brand,10%);

#waterway {
  [type='river'],
  [type='canal'] {
    line-color: @water;
    line-width: 0.5;
    [zoom>=12] { line-width: 1; }
    [zoom>=14] { line-width: 2; }
    [zoom>=16] { line-width: 3; }
  }
  [type='stream'] {
    line-color: @water;
    line-width: 0.5;
    [zoom>=14] { line-width: 1; }
    [zoom>=16] { line-width: 2; }
    [zoom>=18] { line-width: 3; }
  }
}
