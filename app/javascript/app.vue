<template>
  <div id="app">
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
          <div id="hat"></div>
          <pumpk class="pumpkin "></pumpk>
          <news></news>
        </v-container>
      </v-main>
    </v-app>
  </div>
</template>

<script>
import News from './news.vue'
import Userbar from './userbar.vue'
  import Pumpk from './pumpk.vue'
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
  }
}
</script>

<style scoped>
  .cont{
    position: relative;
  }
 .pumpkin {
  position: absolute;
  top: 70px;
  right: 5px;
  z-index: 1000;
 }
 .subt{
  color: #73708f;
 }
</style>
