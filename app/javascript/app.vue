<template>
  <div id="app">
    <v-app>
      <v-main>
        <v-container>
          <p>{{message}}<i> {{ tl }}</i></p>

          <v-card>новости</v-card>
        </v-container>
      </v-main>
    </v-app>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      message: "project",
      tl: "TL"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
