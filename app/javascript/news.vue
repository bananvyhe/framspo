<template>
  <div class=" py-1 px-0"> 
    <v-card v-for="(item, index) in alld " :key= "item.id" 
      class="px-1 my-1 py-2 py-md-1 my-md-2">
      <v-row>
        <v-col>
          <div 
          class="align-top  float-left mr-1 px-3 py-md-1 mx-md-1">
          <!-- {backgroundImage: 'url('+ item.pic} -->
            <div class ="pic px-0  align-center my-2" v-bind:style="{backgroundImage: 'url('+ item.pic}">
              <!-- {{pos}} -->
            </div>
          </div>
          <div
            class="text-h5 px-2 py-2"
            v-text="item.head">
          </div>
          <div class="px-2 body-1">
            {{item.desc}}… 
          </div>
 
          <v-card-subtitle
          class="px-2 py-0 float-left">
          {{item.date}} 
          </v-card-subtitle>

          <v-btn  
            target="_blank" 
            v-bind:href="item.link"
            class="px-1 py-0 float-left"
            color="orange lighten-2"
            text x-small>
            источник
          </v-btn>  
           
          <v-btn
          class="px-2 py-0 mx-4 but"
          @click="clickhandler(item.id, $event)"
          color="primary"
          small>
            открыть
          </v-btn>   

          <div v-if="item.id == empid">
            <v-dialog
              v-model="dialogVisible"
              max-width="1240px"
              width="95%">
              <v-card 
              class="px-md-5 py-md-2">
                <v-card-title class="pb-md-4">
                  <span class="text-h5 ">{{item.head}}</span>
                </v-card-title>
                <v-card-text >
                  <div v-if="!fullnews">
                    <v-progress-circular 
                      indeterminate 
                      color="green">
                    </v-progress-circular>  
                  </div>
                  <div v-else>
                    <div v-if ='item.link.slice(0, 20) != "https://massivelyop."' class ="innerpic px-0  align-center my-2" v-bind:style="{backgroundImage: 'url('+ item.pic}">
                        <img :src="item.pic"  >
                    </div>
                  </div>
                    
                  <span class="body-1" v-html="fullnews"></span> 
                  </v-card-text>
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn
                    color="green darken-1 "
                    text
                    @click="dialogVisible = false">
                    Закрыть
                    </v-btn>
 
                  </v-card-actions>
                </v-card>
              </v-dialog>
             </div>


        </v-col>
      </v-row>
    </v-card>

       

<!--           <v-expand-transition>
            <div v-show="dialogVisible">
              <v-divider></v-divider>
              <v-card-text>
                <v-img
                  class=" mr-4 float-left"
                  height="225px"
                  width="225px"
                  :src = "bigimage"></v-img>
                  <span v-html="fullnews"></span>
              </v-card-text>
            </div>
          </v-expand-transition> -->
          <div class="d-flex justify-center" > 
                <v-progress-circular 
    
    indeterminate 
    color="green" v-if="this.bottom == true && alld.length != 0"></v-progress-circular>   
          </div>

 

   
  </div>
</template>
<script>
  import axios from 'axios'
  export default {
 
    data: function (){
      return {
        pos: 0,
        bottom: false,
        bigimage: '',
        fullnews: '',
        dialogVisible: false,
        empid: '',
        alld: ''
      }
    },
    created(){
      var timer;
      window.addEventListener('scroll', () => {

        if(timer) {
          window.clearTimeout(timer);
        }
        var self = this
        timer = setTimeout(function() {
          self.bottom = self.bottomVisible()
          console.log("vis")
        }, 200);
      
      })
    },
    watch: {
      bottom(bottom) {
        if (bottom)  {
          this.addBeer()
        }
      } 
    },
    mounted(){
        this.addBeer()
    },
    methods: {
    bottomVisible() {
      const scrollY = window.scrollY
      const visible = document.documentElement.clientHeight 
      const pageHeight = document.documentElement.scrollHeight
      const bottomOfPage = visible + scrollY+1000 > pageHeight
      return bottomOfPage || pageHeight < visible 
    },
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
            // this.bigimage = response.data.biglink
          }
        }); 
      }
    },
      addBeer() {
        axios({
          method: 'get',
          url: '/news',
          params: {
            pos: this.pos
          },
        }).then((response) => { 
          if (response.data){
            // console.log(response.data)
            var alldat = response.data
            // this.alldata = this.alldata.concat(this.alld);
            if (this.pos != 0){

              console.log(alldat)
              this.alld = this.alld.concat(response.data);
              this.pos = this.alld.length
            }else if (this.pos == 0){
            this.alld = alldat
            this.pos = alldat.length
            this.bottom = false     
            }else if (response.data.length == 0){

            this.bottom = false     
            }      
          }
        });
      }
    },
  }
</script>
<style scoped>
.v-card__text{
  overflow: hidden;
}
.text-h6, .text-h5{
  word-break: normal;
}
.but{
  position: absolute;
  bottom: 2em;
  right: 1em;

}
.row { position: relative;
  
}
.pic {
  /*background-color: #dad;*/
  width: 100px;
  height: 100px;
}
.innerpic {
  margin: 1em;
  /*padding-bottom: 1em;*/
  float: left;
}
</style>
