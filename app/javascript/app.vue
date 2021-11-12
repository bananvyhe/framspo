<template>
  <div id="app">
    <p>{{message}}<i> {{ tl }}</i></p>
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
