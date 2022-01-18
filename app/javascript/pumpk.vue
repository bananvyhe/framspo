<template>
  <div>
 
    <div v-if="loc == 'alive'"   class="unit mb-0" v-on:click="handler('foo','bar')"> 
    	<div class="hpoints d-flex justify-center subtitle-2">{{hpoints}}</div>	
    	<damagecomp ref="hitt"></damagecomp>
      <div class="hpbar">
      	<v-progress-linear :value="hp"></v-progress-linear>
      </div>
      <div class="character"></div>
    </div>
     <div v-if="loc == 'death'"   class="off" v-on:click="handler('foo','bar')"> 
    	<damagecomp ref="hitt"></damagecomp>
      <div class="hpbar">
      	<v-progress-linear :value="hp"></v-progress-linear>
      </div>
      <div class="death"></div>
    </div>   
	</div>
</template>
<script>
	import Damagecomp from './damagecomp.vue'
	// import ScrambleText from 'scramble-text'; 
	// import { VueTyper } from 'vue-typer'
import { gsap } from "gsap";

  export default {
	  components: {
	    'damagecomp': Damagecomp,

	  },
    data: function (){
      return {
      	hpoints: 124,
        hp: 100,
        dmg: '',
        loc: ''
      }
    },
    methods: {
    	handler(arg1,arg2){
    		if (localStorage.hp == "death"){
    			console.log("pumpk is dead!")
    		}else{
    			this.hitpumpk()
    		}
    	},
    	hitpumpk(){
    		var interval = 15000000;
    		this.$refs.hitt.hitcalc();
    		this.dmg = this.$refs.hitt.hit
				var hpleft = this.hpoints - this.dmg
        var percentcut = hpleft * 100 / this.hpoints
        this.hpoints = hpleft
        this.hp = percentcut
        console.log(this.hp)
        if (this.hpoints <= 0){
      		localStorage.hp = "death"
      		reset();
      		var loasend  = Math.floor(Math.random() * 6) + 3;
      		this.$store.commit('increment', loasend)
      		console.log(localStorage.loa)
      		console.log(loasend)
        }else{
        	// localStorage.hp = "alive"
        	console.log("else hitpumpk ")
        }
        function reset(){
      		// занесение в локалсторадж даты окончания таймера
				  localStorage.endTime = +new Date + interval;
				  console.log("сброс таймера")
				}
    	}
    },
 
    mounted() {
    	if (localStorage.hp != "death"){
    		this.loc = "alive"
    	}
    	this.loc = localStorage.hp
      window.addEventListener('load', () => {
      	
      	// console.log(+new Date + interval)
      	// timer res pumpk
      	

				// if( localStorage.hp == "death"){
				// 	reset();
				// }
				setInterval(function(){

					if( localStorage.hp == "death" ){
						// занесение в переменную оставшиеся милисекунды до окончания(обратный отсчет)
			    	var remaining = localStorage.endTime - new Date;
			  	}
			  	// если отсчет не завершился то присваиваем статус "мертвый" в локалсорадж
			    if( remaining >= 0 ){
			      localStorage.hp = "death"
			      console.log("dead")
			      console.log(remaining)

			    }else if ( remaining < 0 ){
			     
			      
			      var alive = gsap.timeline();
			      alive.to(".off",{
	 						className: "+=unit",
	 					})
	 					var m1 = gsap.timeline();
	 					m1.to(".death",{
	 						className: "+=character",
	 							onComplete: ressurect
	 					})
	 					console.log("alive")
	 					localStorage.hp = "alive"
 
			    }
			  }, 1000);		
			  var self = this
			  function ressurect() {	
			  	self.hp = 100
			  	self.hpoints = 124
			  	pumpk()
			  }

        function pumpk() {
          var m1 = gsap.timeline();
          m1.to(".character",{
            duration: 1,
            repeat:-1,
            repeatDelay: 1,
            backgroundPosition: "-528px",
            ease: "steps(11)",
            onRepeat: myFunction
          })
          function myFunction(){
     				if (localStorage.hp == "death"){
            	console.log("death")
					    	m1.to(".character",{
						     	className: "+=death",
						     	onComplete: endFunc
					    	})
					  	function endFunc(){
					    	m1.kill()
					    	var m2 = gsap.timeline();
					  		m2.to(".death",{
			          	duration: 1,
			          	backgroundPosition: "-960px",
			          	ease: "steps(20)",
			          	onComplete: end
			          })
					  	// 	.call(removeElement(".unit"))
			     //      function removeElement(element) {
								//   if (typeof(element) === "string") {
								//     element = document.querySelector(element);
								//   }
								//   return function() {
								//     element.parentNode.removeChild(element);
								//   };
								// }

	 							function end(){
	 								m2.to(".unit",{
	 									className: "+=off",
	 								})
	 							}
					  	}
						}
          }
        }
        var master = gsap.timeline();
        if (localStorage.hp == "alive"){
        	master.add(pumpk())
        }
        
      })
    }
  }
</script>
<style scoped>
.hpoints{

}
.off{
	opacity: 0;
}
.death{
	background: url(./images/sprites/monsters/pumpkinbow.png);
  width: 48px;  height:48px; 
}
.hpbar{
  margin: 0 10px ;
  margin-bottom: -8px;
}
.unit{
	margin: 0.5em;
  width: 48px;
}
.unit:hover{

cursor: url("./images/sword.png"), pointer;
 
}

.character {

  background: url(./images/sprites/monsters/pumpkina.png);
  width: 48px;  height:48px; 
}
</style>