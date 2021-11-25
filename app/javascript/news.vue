<template>
  <div class=" py-1"> 
    <v-card v-for="(item, index) in alld " :key= "item.id" 
      class=" py-1">
      <v-row class="row" :name="item.id">
        <v-col 
          class="d-flex px-1 justify-end align-top"  
          cols=3
          sm=2
          md=2
          lg=2
          outlined
          tile>
          <div class ="pic px-0 " v-bind:style="{backgroundImage: 'url('+ item.pic}">
    
          </div>
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
            <v-card-subtitle
            class="px-0 py-0">
            {{item.date}}&nbsp;&nbsp;источник...
            </v-card-subtitle>
          </div> 

          <v-card-actions class="px-0 py-0"> 
            <v-btn  target="_blank" v-bind:href="'https://www.pocketgamer.biz'+item.link"
              color="orange lighten-2"
              text small>
              источник
            </v-btn> 

            <v-spacer></v-spacer>

            <v-btn
              icon
              @click="clickhandler(item.id, $event)">
              <v-icon>{{ dialogVisible&&item.id == empid  ? 'mdi-chevron-up' : 'mdi-chevron-down' }}</v-icon>
            </v-btn>
          </v-card-actions>
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
        </v-col>
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
  width: 100px;
  height: 100px;
 
}
</style>
