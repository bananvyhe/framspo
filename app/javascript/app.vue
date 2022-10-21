<template>
  <div >
    <v-app>

      <v-app-bar  app dense hide-on-scroll  class="py-0">
        <v-container  class="py-0 fill-height">
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
      <v-main>
        <v-container class="pt-0 cont">
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
import { mapState } from 'pinia'
export default {
  components: {
    'news': News,
    'userbar': Userbar,
     'pumpk': Pumpk
  },
  data: function () {
    return {
      message: "Throne and Liberty ",
      tl: "mmorpg"
    }
  },
  computed:{
   ...mapState(useLogStore, {
      currentUser: "thiscurrentUser",
    }),   
  }
}
</script>

<style scoped>
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
