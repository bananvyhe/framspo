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
        <v-container class="pt-0">
          <div id="hat"> </div>
          <news></news>
        </v-container>
      </v-main>
    </v-app>
  </div>
</template>

<script>
import News from './news.vue'
import Userbar from './userbar.vue'

export default {
  components: {
    'news': News,
    'userbar': Userbar
  },
  data: function () {
    return {
      message: "Lineage Eternal ",
      tl: "reboot TL mmorpg NFT"
    }
  }
}
</script>

<style scoped>

 .subt{
  color: #73708f;
 
  

 }
</style>
