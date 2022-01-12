<template>
  <div >
    <div class="infodmg">
      {{hit}}   
    </div>
  <!-- <div class="hitbox" v-on:click="hitcalc"> -->
  <!-- </div> -->
  </div>
</template>
<script>
import { gsap } from "gsap";
export default {
  data: function () {
    return {
      basedamage: 110,
      lvl: 1,
      hit: 0,
    }
  },
  mounted(){

  },
  methods: {
    hitcalc(){
      this.hit = (((this.basedamage * (this.lvl/10 ))  )* (Math.random() * (0.120 - 0.0200) + 0.3).toFixed(2)*10).toFixed()
      var m1 = gsap.timeline();
      m1.from(".infodmg",{
         y:"20px",
        opacity: 1, 
      })
      .to(".infodmg",{
        opacity: 0, 
        y:"-10px",
        duration: 6,
      })
    }
  },
}
</script>
<style scoped>
.infodmg{
  opacity: 0;
}
/*.hitbox{
  height: 1em;
  width: 4em;
  background-color: #dad;
}*/
</style>
