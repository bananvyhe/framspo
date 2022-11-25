<template>
  <div class="main mx-0 my-0">
  
<!--     <div class="d-flex justify-center">
      <v-tooltip top class="drop">
        <template v-slot:activator="{ on, attrs}">
          <span  v-bind="attrs" v-on="on" class="ore">
          </span>
          <span  class="energy"></span>
        </template>
        <span><span style="color:#ffe79f;">Камень</span> <br><span class="caption">можно забрать после регистрации</span></span>
      </v-tooltip> 
    </div> -->

    <drop></drop>
 <!-- <div class="mob" :style="[  reuse ?  {cursor: 'not-allowed'}:{} ]"> -->
  <!-- <div class="mob" :style="[  reuse ?  {cursor: 'not-allowed'}:{} ]"> -->
    <div v-if="loc == 'alive'" class="unit  " v-on:click="handler('foo','bar')" > 
      <div class="hpoints d-flex justify-center subtitle-2">{{hpoints}}</div> 
      <damagecomp ref="hitt"></damagecomp>
      <div class="hpbar">
        <v-progress-linear :value="hp" color="success"></v-progress-linear>
      </div>
      <div class="character" :style="[  reuse ?  {cursor: 'not-allowed'}:{} ]"></div>
    </div>

    <div v-if="loc == 'death'"   class="off " v-on:click="handler('foo','bar')"> 
      <div class="hpoints d-flex justify-center subtitle-2">{{hpoints}}</div> 
      <damagecomp ref="hitt"></damagecomp>
      <div class="hpbar">
        <v-progress-linear :value="hp" color="success"></v-progress-linear>
      </div>
      <div class="death":style="[  reuse ?  {cursor: 'not-allowed'}:{} ]"></div>
    </div>       
  <!-- </div> -->
  

 <!-- </div> -->


	</div>
</template>
<script>
  import Drop from './packs/components/drop.vue'
  import { mapState, mapActions } from 'pinia' 
  import { useLogStore } from 'store.js'
  
	import Damagecomp from './damagecomp.vue'
	// import ScrambleText from 'scramble-text'; 
	// import { VueTyper } from 'vue-typer'
  import { gsap } from "gsap";
  import ls from 'localstorage-slim';
    export default {   
	  components: {
	    'damagecomp': Damagecomp,
      'drop': Drop
	  },
    data: function (){
      return {
        classObject: {
          active: true,
          'text-danger': false
        },        
      	hpoints: 124,
        hp: 100,
        dmg: '',
        loc: ''
      }
    },
    computed:{
      ...mapState(useLogStore, {
        reuse: "thisreuse",
      }),         
      ...mapState(useLogStore, {
        signedIn: "thissignedIn",
      }), 
    },
    methods: {
      ...mapActions(useLogStore, ["reuseCalc"]),        
      ...mapActions(useLogStore, ["increments"]),
      ...mapActions(useLogStore, ["setPumpkDead"]),
      ...mapActions(useLogStore, ["setPumpkAlive"]),   
      incloareg(){

      },
    	handler(arg1,arg2){
        
        if (this.reuse == false){
          this.hitn()
          if (ls.get('hey') == "death"){
            console.log("pumpk is dead!")
          }else{
            this.hitpumpk()
            this.reuseCalc()
          }
        }else{

        }

    	},
      hitn(){
        var hitn = gsap.timeline();
        hitn.to(".character",{
           x: -4,
           duration: 0.2,  
           ease: "elastic.in",
        }).to(".character", {
          x: 0,
          duration: 0.2,  
          ease: "elastic.out", 
        })    
      },
    	hitpumpk(){
        
    		var interval = 15000000;
        // var interval = 26500;
    		this.$refs.hitt.hitcalc();
    		this.dmg = this.$refs.hitt.hit
				var hpleft = this.hpoints - this.dmg
        var percentcut = hpleft * 100 / this.hpoints
        this.hpoints = hpleft
        this.hp = percentcut
        console.log(this.hp)
        if (this.hpoints <= 0){
      		ls.set('hey', "death") 
          this.setPumpkDead()
      		reset();
      		var min = 2
			    var max = 5
			    var loa = Math.random() * (max - min) + min;
			    loa =  Math.round(loa)
			    loa = Number(loa)
      		// this.$store.commit('increment', loa)
          if (this.signedIn == true){
            this.$http.secured.post('/incloareg', {loa: loa})
            .then(response => { 
               console.log(response)
               this.increments(loa)   
            })
            .catch(error => { this.setError(error, 'Something went wrong') })
          }else{
            this.increments(loa)            
          }


      		// console.log(ls.get('load'))
      		// console.log(loa)
        }else{
        	// localStorage.hp = "alive"
        	console.log("else hitpumpk ")

        }
        function reset(){
      		// занесение в локалсторадж даты окончания таймера
      		var endt =  +new Date + interval
				   ls.set('endTimer', endt)  
				  // console.log("endt")
				  // console.log(endt)
				}
    	}
    },
 		created() {

			if (ls.get('hey') != "death"){
    		this.loc = "alive"
    		console.log("666")
    	}
 		},
    mounted() {
    	if(ls.get('endTimer') == "death"){
    		ls.set('hey', "alive") 
    	} 
 
    	if (ls.get('hey')){
    		this.loc = ls.get('hey')
    	}
    	
      window.addEventListener('load', () => {
 
        var self = this
				setInterval(function(){
					if( ls.get('hey') == "death" ){
						// занесение в переменную оставшиеся милисекунды до окончания(обратный отсчет)
						var getendt = ls.get('endTimer')
			    	var remaining = getendt - new Date;
			    	console.log(getendt)
			  	}
			  	// если отсчет не завершился то присваиваем статус "мертвый" в локалсорадж
			    if( remaining >= 0 ){
            self.setPumpkDead()
			      ls.set('hey', "death") 
			      console.log("dead")
			      console.log(remaining)
			    }else if ( remaining < 0 ){
            self.setPumpkAlive()
            // var m3 = gsap.timeline();
            // m3.to(".ore",{
            //   opacity: 0,
            //   display: "none",
            //   duration: 1
            // })
			      var alive = gsap.timeline();
			      alive.to(".off",{
              delay: 2,
	 						className: "+=unit",
	 					})
	 					var m1 = gsap.timeline();
	 					m1.to(".death",{
              delay: 2,
	 						className: "+=character",
	 							onComplete: ressurect
	 					})
	 					console.log("alive")
	 					ls.set('hey', "alive") 
			    }
			  }, 1000);		
			  var self = this
			  function ressurect() {	
			  	self.hp = 100
			  	self.hpoints = 124
			  	pumpk()
			  }

        function pumpk() {
          gsap.set(".character", {
            scale: 1.5,
          });

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
     				if (ls.get('hey') == "death"){
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
      	      function end(){
              var m2 = gsap.timeline();
              m2.to(".unit",{
                className: "+=off",
                // onComplete: oregen
              })
      }

					  	}
						}
          }
        }
        var master = gsap.timeline();
        if (ls.get('hey') == "alive" || !ls.get('hey')){
        	master.add(pumpk())
        }
      })
    }
  }
</script>
<style scoped>
.mob:hover{
  cursor: url("./images/sword.png"), pointer;
}
.energy{
    display: none;
    opacity: 0;
  top:22px;
  position: absolute;
  width: 150px;
  height: 70px;
  background: url(./images/energy27.gif);
}
.disdiv{
  /*background-color: #dad;  */
  position: absolute;
  bottom: 1.5em;
  right: 1.5em;
}
.main{
  position: relative;
}
/*.ore{
  display: none;
  z-index: 1;
  position: absolute;
  
  opacity: 0;
  bottom: 0px;
  width: 38px;
  height: 38px;
  background: url(./images/ore.png);
  cursor: pointer;
}*/
.hpoints{

}
.off{
	opacity: 0;
}
.death{
  image-rendering: pixelated;
	background: url(./images/sprites/monsters/pumpkinbow.png);
  width: 48px;  height: 48px; 
}
.hpbar{
  margin: 0 7px ;
  /*margin-bottom: -10px;*/
}
.unit{
	/*margin: 0.5em;*/
  width: 48px;
}
.unit:hover{
  /*cursor: url("./images/sword.png"), pointer;*/
}

.character {
  z-index: 2;
  position: relative;
  background: url(./images/sprites/monsters/pumpkina.png);
  image-rendering: pixelated;
  width: 48px;  height:48px; 
  cursor: url("./images/sword.png"), pointer;
}
.character:hover{
  cursor: url("./images/sword.png"), pointer;
}
</style>