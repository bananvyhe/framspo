<template>
  <div id="app">
    <v-app>
      <v-main>
        <v-container class="pt-0">
          <div id="hat"> </div>
          <v-app-bar app dense hide-on-scroll class="py-0">

              <p>{{message}}<i> {{ tl }}</i></p>

            <div class="subt">
              Yandex neural network translator API 
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
 .subt{
  color: #73708f;
  position: absolute;
  bottom: 1px;

 }
</style>
