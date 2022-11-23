<template>
  <div @mousemove="mouseMove">

    <v-app   >
      <v-progress-circular
        v-if="this.reuse === true"
        v-bind:style="{left: this.xaxis+'px', top: this.yaxis+'px'}"
        class="cooldown"
        :rotate="360"
        :size="50"
        :width="7"
        :value="this.value"
        color="teal">
        {{ this.value }}
      </v-progress-circular>   
      <v-app-bar  app dense hide-on-scroll  class="py-0">
        <v-container  class="py-0 fill-height" >
          <div class="my-0" >
            {{message}}<i> {{ tl }}</i> 
            <div class="subtitle-2 my-0 subt">
              Yandex neural network translator API 
            </div>
          </div>
          <v-spacer></v-spacer>
          <userbar></userbar>
        </v-container>
      </v-app-bar>       
      <v-main >
        <v-container class="pt-0 cont" > 

          <router-view></router-view>

          <pumpk class="pumpkin"></pumpk>
          <!-- ss{{this.currentUser}}ss -->
          <!--cv-if="this.currentUser.role != 'admin' && this.currentUser.role != 'manager'"></news> -->
        </v-container>

      </v-main>

    </v-app>
  </div>
</template>

<script>
import News from './news.vue'
import Userbar from './userbar.vue'
import Pumpk from './pumpk.vue'
import { useLogStore } from 'store.js'
import { mapState, mapActions } from 'pinia'
export default {
  components: {
    'news': News,
    'userbar': Userbar,
     'pumpk': Pumpk
  },
  data: function () {
    return {
      xaxis: '',
      yaxis: '',      
      interval: {},
      message: "Throne and Liberty ",
      tl: "mmorpg"
    }
  },
  mounted(){
    // this.interval = setInterval(() => {
    //   if (this.value === 100) {
    //     // return (this.value = 0)

    //   }
    //   this.value += 10
    // }, 100)
  },
  methods: {

    mouseMove(event) {
      this.xaxis = event.clientX +15
      this.yaxis = event.clientY +15
        // console.log(event.clientX, event.clientY);
    }
  },  
  computed:{
    ...mapState(useLogStore, {
      reuse: "thisreuse",
    }),     
    ...mapState(useLogStore, {
      value: "thisvalue",
    }),   
   ...mapState(useLogStore, {
      currentUser: "thiscurrentUser",
    }),   
  }
}
</script>

<style scoped>
  .cooldown{
    z-index: 9999;
    position: absolute;
  }
  .cont{
    position: relative;
  }
 .pumpkin {
  position: absolute;
  top: 60px;
  right: 18px;
  z-index: 50;
 }
 .subt{
  color: #73708f;
 }
</style>
