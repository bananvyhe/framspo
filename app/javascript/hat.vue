<template>
  <div class="hat">
  	<!-- <div class="blank"></div> -->
  	<div class="container">
	  	<div class="fog"></div>
	  	<div class="flash"></div>

	  	<div class="clouds2"></div>
	  	<div class="bgshad"></div>
	  	<div class="voodoo font3">
	  		<!-- VooDoo power  -->
	  		powered by NGINX 
	  	</div>
	  	<div class="clouds"></div>
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

  export default {
    data: function (){
      return {
      	repDelay: 8
        
      }
    },
    methods: {
    },
    created() { 
    	// console.log('6666updatedHat');
  
    		// var tlwar2 = new TimelineMax();		
    	 //    	tlwar2.to('.warriors', 0.1, {backgroundPositionY: 0, ease: Sine.easeOut}, '-=0.0');
  	},
    mounted() {
    	// console.log('22222updatedHat')
			var vood = new TimelineMax();
			vood.to('.voodoo', 0.2, { webkitFilter:"brightness(1)",
          filter:"brightness(1)",y: -26, opacity: 1, scale: 0.08,  ease: Expo.easeIn}, '-=0.2')
			.to('.voodoo', 0.6, { webkitFilter:"brightness(1)",
          filter:"brightness(1)",y: -22, opacity: 1, scale: 0.08, ease: "none"}, '+=0.0')	
			.to('.voodoo', 3.5, { webkitFilter:"brightness(1)",
          filter:"brightness(1)",y: -10, opacity: 1, scale: 0.13, ease: Expo.easeInOut}, '-=0.0')	          		
			// .to('.voodoo', 0.1, {webkitFilter:"brightness(0.8)",
   //        filter:"brightness(0.1)", y:  -20, opacity: 0.3, x: 0, scale: 0.24, ease: Quad.easeOut}, '+=0.5' )
 		
			.to('.voodoo', 0.1, {webkitFilter:"brightness(0.9)",
          filter:"brightness(0.9)", y:  -50, scale: 1, opacity: 0, x: 0, ease: Quad.easeOut}, '-=0.3' );

    	var tlwar = new TimelineMax();
    	tlwar.to('.warriors', 0.4, {backgroundPositionY: 22, ease: Power0.easeOut} ).to('.warriors', 5.0, {backgroundPositionY: 0, ease: Power4.easeOut}, '+=0.2');
    	 
    	var tl2 = new TimelineMax({repeat:-1});
			tl2.to('.clouds', 1200, {backgroundPositionX: 903, ease: Power0.easeNone});

			var tl3 = new TimelineMax({repeat:-1});
			tl3.to('.clouds2', 80, {backgroundPositionX: -903, ease: Power0.easeNone});

			var repDelay = 8;
			var firsFlash = 0.05;
			var secondFlash = 0.05;
			var flashTime = 0.6;

			// var repDelay = 8;
			// var self = this;
			// function randomize() {
			// 	var min = 3.0
			// 	var max = 12.0
			// 	var repDelay = Math.random() * (max - min) + min;
			// 	self.repDelay =  Math.round(repDelay)
			// 	console.log(repDelay)
			// }



			// var tlfl1 = new TimelineMax({repeat:-1, repeatDelay: repDelay});
			// tlfl1.to('.clouds', firsFlash, {css:{className:'+=brightness'}}, '+=2.6')
			// .to('.clouds', 0.05, {css:{className:'-=brightness'}})
			// .to('.clouds', secondFlash, {css:{className:'+=brightness'}}, '+=0.05')
			// .to('.clouds', 0.05, {css:{className:'-=brightness'}})
			// .to('.clouds', flashTime, {css:{className:'+=brightness'}}, '+=0.05')
			// .to('.clouds', 0.05, {css:{className:'-=brightness'}});

 		// 	var tlfl2 = new TimelineMax({repeat:-1, repeatDelay: repDelay});
			// tlfl2.to('.clouds2', firsFlash, {css:{className:'+=brightness'}}, '+=2.6')
			// .to('.clouds2', 0.05, {css:{className:'-=brightness'}})
			// .to('.clouds2', secondFlash, {css:{className:'+=brightness'}}, '+=0.05')
			// .to('.clouds2', 0.05, {css:{className:'-=brightness'}})
			// .to('.clouds2', flashTime, {css:{className:'+=brightness'}}, '+=0.05')
			// .to('.clouds2', 0.05, {css:{className:'-=brightness'}});
			// var tldn1 = new TimelineMax({repeat:-1, repeatDelay: repDelay});
			// tldn1.set('.flash', {visibility: "hidden"})
			// .to('.flash', firsFlash, {visibility: "visible"}, '+=2.6')
			// .to('.flash', 0.05, {visibility: "hidden"})
			// .to('.flash', secondFlash, {visibility: "visible"}, '+=0.05')
			// .to('.flash', 0.05, {visibility: "hidden"})
			// .to('.flash', flashTime, {visibility: "visible"}, '+=0.05')
			// .to('.flash', 0.05, {visibility: "hidden"});
			// var tlfl = new TimelineMax({repeat:-1, repeatDelay: repDelay});
			// tlfl.to('.warriors', firsFlash, {css:{className:'+=brightness'}}, '+=2.6')
			// .to('.warriors', 0.05, {css:{className:'-=brightness'}})
			// .to('.warriors', secondFlash, {css:{className:'+=brightness'}}, '+=0.05')
			// .to('.warriors', 0.05, {css:{className:'-=brightness'}})
			// .to('.warriors', flashTime, {css:{className:'+=brightness'}}, '+=0.05')
			// .to('.warriors', 0.55, {css:{className:'-=brightness'}}, '+=0.55');
			var tldn7 = new TimelineMax({repeat:-1, repeatDelay: repDelay});
			tldn7.set('.brightness', {opacity: "0"})
			// .to('.brightness', firsFlash, {opacity: "1"}, '+=2.6')
			// .to('.brightness', 0.05, {opacity: "0"})
			.to('.brightness', secondFlash, {opacity: "1"}, '+=0.0')
			.to('.brightness', 4.0, {opacity: "0", ease: Expo.easeOut}, '+=0.0')
			.to('.brightness', firsFlash, {opacity: "1"}, '-=0.0')
			.to('.brightness', 4.0, {opacity: "0", ease: Expo.easeOut});	


			var tldn1 = new TimelineMax({repeat:-1, repeatDelay: repDelay});
			tldn1.set('.flash', {opacity: "0"})
			// .to('.flash', firsFlash, {opacity: "1"}, '+=2.6')
			// .to('.flash', 0.05, {opacity: "0"})
			.to('.flash', secondFlash, {opacity: "1"}, '+=0.0')
			.to('.flash', 4.0, {opacity: "0", ease: Expo.easeOut}, '-=0.0')
			.to('.flash', firsFlash, {opacity: "1"}, '-=0.0')
			.to('.flash', 4.0, {opacity: "0", ease: Expo.easeOut});	



			var tldn5 = new TimelineMax({repeat:-1, repeatDelay: repDelay});
			tldn5.set('.clouds2', {visibility: "visible"})
			// .to('.clouds2', firsFlash, {visibility: "hidden"}, '+=2.6')
			// .to('.clouds2', 0.05, {visibility: "visible"})
			.to('.clouds2', secondFlash, {visibility: "hidden"}, '+=0.0')
			.to('.clouds2', 4.0, {visibility: "visible"}, '-=0.0')
			.to('.clouds2', firsFlash, {visibility: "hidden"}, '-=0.0')
			.to('.clouds2', 4.0, {visibility: "visible"});		

			// var tldn6 = new TimelineMax({repeat:-1, repeatDelay: repDelay});
			// tldn6.set('.clouds', {visibility: "visible"})
			// .to('.clouds', firsFlash, {visibility: "hidden"}, '+=2.6')
			// // .to('.flash', 0.05, {visibility: "hidden"})
			// .to('.clouds', secondFlash, {visibility: "hidden"}, '+=0.05')
			// .to('.clouds', 0.05, {visibility: "visible"})
			// .to('.clouds', flashTime, {visibility: "hidden"}, '+=0.05')
			// .to('.clouds', 0.05, {visibility: "visible"});		
    }


  }
 // 	(function(){

	// }());
</script>
<style scoped>
@import "stylesheets/_variables";
@import "stylesheets/_extends";
.plashken {
	position: absolute;
	width: 100%;
	/*background-color: $siteBG;*/
	height: 0.4em;
}
.blank {
	height: 60px;
}
.container {
	height: 100%;
	overflow: hidden;	
	/*height: 110px !important;*/
	position: relative;	
	display: flex;
	align-items: stretch;
	position: relative;
	lost-center: $lcenter;
	/*lost-utility: edit;*/
	/*height: 162px;*/
	background-color: #13151a;
	/*border-radius: 0px 0 4em 4em;*/
	border-bottom: 2px solid color( #1E1E21 shade(40%));
	border
	@media (--only-small-screen) {
		/*height: 9em;*/
  }
 	@media (--only-xsmall-screen) {
		/*height: 9em;*/
  }
}
.hat {

 top: 0;

}
.warriors {

	position: absolute;
	display: flex;
	z-index: 20;
	background-repeat: no-repeat;
	background-position: center bottom;
	/*background-size: cover;*/
	height: 100%;
	width: 100%;
	background-position: 43% 12px;
	background-size: auto 150%;
	background-image: url('./images/_hat/warriors.gif');

	@media (--only-1600more-screen) {
		background-size: auto 155%;
    background-position: 45% 23px;
  }
/*  @media (--only-medium-screen) {
		background-size: auto 100%;
    background-position: center 25px;
  }*/
  @media (--only-xsmall-screen) {
		background-size: 130%;
    background-position: 45% 15px;
  }
  @media (--only-956less-screen) {
		background-size: auto 130%;
    background-position: 45% 15px;
  }
}
.war1{
	position: relative;
	background-color: #dad;
	/*background-image: url('./images/_hat/warriors.gif');*/
}
.voodoo {
	opacity: 0.0;
	white-space: nowrap;
	/*background-color: #dad;*/
	display: flex;
	align-items: center;
	justify-content: center;
	height: 100%;
	width: 100%;
 	/*color: $str5;*/
 	/*color: $screenbg;*/
	color: color( $screenbg  saturation(92%) shade(65%) tint(10%) blackness(70%));
	position: absolute;
	font-size: 22vh;
	padding-right: 2em;
	@media (--only-956less-screen) {
		padding-right: 0em;
	}
	/*transform: perspective(200px) rotateX(-60deg);*/
	/*opacity: 0.8;*/
}
.fog {
	align-self: flex-end;	
	background-repeat: no-repeat;
	background-size: contain;
	/*background-size: 80% auto;*/
	background-position: center bottom;
	height: 100%;
	width: 100%;
	/*position: absolute;*/
	background-image: url('./images/_hat/fog.jpg');
}
.brightness{
	filter: brightness(35%);
}
.flash {
 	/*visibility: hidden;*/
	position: absolute;
	height: 100%;
	width: 100%;
	background-repeat: no-repeat;
	background-position: center bottom;
	background-size: cover;
	background-image: url('./images/_hat/flash.jpg');
	@media (--only-1600more-screen) {
    background-position: center -70px;
  }
  @media (--only-medium-screen) {
    background-position: center -50px;
  }
}
.dvis {
	visibility: visible;
}
.clouds {  
	opacity: 0.5;
	background-repeat: repeat-x;
	position: absolute;
	background-image: url('./images/_hat/clouds.png');
	background-position: center -15px;
	background-size: 40%  auto;
	height: 100%;
	width: 100%;
	@media (--only-xsmall-screen) {
		background-size: 65%  auto;
  }
  @media (--only-small-screen) {
		background-size: 55%  auto;
  }
  @media (--only-medium-screen) {
		background-size: 45%  auto;
  }
}
.clouds2 {  
	background-repeat: repeat-x;
	position: absolute;
	background-image: url('./images/_hat/clouds.png');
	background-position: center -15px;
	background-size: 90%  auto;
	height: 100%;
	width: 100%;
	@media (--only-xsmall-screen) {
		background-position: center 0px;
		background-size: 100%  auto;
  }
  @media (--only-small-screen) {
  	background-position: center 0px;
		background-size: 100%  auto;
  }
  @media (--only-medium-screen) {
		background-size: 95%  auto;
  }
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