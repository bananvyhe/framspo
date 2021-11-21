<template>
  <div> 
    <div v-for="(item, index) in alld" >
      <v-row class="row">
        <v-col
          class="d-flex flex-row mb-0  "
           
          flat
          tile>
          <v-col 
            cols=2
            
            class=" d-flex px-1 justify-end align-center"
            outlined
            tile>
            <div class ="pic px-0" v-bind:style="{backgroundImage: 'url('+ item.pic}"></div>
          </v-col>  
          <v-col>
            <v-card-title
              class="text-h6"
              v-text="item.head">
            </v-card-title>
 
              {{item.desc}}  
            <div>
              {{item.date}}                
            </div>      
          </v-col>
            <!-- {{item.link}} -->
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
