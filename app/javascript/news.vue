<template>
  <div class=" py-0 px-0"> 
    <div style="display:none;">
      {{loa = this.logstat}}
    </div> 
 
<!-- 
    v-bind:spritesheet="require('./images/sprites/monsters/pumpkin.png')"
    v-bind:json="require('./images/sprites/monsters/pumpkin.json')" -->
    
    <v-card v-for="(item, index) in alld " :key= "item.id" 
      class="px-1 my-2 py-2 ">
      <v-row>
        <v-col>
          <div 
          class="align-top  float-left mr-1 px-3 py-md-1 mx-md-1">
          <!-- {backgroundImage: 'url('+ item.pic} -->
            <div class ="pic px-0  align-center my-2" v-bind:style="{backgroundImage: 'url('+ item.pic}">
              <!-- {{pos}} -->
            </div>
          </div>
          <div
            class="px-2 pt-2 pb-2 colr"
            v-text=""><h3>{{item.head}}</h3>
          </div>
          <div class="px-2 body-1">
            {{item.desc}}… 
          </div>
          <v-card-subtitle
          class="px-2 py-0 float-left date">
          {{item.date}} 
          </v-card-subtitle>

          <v-btn  
            target="_blank" 
            v-bind:href="item.link"
            class="px-1 py-0 float-left"
            color="orange lighten-2"
            text x-small>
            источник
          </v-btn>  
 
          <div v-if=" loa >= 5">
            <div class="disdiv">
              <v-btn
              class="px-2 py-0 mx-2 but"
              @click="clickhandler(item.id, $event)"
              small>
                открыть
              </v-btn>                 
            </div>
             
          </div>
          <div v-else>
            <v-tooltip top  >
              <template v-slot:activator="{ on, attrs}">
                <div v-on="on" v-bind="attrs" class="disdiv"  >
                  <v-btn 
                    class="px-2 py-0 mx-2 but"
                    @click="clickhandler(item.id, $event)"
                    disabled
                    small>
                    открыть
                </v-btn>                    
                </div>
              </template>
              <span>недостаточно loa</span>
            </v-tooltip> 
          </div>

  <!-- {{bottom}} -->
          <div v-if="item.id == empid">
            <v-dialog
              v-model="dialogVisible"
              max-width="1080px"
              width="95%">
              <v-card 
              class="px-md-5 py-md-2">
                <v-card-title class="pb-md-4">
                  <h5>{{item.head}}</h5>
                </v-card-title>
                <v-card-text >
                  <div v-if="!fullnews">
                    <v-progress-circular 
                      indeterminate 
                      color="green">
                    </v-progress-circular>  
                  </div>
                  <div v-else>
                    <div v-if ='item.link.slice(0, 20) != "https://massivelyop."' class ="innerpic px-0  align-center my-2" v-bind:style="{backgroundImage: 'url('+ item.pic}">
                        <img :src="item.pic"  >
                    </div>
                  </div>
                    
                  <span class="body-1" v-html="fullnews"></span> 
                  </v-card-text>
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn
                    color="green darken-1 "
                    text
                    @click="clohand">
                    Закрыть
                    </v-btn>
 
                  </v-card-actions>
                </v-card>
              </v-dialog>
             </div>


        </v-col>
      </v-row>
    </v-card>
      <!--  <v-expand-transition>
            <div v-show="dialogVisible">
              <v-divider></v-divider>
              <v-card-text>
                <v-img
                  class=" mr-4 float-left"
                  height="225px"
                  width="225px"
                  :src = "bigimage"></v-img>
                  <span v-html="fullnews"></span>
              </v-card-text>
            </div>
          </v-expand-transition> -->
    <div class="d-flex justify-center" > 
      <!-- {{this.bottom}}  -->
      <v-progress-circular 
    indeterminate 
    color="green" 
    v-if="this.bottom == true && alld.length != 0">
      </v-progress-circular>   
    </div>
  </div>
</template>
<script>
  import { mapState, mapActions } from 'pinia' 
  import { useLogStore } from 'store.js'
  import { gsap } from "gsap";
  import axios from 'axios'

  export default {

    data: function (){
      return {
        loa:  '',
        pos: 0,
        bottom: false,
        // loc: false,
        fullnews: '',
        dialogVisible: false,
        empid: '',
        alld: ''
      }
    },
    created(){
      var timer;
      window.addEventListener('scroll', () => {
        if(timer) {
          window.clearTimeout(timer);
        }
        var self = this
        timer = setTimeout(function() {
          self.bottom = self.bottomVisible()
          console.log("vis")
        }, 5);
      })
    },
    watch: {
 
      dialogVisible(val){
        if (val == false){
          this.fullnews = ''
          console.log("fafafaf")
        }
      },
      bottom(bottom) {
        if (bottom)  {
          console.log("bottom")
          this.addBeer()
        }
      } 
    },
    mounted(){
      this.addBeer()
    },
    computed: {
    // ...mapState(useLogStore, ['thislog'])
      ...mapState(useLogStore, {
        logstat: "thisloa",
      })
    },  
    methods: {
      ...mapActions(useLogStore, ["decrement"]),
      animationStarted: function(startFrame, stopFrame){
        console.log('animation started:['+startFrame+','+stopFrame+']');
      },      
      ready: function(){
        this.$refs.animation.playLegacy(9);
        this.$refs.animation.play(1, 11);
      },
    bottomVisible() {
      var scrollHeight = Math.max(
        document.body.scrollHeight, document.documentElement.scrollHeight,
        document.body.offsetHeight, document.documentElement.offsetHeight,
        document.body.clientHeight, document.documentElement.clientHeight
      );

      const scrollY = window.scrollY
      const visible = document.documentElement.clientHeight 

      const bottomOfPage = visible + scrollY+1000 > scrollHeight
      return bottomOfPage || scrollHeight < visible 
    },
    popemploy: function(data) {
      if (this.empid != ''){
      var self = this;  
      return data.filter(function (elem) {
 
        return elem.id == self.empid;
        })
      }
    },
    clohand(){
      this.dialogVisible = false
       // this.fullnews = '' 
    },
    clickhandler( event) {
     // this.$store.commit('decrement') 
      this.decrement()
      this.dialogVisible = true;
      axios({
        method: 'post',
        url: '/fullnews',
        data: {
          id: event
        },
      }).then((response) => { 
        if (response.data){
          console.log(response.data)
          this.fullnews = response.data.fullarticle
 
        }
      }); 
      this.empid = event;
 
    },
      addBeer() {
        axios({
          method: 'get',
          url: '/news',
          params: {
            pos: this.pos
          },
        }).then((response) => { 
          if (response.data){
            // console.log(response.data)
            var alldat = response.data
            // this.alldata = this.alldata.concat(this.alld);
            if (this.pos != 0){

              console.log(alldat)
              this.alld = this.alld.concat(response.data);
              this.pos = this.alld.length
              console.log(this.pos)

            }else if (this.pos == 0){
              this.alld = alldat
              this.pos = alldat.length
              this.bottom = false  

            }else if (response.data.length == 0){

              this.bottom = false     
            }      
          }
        });
      }
    },
  }
</script>
<style scoped>
.disdiv{
  /*background-color: #dad;  */
  position: absolute;
  bottom: 1.5em;
  right: 1.5em;
}
.date{
  color: #9d9681; 
}
.colr{
  /*color: #60845b;*/
  color: #657d62;
}
.v-card__text{
  overflow: hidden;
}
.text-h6, .text-h5{

  word-break: normal;
}
 
.row { position: relative;
  
}
.pic {
  /*background-color: #dad;*/
  width: 100px;
  height: 100px;
}
.innerpic {
  margin: 1em;
  /*padding-bottom: 1em;*/
  float: left;
}
</style>
