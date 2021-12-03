<template>
  <div id="app">
    <v-app>
      <v-main>
        <v-container class=" ">
          <v-app-bar app dense hide-on-scroll class="py-1">

              <p>{{message}}<i> {{ tl }}</i></p>

            <div subt>
               <p class=" font-italic ">&nbsp;</p>  
            </div>

          </v-app-bar>

          <news></news>
        </v-container>
      </v-main>
    </v-app>
  </div>
</template>

<script>
import News from './news.vue'
export default {
  components: {
    'news': News
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
 
</style>
