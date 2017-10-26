/**
* Name: needle
* Author: evgeniyar
* Description: 
* Tags: Tag1, Tag2, TagN
*/

model needle

/* Insert your model definition here */

global {
	geometry shape <- square(30#m);
	int num_overlap;
	int num_needle<-0;	
	float results;
	
	init{
		create border number:1 {location<-{10,15};}
		create border number:1 {location<-{20,15};}
	
	}
	reflex new_needle {
		create needle number:1;
		num_needle<- num_needle + 1;
	}
	reflex count_needle {
		list<agent> over_needle <-agents_overlapping(border);
		num_overlap <- length(over_needle);
		
		results <-2/(num_overlap/num_needle);
	}
}
species border {
	init {
		shape<-line([{0,0},{0,30}]);
	}
	
	aspect normal {
		draw shape color:#green;
	}
}
species needle  {
	init {
		shape<-line([{0,0},{0,10}]) rotated_by rnd(360.0);
		location<-{rnd(10.0)+10.0,rnd(10.0)+10.0};

	}
	aspect normal {
		draw shape color:#red;
	}
}

experiment my_exp type:gui {
	output {
		monitor overlap value:num_overlap;
		monitor all value:num_needle;
		monitor result value:with_precision(results,4) ;
		display my_display {
			species border aspect:normal;
			species needle aspect: normal;
		}
		display my_chart {
			chart "count pi" type:series {
				data "result for pi" value:results;
			}
		}
	}
}