<template>
 <div class="dropzone d-flex "> 
  <!-- {{drop}} -->
  <!-- {{pumpkdead}} -->
      <div class="d-flex drop ">
<!-- {{pumpkdead}} -->
        <div v-for="(item, index) in drop" :key = "item.id" >
            <!-- {{item.id}} -->

          <v-tooltip top >
            <template   v-slot:activator="{ on, attrs}" :name="''+item.id" class="d-flex justify-end">

              <div :style="[ signedIn == true ?  {cursor: 'pointer'}:{cursor: 'not-allowed'} ]" v-on:click="pickdrop(item.id)" ><div  v-bind="attrs" v-on="on" class="ore "  v-bind:style="{backgroundImage: 'url(/images/'+item.item+'.png'}"></div></div>
              <div class="energy "></div>
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
   
      // setTimeout(function(){

  
        // },1000 );
      }else{

            var m8 = gsap.timeline();
             m8.to(".ore",{
              
              opacity: 0,
             })
             .to(".ore",{
              y: 25,
              display: "none",
             })
           
        // var m7 = gsap.timeline();
        // m7.to(".ore",{
        //   opacity: 0,
 
        //   duration: 1
        // })
        // .to(".ore",{
 
        //   display: "none",
        // }) 

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
    ...mapState(useLogStore, {
      signedIn: "thissignedIn",
    }),      
  },
  created () {
    console.log("drop")
  },
  updated () {
    
  },
  methods: {
    dropanim(){
      this.$nextTick(function () {
        var m4 = gsap.timeline();
        m4.to(".energy",{
          // stagger: 1.9,
          stagger: {
            each: 1.5,
            // onStart: bgadd,
            // duration: 0.7,
            onComplete: bgnull,
          },
          background: 'url(/images/energyonce.gif?a='+Math.random()+')',
          duration: 1.5,
          delay: 2.5, 
          opacity: 1,
          // display: "inline"
          visibility: "visible",
          // onComplete: bgnull
        })
        // function bgadd(){
        //   var m11 = gsap.timeline();
        //    m11.to(".energy",{
 
        //     background: 'url(/images/energyonce.gif?a='+Math.random()+')',
        //    })
        // }

        // var self = this
        function bgnull(){
          // console.log(self.pumpkdead)
          console.log(" pumpkdead")
          var m9 = gsap.timeline();
          m9.to(".energy",{
          // top: 20,
          background: 'none',
          // delay: 0.7,
          // background: 'url(/images/energytwo.gif)',
          // opacity: 0,
          // display: "none",
          // visibility: "hidden"
          })
        }
        gsap.set(".ore", {
          y: 25,
          opacity: 0,
          display: "none",
          // visibility: "hidden"
        });
        var m3 = gsap.timeline();
        m3.to(".ore",{
          stagger: 1.2,
          delay: 2.6,
          y: 0,
          opacity: 1,
          display: "block",
          visibility: "visible",
          duration: 1,
          ease: "power4.out",
          onComplete: oreswing
        })
        // var self = this 
        function oreswing(){
          var self = this
          
          if (self.pumpkdead == true){
            var m8 = gsap.timeline({repeat: -1});
            m8.to(".ore",{
              // stagger: 1,
              ease: "expo.in",
              y: -3,
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
        }
      })
    },    
    pickdrop(val){
      console.log("pickdrop")
      if (this.signedIn == true){
         this.$http.secured.post('/my_items/pickdrop',{id: val})
        .then(response => { 
          console.log(response.data)
          // this.loareg = response.data
        })
        .catch(error => { this.setError(error, 'Something went wrong') })   
      }   
    },
    getdrop(){
       this.$http.plain.get('/my_items/getdrop')
      .then(response => { 
        console.log(response.data)
        this.drop = response.data
        this.dropanim()
        // this.loareg = response.data
      })
      .catch(error => { this.setError(error, 'Something went wrong') })
    },   
  }
}
</script>

<style lang="css">
.dropzone{
  /*overflow: hidden;*/
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
  /*background: url(../../../javascript/images/energy27.gif);*/
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
  /*visibility: hidden;*/
  /*opacity: 0;*/
  z-index: 1;
  /*position: absolute;*/
  position: relative;
  /*bottom: 0px;*/
  width: 38px;
  height: 38px;
  /*background: url(../../../javascript/images/goldenore.png);*/
  /*cursor: pointer;*/
}
</style>