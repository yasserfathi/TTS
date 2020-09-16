<template>
  <v-app id="inspire">
    <Menu></Menu>
    <v-main>
      <v-container  grid-list-xl fluid>
        <v-layout row wrap>
        <v-flex lg12>
          <template>
            <v-row>
            <v-col sm="4">
   <v-card
    color="primary"
    sm="4"
  >

    <v-card-text class="headline font-weight-bold" >
      <v-icon color="45AE666F7" size="60" ma-3>mdi-domain</v-icon> 
      <label class="headline font-weight-bold ma-2 pa-0">Agents</label>
      <h1 class="darken-1--text text-center ma-3 pa-1">488</h1>
    </v-card-text>

  </v-card>
</v-col>
 <v-col sm="4">
  <v-card
    color="green"
    @click="doSomething()"
  >

    <v-card-text class="headline font-weight-bold" >
      <v-icon color="45AE666F7" size="60" ma-3>mdi-domain</v-icon> 
      <label class="headline font-weight-bold ma-2 pa-0">Agents</label>
      <h1 class="darken-1--text text-center ma-3 pa-1">488</h1>
    </v-card-text>

  </v-card>
</v-col>
 <v-col sm="4">
  <v-card
    color="grey"
  >

    <v-card-text class="headline font-weight-bold" >
      <v-icon color="45AE666F7" size="60" ma-3>mdi-ticket</v-icon> 
      <label class="headline font-weight-bold ma-2 pa-0">Tickets</label>
      <h1 class="darken-1--text text-center ma-3 pa-1">488</h1>
    </v-card-text>

  </v-card>
</v-col>

</v-row>
          </template>
          
        </v-flex>
        </v-layout>
      </v-container>
    </v-main>
  </v-app>
</template>
<script>
  import Menu from './Menu';
  export default {
    data () {
      return {
        id:'',
        chksave:true,
        loading:true,
        chkedit:false,
        valid: false,
        dialog: false,
        gdialog: false,
        uploadPercentage: 0,
        skeletonval: 0,
        showprogress: false,
        lazy: false,
        headers: [
          { text: 'تاريخ الاصدار', value: 'issueDate' },
          { text: 'رقم اذن الدخول', value: 'alienId' },
          { text: 'الاسم', value: 'full_name' },
          { text: 'الدولة', value: 'alienObj.countryObj.country' },
        ],
        posts: [],
        pagination: {
                current: 1,
                total: 0
        },
      }
    },
    props: {
      source: String,
    },
    components : {
      Menu
    },
    methods: {
        loadgraphmodal(){
          this.gdialog = true
        },
        loadmodal(){
          this.chksave = true 
          this.chkedit = false
          this.dialog = true
        },
        async checkToken() {
            var token = localStorage.getItem('storeddata')
            const config = {
                    headers: {
                        'Authorization': 'Basic '+token,
                        'Access-Control-Allow-Origin': true,
                    }
            }
            console.log(config)
        },
        onPageChange() {
            this.checkToken();
        }
    },
    mounted() {
    /*window.setInterval(() => {
      this.getCountries()
    }, 10000)*/
    //this.checkToken()
    },
  }
</script>
<style scoped>
@media print {
    body * {
        visibility: hidden;
        font-size: 20px !important;
    }

    #print, #print * {
        visibility: visible;
        border-bottom: none;
    }

    #title {
        visibility: hidden;
    }

    #print {
        padding: 20px;
        position: fixed;
        height: 100%;
        left: 0;
        top: 0;
    }
}
</style>