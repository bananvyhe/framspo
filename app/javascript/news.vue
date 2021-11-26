<template>
  <div class=" py-1 px-0"> 
    <v-card v-for="(item, index) in alld " :key= "item.id" 
      class=" py-1 my-1">
      <v-row>
        <div 
          class="d-flex align-top justify-end  ml-5 pl-2 pr-1">
         <!--   -->
          <div class ="pic px-0 float-right align-center my-6" v-bind:style="{backgroundImage: 'url('+ item.pic}">
          </div>
        </div>
        <v-col
           >
          <v-card-title
            class="text-h6 px-0 py-2"
            v-text="item.head">
          </v-card-title>
          <div>
            {{item.desc}}  
          </div>
          <div class="float-left">
            <v-card-subtitle
            class="px-1 py-0">
            {{item.date}} 
            </v-card-subtitle>
          </div> 

          <!-- <v-card-actions class="px-0 py-0">  -->
            <v-btn  
              target="_blank" 
              v-bind:href="'https://www.pocketgamer.biz'+item.link"
              class="px-1 py-0"
              color="orange lighten-2"
              text x-small>
              источник
            </v-btn> 

            

            <v-btn
              class="float-right "
              icon
              @click="clickhandler(item.id, $event)">
              <v-icon>{{ dialogVisible&&item.id == empid  ? 'mdi-chevron-up' : 'mdi-chevron-down' }}</v-icon>
            </v-btn>
          <!-- </v-card-actions> -->

        </v-col>
      </v-row>
      <v-row class="row px-3">
        <div v-if="item.id == empid">
          <v-expand-transition>
            <div v-show="dialogVisible">
              <v-divider></v-divider>

              <v-card-text>
                <v-img
                  class=" mr-3 float-left"
                  height="225px"
                  width="225px"
                  :src = "bigimage"></v-img>
                  <span v-html="fullnews"></span> 

              </v-card-text>
            </div>
          </v-expand-transition>
        </div>
      </v-row>
    </v-card>
  </div>
</template>
<script>
  import axios from 'axios'
  export default {
 
    data: function (){
      return {
        bigimage: '',
        fullnews: '',
        dialogVisible: false,
        empid: '',
        alld: ''
      }
    },
    mounted(){
        this.addBeer()
    },
    methods: {

    popemploy: function(data) {
      if (this.empid != ''){
      var self = this;  
      return data.filter(function (elem) {
 
        return elem.id == self.empid;
        })
      }
    },
    clickhandler( event) {
      if (event == this.empid){
        this.dialogVisible = !this.dialogVisible;
      }else{
        this.bigimage = ''
        this.fullnews = '' 
        this.dialogVisible = true;
        this.empid = event;
       axios({
          method: 'post',
          url: '/fullnews',
          data: {
            id: event
          },
        }).then((response) => { 
          if (response.data){
            console.log(response.data)
            this.fullnews = response.data.fullarticle
            this.bigimage = response.data.biglink
          }
        }); 
      }
    },
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
  background-color: #dad;
  width: 100px;
  height: 100px;
 
}
</style>
