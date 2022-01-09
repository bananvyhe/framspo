<template>
  <div>
    <div class="unit"> 
      <div class="hpbar"><v-progress-linear value="15"></v-progress-linear></div>
      <div class="character"></div>
    </div>
	</div>
</template>
<script>
	// import ScrambleText from 'scramble-text'; 
	// import { VueTyper } from 'vue-typer'
import { gsap } from "gsap";
  export default {
    data: function (){
      return {
        
      }
    },
    methods: {

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
            backgroundPosition: "-528px",
            ease: "steps(11)"
          });
        }
        var master = gsap.timeline();
        master.add(pumpk())
      })
    }
  }
</script>
<style scoped>
.hpbar{
  margin: 0 10px ;
  margin-bottom: -8px;
}
.unit{

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