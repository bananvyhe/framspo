<template>
 <div> 
  <!-- {{pumpkdead}} -->
      <div class="d-flex justify-center">
      <v-tooltip top >
        <template v-slot:activator="{ on, attrs}">
          <span  v-bind="attrs" v-on="on" class="ore">
          </span>
          <span  class="energy"></span>
        </template>
        <span><span style="color:#ffe79f;">Камень</span> <br><span >можно забрать после регистрации</span></span>
      </v-tooltip> 
    </div>
 </div>
</template>

<script>
  import { mapState } from 'pinia'
  import { mapActions } from 'pinia'
  import { useLogStore } from 'store.js'
  import { gsap } from "gsap";
export default {
  //  setup() {
  //   const store = uselogStore()
  //   return {
  //     // you can return the whole store instance to use it in the template
  //     store,
  //   }
 
  // },  
  name: 'Signin',
  data () {
    return {
   
    }
  },
  watch:{
    pumpkdead: function (val){
      // console.log("val")
    // console.log(val)
    if (val == true){

      // function end(){
      //   var m2 = gsap.timeline();
      //   m2.to(".unit",{
      //     className: "+=off",
      //     onComplete: oregen
      //   })
        function oregen(){
          var m4 = gsap.timeline();
            m4.to(".energy",{
               delay: 1.9,
              opacity: 1,
              display: "inline"

            }).to(".energy",{
              delay:0.7,

              display: "none"

            })                      
          gsap.set(".ore", {

            y: +15,
          });
          var m3 = gsap.timeline();
          m3.to(".ore",{
            delay: 1.9,
            y: 0,
            opacity: 1,
            display: "inline",
            duration: 1.5,
            ease: "power4.out",

          })
        }
      // }   
      var drop = gsap.timeline();
      drop.add(oregen())     
    }else{
      var m3 = gsap.timeline();
      m3.to(".ore",{
        opacity: 0,
        display: "none",
        duration: 1
      })
         
    }
   
    }

  },
  mounted () {
    
    },
  computed: {
      // ...mapState(useLogStore, {
      //   reuse: "thisreuse",
      // }),          
    ...mapState(useLogStore, {
      pumpkdead: "thispumpkdead",
    }),      
  },    
  created () {
    console.log("drop")
  },
  updated () {
    
  },
  methods: {
 
  }
}
</script>

<style lang="css">
/*.v-progress-circular {
  margin: 1rem;
}*/
.energy{
    display: none;
    opacity: 0;
  top:22px;
  position: absolute;
  width: 150px;
  height: 70px;
  background: url(../../../javascript/images/energy27.gif);
}
.ore{
  display: none;
  z-index: 1;
  position: absolute;
  
  opacity: 0;
  bottom: 0px;
  width: 38px;
  height: 38px;
  background: url(../../../javascript/images/ore.png);
  cursor: pointer;
}
.ore{
  display: none;
  z-index: 1;
  position: absolute;
  
  opacity: 0;
  bottom: 0px;
  width: 38px;
  height: 38px;
  background: url(../../../javascript/images/goldenore.png);
  cursor: pointer;
}
</style>