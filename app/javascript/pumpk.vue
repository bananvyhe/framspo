<template>
  <div>
  	
    <div class="unit" v-on:click="hitpumpk"> <damagecomp ref="hitt"></damagecomp>
      <div class="hpbar"><v-progress-linear :value="hp"></v-progress-linear></div>
      <div class="character"></div>
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
        dmg: ''
      }
    },
    methods: {
    	hitpumpk(){
    		this.$refs.hitt.hitcalc();
    		this.dmg = this.$refs.hitt.hit
				var hpleft = this.hpoints - this.dmg
        var percentcut = hpleft * 100 / this.hpoints
        this.hpoints = hpleft
        this.hp = percentcut
        console.log(this.hp)
        if (this.hp <= 0){
      			localStorage.hp = "death"
      			console.log(localStorage.hp)
        }else{
        	localStorage.hp = "alive"
        	console.log(localStorage.hp)
        }
        // if (this.hpoints <= 0){
        // 	var m2 = gsap.timeline();
        // 	 m2.to(".character",{
        //     duration: 1,
        //     repeat:-1,
        //     repeatDelay: 1,
        //     backgroundPosition: "-528px",
        //     ease: "steps(11)"
        //   })

        // }

    	}
    },
    created() { 
    
  	},
    mounted() {
      window.addEventListener('load', () => {
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
			          	 
			          })
					  		.call(removeElement(".unit"))
			          function removeElement(element) {
								  if (typeof(element) === "string") {
								    element = document.querySelector(element);
								  }
								  return function() {
								    element.parentNode.removeChild(element);
								  };
								}

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
        master.add(pumpk())
      })
    }
  }
</script>
<style scoped>
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