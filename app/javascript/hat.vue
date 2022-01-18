<template>
  <div class="hat">
  	<!-- <div class="blank"></div> -->
  	<div class="container">
	  	<div class="fog"></div>
	  	<div class="flash"></div>

	  	<div class="clouds2"></div>
	  	<div class="bgshad"></div>

	  	<div class="clouds"></div>
	  		  	<div class="voodoo fonta">
	  		<!-- VooDoo power  -->
	  		FREE PVP ZONE
	  	</div>
<!-- <div class="plashken"></div> -->
	  	<div class="warriors">
 
	  	</div>
	  	<div class="warriors brightness"></div>
	  	<div class="bgshad2"></div>

	  </div>

	</div>
</template>
<script>
	// import ScrambleText from 'scramble-text'; 
	// import { VueTyper } from 'vue-typer'
import { gsap } from "gsap";
import { SlowMo } from "gsap/EasePack";

gsap.registerPlugin(SlowMo);
  export default {
    data: function (){
      return {
      	repDelay: 8
        
      }
    },
    methods: {

    },
    created() { 
    
  	},
    mounted() {
     
	    function voodoo() {
	   //  	gsap.set(".voodoo", {
				// 	scale: 0.01,
 		
				// });
				gsap.set(".voodoo", {
					// x:"-200px",
					opacity: 0,	
					scale: 0,
					color: "#9f0000",	
				});

				var tl =	gsap.timeline();
					tl.to(".voodoo", {
		  		 // repeat: 1,
		  		// x:"-1900px",
		  		scale: 0.35,
					opacity: 0.8,	
		  		duration: 0.5,  
		  		delay: 0.1,
		  		 ease: "sine.in",
		  		  
		  	}).to(".voodoo", {
		  		 // repeat: 1,
		  		// x:"-1900px",
		  		y:+5,
		  		scale: 0.55,
					opacity: 0,	
		  		duration: 2.5,  
 					// delay: 0.2,
		  		ease: "my-wiggle",
		  	})
	  	}
 
	  	function warriors() {
	  		gsap.set(".warriors", {
					backgroundPositionY: 165,
				});

				var tl =	gsap.timeline();
				tl.to('.warriors', {
					delay: 0.0,
					duration: 1.1,
					ease: "sine.in",
					backgroundPositionY: 0,
				});
	  	}

	  	function cloud() {
	    	// var tl2 = new TimelineMax({repeat:-1});
	    	var tl =	gsap.timeline();
				tl.to('.clouds', {
					repeat: -1,
			 		duration: 18,
					backgroundPositionX: -1, 
					ease: "none",
				});
	  	}
	  	function cloud2() {
	  		var tl =	gsap.timeline();
	  		tl.to('.clouds2', {
	  			repeat: -1,
	  			duration: 18,
	  			backgroundPositionX: -1, 
	  			ease: "none",
	  		});
	  	}
	  	function brightness() {
	  		var tl =	gsap.timeline({repeat:-1});
				tl.set('.brightness', {opacity: "0"})
				.to('.brightness', {
					duration: 0.05,
					ease: "sine.in",
					delay: 0.5, 
					opacity: "1"}, 1.1)
				.to('.brightness', {
					delay: 0.3,
					duration: 1.4, 
					opacity: "0", 
					ease: "sine.out"}, '+=0.0')
				.to('.brightness', {
					delay: 1.4,
					duration: 0.05,
						ease: "sine.in",
					opacity: "1"}, '-=0.0')
				.to('.brightness',{
					delay: 0.3,
					duration: 2, 
					opacity: "0", 
					ease: "sine.out",})
				.to('.brightness',{
					delay: 3});		  		
	  	}

	  	function flash() {
				var tl =	gsap.timeline({repeat:-1});
				tl.set('.flash', {
					opacity: "0"})
				.to('.flash', {
					duration: 0.05,
					ease: "sine.in",
					delay: 0.5, 
					opacity: "1"}, 1.1)
				.to('.flash', {
					delay: 0.3,
					duration: 1.4, 
					opacity: "0", 
					ease: "sine.out"}, '-=0.0')
				.to('.flash', {
					delay: 1.4,
					duration: 0.05,
					ease: "sine.in",
					opacity: "1"}, '-=0.0')
				.to('.flash', {
					delay: 0.3,
					duration: 2,
					opacity: "0", 
					ease: "sine.out"})
				.to('.brightness',{
					delay: 3});		  		  		
	  	}
			

				// var tl3 = new TimelineMax({repeat:-1});
				// tl3.to('.clouds2', 80, {backgroundPositionX: -903, ease: "power1.out"});

				// var repDelay = 8;
				// var firsFlash = 0.05;
				// var secondFlash = 0.05;
				// var flashTime = 0.6;

				// var tldn7 = new TimelineMax({repeat:-1, repeatDelay: repDelay});
				// tldn7.set('.brightness', {opacity: "0"})
				// .to('.brightness', secondFlash, {opacity: "1"}, '+=0.0')
				// .to('.brightness', 4.0, {opacity: "0", ease: "expo.out"}, '+=0.0')
				// .to('.brightness', firsFlash, {opacity: "1"}, '-=0.0')
				// .to('.brightness', 4.0, {opacity: "0", ease: "expo.out"});	

				// var tldn1 = new TimelineMax({repeat:-1, repeatDelay: repDelay});
				// tldn1.set('.flash', {opacity: "0"})
				// .to('.flash', secondFlash, {opacity: "1"}, '+=0.0')
				// .to('.flash', 4.0, {opacity: "0", ease: "expo.out"}, '-=0.0')
				// .to('.flash', firsFlash, {opacity: "1"}, '-=0.0')
				// .to('.flash', 4.0, {opacity: "0", ease: "expo.out"});	

				// var tldn5 = new TimelineMax({repeat:-1, repeatDelay: repDelay});
				// tldn5.set('.clouds2', {visibility: "visible"})
				// .to('.clouds2', secondFlash, {visibility: "hidden"}, '+=0.0')
				// .to('.clouds2', 4.0, {visibility: "visible"}, '-=0.0')
				// .to('.clouds2', firsFlash, {visibility: "hidden"}, '-=0.0')
				// .to('.clouds2', 4.0, {visibility: "visible"});		

			var master = gsap.timeline();

			master.add(voodoo())
      .add(warriors())     //with a gap of 2 seconds
      .add(cloud()) 
      .add(cloud2()) 
 			.add(brightness() ) 
 			.add(flash() ) 

			
   //  	let tl =	gsap.timeline();
			// let tlwaranim = tl.to('.warriors', {
			// 	duration: 0.4,
			// 	ease: "power1.out",
			// 	backgroundPositionY: 0,

			// });

 

   //  	var tlwar = new TimelineMax();
   //  	tlwar.to('.warriors', 0.4, {backgroundPositionY: 22, ease: "power1.out"} ).to('.warriors', 5.0, {backgroundPositionY: 0, ease: "power4.out"}, '+=0.2');
    	 
   //  	var tl2 = new TimelineMax({repeat:-1});
			// tl2.to('.clouds', 1200, {backgroundPositionX: 903, ease: "power1.out"});

			// var tl3 = new TimelineMax({repeat:-1});
			// tl3.to('.clouds2', 80, {backgroundPositionX: -903, ease: "power1.out"});

			// var repDelay = 8;
			// var firsFlash = 0.05;
			// var secondFlash = 0.05;
			// var flashTime = 0.6;

			// var tldn7 = new TimelineMax({repeat:-1, repeatDelay: repDelay});
			// tldn7.set('.brightness', {opacity: "0"})
			// .to('.brightness', secondFlash, {opacity: "1"}, '+=0.0')
			// .to('.brightness', 4.0, {opacity: "0", ease: "expo.out"}, '+=0.0')
			// .to('.brightness', firsFlash, {opacity: "1"}, '-=0.0')
			// .to('.brightness', 4.0, {opacity: "0", ease: "expo.out"});	

			// var tldn1 = new TimelineMax({repeat:-1, repeatDelay: repDelay});
			// tldn1.set('.flash', {opacity: "0"})
			// .to('.flash', secondFlash, {opacity: "1"}, '+=0.0')
			// .to('.flash', 4.0, {opacity: "0", ease: "expo.out"}, '-=0.0')
			// .to('.flash', firsFlash, {opacity: "1"}, '-=0.0')
			// .to('.flash', 4.0, {opacity: "0", ease: "expo.out"});	

			// var tldn5 = new TimelineMax({repeat:-1, repeatDelay: repDelay});
			// tldn5.set('.clouds2', {visibility: "visible"})
			// .to('.clouds2', secondFlash, {visibility: "hidden"}, '+=0.0')
			// .to('.clouds2', 4.0, {visibility: "visible"}, '-=0.0')
			// .to('.clouds2', firsFlash, {visibility: "hidden"}, '-=0.0')
			// .to('.clouds2', 4.0, {visibility: "visible"});		


						// var vood = new TimelineMax();

// gsap.to('.voodoo', { duration: 0.2,  webkitFilter:"brightness(1)",
//           filter:"brightness(1)",y: -26, opacity: 0.5, scale: 0.01,  ease: "expoScale(1, 2)"}, '-=0.2')
// 			.to('.voodoo', { duration: 0.6, webkitFilter:"brightness(1)",
//           filter:"brightness(1)",y: -22, opacity: 1, scale: 0.03, ease: "none"}, '+=0.0')	
// 			.to('.voodoo', {duration: 3.5, webkitFilter:"brightness(1)",
//           filter:"brightness(1)",y: -5, opacity: 1, scale: 0.09, ease: "expoScale(1, 2)"}, '-=0.0')	          		
// 			.to('.voodoo', {duration: 0.1, webkitFilter:"brightness(1)",
//           filter:"brightness(0.1)", y:  -20, opacity: 0.3, x: 0, scale: 0.13, ease: "expoScale(1, 2)"}, '+=0.5' )
// 			.to('.voodoo',  {duration: 0.1, y:  -50, scale: 1, opacity: 0, x: 0, ease: "expoScale(1, 2)"} );
    }
  }
</script>
<style scoped>
 

.plashken {
	 /*color: #b52a2c;*/
	position: absolute;
	width: 100%;
 
	height: 0.4em;
}
.blank {
	height: 60px;
}
.container {
	height: 100%;
	overflow: hidden;	
 padding: 0;
	position: relative;	
	display: flex;
	align-items: stretch;
	position: relative;
 
 
	background-color: #13151a;
 
	border-bottom: 2px solid color( #1E1E21 shade(40%));
 
}
.hat {
	height: 140px;
	top: 0;
 
}
.warriors {
	position: absolute;
	display: flex;
	z-index: 20;
	background-repeat: no-repeat;
	background-position: center bottom;
 
	height: 100%;
	width: 100%;
	background-position: 43% 12px;
	background-size: auto 150%;
	background-image: url('./images/_hat/warriors2.png');
}
.war1{
	position: relative;
	background-color: #dad;
 
}
.voodoo {
	/*opacity: 1;*/
	white-space: nowrap;
 
	display: flex;
	align-items: center;
	justify-content: center;
	height: 100%;
	width: 100%;
 /*color: #897ee1;*/
 
	position: absolute;
	/*left: 100px;*/
	font-size: 12vh;
}
.fog {
	align-self: flex-end;	
	background-repeat: no-repeat;
	background-size: contain;
 
	background-position: center bottom;
	height: 100%;
	width: 100%;
 
	background-image: url('./images/_hat/fog.jpg');
}
.brightness{
	filter: brightness(35%);
}
.flash {
	opacity: 0;
	position: absolute;
	height: 100%;
	width: 100%;
	background-repeat: no-repeat;
	background-position: center bottom;
	background-size: cover;
	background-image: url('./images/_hat/flash2.jpg');

}
.dvis {
	visibility: visible;
}
.clouds {  
	opacity: 0.3;
	background-repeat: repeat-x;
	position: absolute;
	background-image: url('./images/_hat/clouds.png');
	background-position: center 0px;
	background-size: 300px  auto;
	height: 100%;
	width: 100%;

}
.clouds2 {  
	/*background-color: #dad;*/
	opacity: 0.9;
	background-repeat: repeat-x;
	position: absolute;
	background-image: url('./images/_hat/clouds.png');
	background-position: center 0px;
	background-size: 800px auto;
	height: 100%;
	width: 100%;
	
}
.bgshad {
background: rgb(0,0,0);
background: linear-gradient(0deg,  rgba(9,66,121,0) 0%, rgba(6,45,82,0) 20%, rgba(0,0,0,0.8071603641456583) 100%);
	position: absolute;

	height: 100%;
	width: 100%;
}
.bgshad2 {
	z-index: 21;
background: rgb(0,0,0);
background: linear-gradient(180deg, rgba(0,0,0,0) 0%, rgba(0,0,0,0.1) 60%, rgba(0,0,0,0.2) 80%,rgba(0,0,0,0.3) 95%, rgba(0,0,0,0.4) 100%);
	position: absolute;
	height: 100%;
	width: 100%;
}

</style>