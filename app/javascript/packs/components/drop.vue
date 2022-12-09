<template>
 <div class="dropzone d-flex "> 
  <!-- {{drop}} -->
  <!-- {{pumpkdead}} -->
      <div class="d-flex justify-center drop">

        <div v-for="(item, index) in drop">
            <!-- {{item.id}} -->

          <v-tooltip top >
            <template   v-slot:activator="{ on, attrs}" :name="''+item.id" class="d-flex justify-center">

              <div  v-bind="attrs" v-on="on" class="ore"  v-bind:style="{backgroundImage: 'url(/images/'+item.item+'.png'}"></div>
              <div  class="energy"></div>
            </template>
            <span>
              <span style="color:#ffe79f;" >
                <!-- {{item.title}} -->
                {{item.title}}
              </span> 
              <br>
              <span >
                <!-- {{item.desc}} -->
                {{item.desc}}
              </span>
            </span>
          </v-tooltip> 

      </div>

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
      drop: []
    }
  },
  watch:{
    drop: function (){
      console.log("drop incoming")


   
    },
    pumpkdead: function (val){
      console.log("DROPval")

    // console.log(val)
    if (val == true){
      this.getdrop()
      console.log('val')
      console.log(val)
      console.log('val')
 
      setTimeout(function(){
        var m4 = gsap.timeline();
          m4.to(".energy",{
            stagger: 1,
            delay: 1.9,
            opacity: 1,
            // display: "inline"
            visibility: "visible"

          })
          .to(".energy",{
            delay:0.7,
            opacity: 0,
            // display: "none",
            visibility: "hidden"
          })
          gsap.set(".ore", {
            y: +15,
            opacity: 0,
            // display: "none",
            visibility: "hidden"
          });
          var m3 = gsap.timeline();
          m3.to(".ore",{
            stagger: 1,  
            delay: 1.9,
            y: 0,
            opacity: 1,
            // display: "inline",
            visibility: "visible",
            duration: 1.5,
            ease: "power4.out",
            onComplete: oreswing
          })
            function oreswing(){
              var m8 = gsap.timeline({repeat: -1});
              m8.to(".ore",{
                stagger: 1,
                ease: "expo.in",
                y: -2,
                duration: 3,
                ease: "elastic.in",
              })
              .to(".ore",{
                // stagger: 1,
                ease: "elastic.out", 
                y: 0,
                duration: 3,
              })                   
            }
  
        },1000 );
      }else{
        var m3 = gsap.timeline();
        m3.to(".ore",{
          opacity: 0,
          // display: "none",
          visibility: "hidden",
          duration: 1
        })   
      }
    }
  },
  mounted () {
    // gsap.set(".energy", {
    //   opacity: 0,
    //   // display: "none",
    // }); 
    // gsap.set(".ore", {
    //   opacity: 0,
    // });      
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

    getdrop(){

       this.$http.plain.get('/my_items/getdrop')
      .then(response => { 
        console.log(response.data)
        this.drop = response.data

        // this.loareg = response.data
        
      })
      .catch(error => { this.setError(error, 'Something went wrong') })
    },   
  }
}
</script>

<style lang="css">
.dropzone{
  position: absolute;
/*background-color: #da4;*/
}
/*.v-progress-circular {
  margin: 1rem;
}*/
.drop{
  /*background-color: #ada;*/
  position: relative;
}
.energy{
  /*background-color: #dad;*/
    /*display: none;*/
    margin-left: -57px;
    visibility: hidden;
    opacity: 0;
  top:-16px;
  /*left: -40px;*/

  position: absolute;
  /*position: relative;*/
  width: 150px;
  height: 70px;
  background: url(../../../javascript/images/energy27.gif);
}
/*.ore{
  display: none;
  z-index: 1;
  position: absolute;
  background-color: #dad;
  opacity: 0;
  bottom: 0px;
  width: 38px;
  height: 38px;
  background: url(../../../javascript/images/ore.png);
  cursor: pointer;
}*/
.ore{
  /*display: none;*/
  visibility: hidden;
  opacity: 0;
  z-index: 1;
  /*position: absolute;*/
position: relative;
  bottom: 0px;
  width: 38px;
  height: 38px;
  /*background: url(../../../javascript/images/goldenore.png);*/
  cursor: pointer;
}
</style>