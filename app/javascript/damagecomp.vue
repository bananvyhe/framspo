<template>
  <div >
  {{hit}}
  <div class="hitbox" v-on:click="hitcalc">
  </div>
  </div>
</template>
<script>
export default {
 
  data: function () {
    return {
      basedamage: 110,
      lvl: 1,
      hit: 0,
    }
  },
  methods: {
    hitcalc(){
      this.hit = (((this.basedamage * (this.lvl/10 ))  )* (Math.random() * (0.120 - 0.0200) + 0.3).toFixed(2)*10).toFixed()
    }
  },
}
</script>
<style scoped>
.hitbox{
  height: 1em;
  width: 4em;
  background-color: #dad;
}
</style>
