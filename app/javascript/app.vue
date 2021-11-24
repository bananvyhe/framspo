<template>
  <div id="app">
    <v-app>
      <v-main>
        <v-container>
          <v-app-bar app dense hide-on-scroll>

              <p>{{message}}<i> {{ tl }}</i></p>

            <div subt>
               <p class=" font-italic ">&nbsp;фри пвп</p>  
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
      message: "project",
      tl: "TL"
    }
  }
}
</script>

<style scoped>
 
</style>
