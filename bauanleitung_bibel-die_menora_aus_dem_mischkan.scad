/*******************************************************************************

===========================
Die Menora aus dem Mischkan
===========================

Der Leuchter (Bauanleitung 2 Mose 25)

31 Fertige einen Leuchter aus reinem, getriebenem Gold an. Der ganze Leuchter - 
   sein Fuß, sein Schaft, seine Kelche, Knospen und Blütenblätter - soll aus 
   einem Stück gearbeitet werden.
32 Er soll sechs Arme haben, drei auf jeder Seite des Leuchters.
33 An jedem der sechs Arme sollen sich drei mandelblumenförmige Kelche befinden,
   mit Knospen und Blütenblättern.
34 Der Schaft des Leuchters soll mit vier mandelblumenförmigen Kelchen 
   geschmückt sein, vollständig mit Knospen und Blütenblättern.
35 Unterhalb der Stellen, an denen je zwei der sechs Arme aus dem Schaft 
   hervorgehen, soll je eine Knospe sein.
36 Der ganze Leuchter - samt den Verzierungen und Armen - soll aus einem Stück 
   und aus reinem, getriebenem Gold gefertigt sein.
37 Stelle dann sieben Lampen für den Leuchter her und bring sie so an, dass 
   sie nach vorn leuchten.
38 Die Dochtscheren und Ölschalen sollen ebenfalls aus reinem Gold sein.
39 Du sollst den Leuchter und alles Zubehör aus einem Talent[1] reinen Goldes 
   herstellen.
40 Achte darauf, dass du alles ganz genau nach dem Entwurf machst, der dir hier 
   auf dem Berg [2] gezeigt worden ist.

[1] Entspricht heute ungefähr 36 kg    [2] Sinai

*******************************************************************************/

////////////////////////////////////////////////////////////////////////////////
//                                  Module                                    //
////////////////////////////////////////////////////////////////////////////////

// Mandelblüte
module mandelblume(durchmesser){
    // Knospe
    sphere(durchmesser/1.5);
    // Blüte
    for(i=[1:5]){
        rotate([0,-20,360/5*i]){
            translate([durchmesser/2,0,0]){
                scale([1.5,0.75,0.25]){
                    sphere(durchmesser / 1.5);
                }
            }
        }
        
    }
}

// Ölkelch
module oelkelch(durchmesser){
    difference(){
        cylinder(h=durchmesser, r1=durchmesser/2, r2=durchmesser*1.5, center=false);
        translate([0,0,durchmesser/10])cylinder(h=durchmesser, r1=durchmesser/2, r2=durchmesser*1.5, center=false);
    }
    // Kerzenspieß
    cylinder(h=durchmesser*1.5, r1=durchmesser/4, r2=0.01, center=false);
}
    

////////////////////////////////////////////////////////////////////////////////
//                              Einstellungen                                 //
////////////////////////////////////////////////////////////////////////////////

$fn = 100;  // Fragmente (höherer Wert = bessere Qualität. Erhöht Renderzeit.

schaft_hoehe = 30;
arme_anzahl = 3;             // Anzahl Arme flexibel. Warum? Man weiß ja nie! ;)

design = false;

// Automatisch berechnete Parameter nicht ändern!
schaft_durchmesser = schaft_hoehe / 100 * 5;
fuss_durchmesser = schaft_hoehe / 3;
fuss_hoehe = schaft_durchmesser;
arme_spannweite = schaft_hoehe / 2;
arme_durchmesser = schaft_durchmesser / 100 * 75;
arme_abstand = arme_spannweite / 100 * (100 / arme_anzahl);
////////////////////////////////////////////////////////////////////////////////



// Fuß
cylinder(h=fuss_hoehe, r1=fuss_durchmesser / 2, r2=schaft_durchmesser / 2, center=false);

// Schaft
cylinder(h=schaft_hoehe, d=schaft_durchmesser, center=false);

// Arme
translate([0, 0, schaft_hoehe]){
    rotate([-90, 0, 0]){
        rotate_extrude(angle=180) {
            for(i = [1:arme_anzahl]){
                translate([(arme_abstand * i), 0, 0]) circle(d=arme_durchmesser);
            }
        }
    }
    for(i = [0:arme_anzahl]){
        // Lichtschalen Arme
        if(i != 0){
            // Mandelblumen
            translate([arme_abstand * i, 0,-(schaft_durchmesser / 1.75)]) mandelblume(schaft_durchmesser);
            translate([arme_abstand * (-i), 0,-(schaft_durchmesser / 1.75)]) mandelblume(schaft_durchmesser);
            // Ölkelche
            translate([arme_abstand * i, 0,-(schaft_durchmesser / 1.75)]) oelkelch(schaft_durchmesser);
            translate([arme_abstand * (-i), 0,-(schaft_durchmesser / 1.75)]) oelkelch(schaft_durchmesser);
            
        }
        else{
            // mittlere Lichtschale
            translate([0,0,-(schaft_durchmesser / 1.75)]) mandelblume(schaft_durchmesser);
            translate([0,0,-(schaft_durchmesser / 1.75)]) oelkelch(schaft_durchmesser);
        }
    }
    
    // Mondblumen Arme
    for(i=[1:arme_anzahl]){
        rotate([0, 30, 0]){
            translate([arme_abstand * i, 0,-(schaft_durchmesser / 1.75)]) mandelblume(arme_durchmesser);
        }
        rotate([0, 60, 0]){
            translate([arme_abstand * i, 0,-(schaft_durchmesser / 1.75)]) mandelblume(arme_durchmesser);
        }
        rotate([0, 30, 180]){
            translate([arme_abstand * i, 0,-(schaft_durchmesser / 1.75)]) mandelblume(arme_durchmesser);
        }
        rotate([0, 60, 180]){
            translate([arme_abstand * i, 0,-(schaft_durchmesser / 1.75)]) mandelblume(arme_durchmesser);
        }
    }
}

// Mandelblumen Schaft
for(i = [0:arme_anzahl]){
        translate([0, 0, (schaft_hoehe / 2) + (arme_abstand * i)-(schaft_durchmesser/1.75)]){
            mandelblume(schaft_durchmesser);
        }
}
