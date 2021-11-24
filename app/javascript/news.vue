<template>
  <div> 
    <div >
      <v-row class="row" v-for="(item, index) in alld" :key= "item.id">

        <v-col 
          class="d-flex px-1 justify-end align-center"  
          cols=3
          sm=2
          md=2
          lg=2
          outlined
          tile>
          <div class ="pic px-0" v-bind:style="{backgroundImage: 'url('+ item.pic}"></div>
        </v-col>

        <v-col
          cols=9
          sm=10
          md=10
          lg=10>
          <v-card-title
            class="text-h6 px-0 py-1"
            v-text="item.head">
          </v-card-title>
            {{item.desc}}  
          <div>
            {{item.date}}&nbsp;&nbsp; <a class=" " target="_blank" v-bind:href="'https://www.pocketgamer.biz'+item.link">источник...</a>            
          </div> 
        </v-col>

      </v-row>
    </div>

  </div>
</template>
<script>
  import axios from 'axios'
  export default {
 
    data: function (){
      return {
        alld: ''
      }
    },
    mounted(){
        this.addBeer()
    },
    methods: {
      addBeer() {
        axios({
          method: 'get',
          url: '/news',
        }).then((response) => { 
          if (response.data){
            console.log(response.data)
            this.alld = response.data
          }
        });
      }
    },
  }
</script>
<style scoped>
.row {
 
}
.pic {
  width: 100px;
  height: 100px;
  background-position: center;
  background-size: cover; 
  background-repeat: no-repeat;
}
</style>
