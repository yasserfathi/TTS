<template>
  <v-app id="inspire">
    <Menu></Menu>
    <v-main>
      <v-container  grid-list-xl fluid>
        <v-layout row wrap>
        <v-flex lg12>
          <template>
            <v-form v-model="valid" ref="form" multipart enctype="multipart/form-data" :lazy-validation="lazy">
              <v-card>
                <v-container>
                  <v-row class="mx-2">
                    <v-col
                      class="align-center justify-space-between"
                      cols="12"
                      sm="10"
                    >
                      <v-row
                        align="center"
                        class="ma-1"
                        cols="12"
                        sm="4"
                      >
                        <v-text-field
                          id="country"
                          name="country"
                          v-model="country"
                          prepend-inner-icon="mdi-map-marker"
                          :items="posts"
                          item-text="country" item-value="code"
                          outlined
                          offset-y
                          max-width="290px"
                          min-width="290px"
                          ></v-text-field>
                      </v-row>
                    </v-col>

                    <v-col
                      class="align-center justify-space-between"
                      cols="12"
                      sm="2"
                    >
                      <v-row
                        align="center"
                        cols="12"
                         class="ma-0 pa-1"
                      >
                        <v-btn color="success" @click="search" block :disabled="!valid" cols="12" fill-height>بحث</v-btn>
                      </v-row>
                    </v-col>

                    <v-col
                      class="align-center justify-space-between"
                      cols="12"
                    >
                      <v-row
                        align="center"
                        class="mr-0"
                      >
                        <v-select
                          id="country"
                          name="country"
                          v-model="country"
                          label="الدولة"
                          prepend-icon="mdi-image"
                          :items="posts"
                          item-text="country" item-value="code"
                          ></v-select>
                      </v-row>
                    </v-col>
                    <v-col>
                      <v-row>
                        <v-menu
                          ref="menu1"
                          v-model="menu1"
                          :close-on-content-click="true"
                          :nudge-right="40"
                          transition="scale-transition"
                          offset-y
                          max-width="290px"
                          min-width="290px"
                        >
                          <template v-slot:activator="{ on }">
                            <v-text-field
                              v-model="date1"
                              label="التاريخ الاول"
                              persistent-hint
                              prepend-icon="mdi-calendar-account-outline"
                              v-on="on"
                            ></v-text-field>
                          </template>
                          <v-date-picker flat no-title v-model="date1" locale="ar"></v-date-picker>
                        </v-menu>
                    </v-row>
                    </v-col>
                    <v-col>
                      <v-row class="mx-2">
                        <v-menu
                          ref="menu2"
                          v-model="menu2"
                          :close-on-content-click="true"
                          :nudge-right="40"
                          transition="scale-transition"
                          offset-y
                          max-width="290px"
                          min-width="290px"
                        >
                          <template v-slot:activator="{ on }">
                            <v-text-field
                              v-model="date2"
                              label="التاريخ الثاني"
                              prepend-icon="mdi-calendar-account-outline"
                              v-on="on"
                            ></v-text-field>
                          </template>
                          <v-date-picker flat no-title v-model="date2" locale="ar"></v-date-picker>
                        </v-menu>
                    </v-row>
                    </v-col>
                  </v-row>
                </v-container>
                <v-divider
                  lg12
                ></v-divider>
                <v-card-actions>
                  <v-btn color="success" @click="search" :disabled="!valid" cols="12" sm="4" v-if="chksave">بحث</v-btn>
                </v-card-actions>
              </v-card>
              </v-form>
          </template>
          <template>
            <v-data-table
              ref="myTable"
              :headers="headers"
              :items="countries"
              class="elevation-1"
              id="print"
              :footer-props="{
                showFirstLastPage: true,
                firstIcon: 'mdi-arrow-collapse-left',
                lastIcon: 'mdi-arrow-collapse-right',
                prevIcon: 'mdi-minus',
                nextIcon: 'mdi-plus'
              }"
            >
              <template #item.full_name="{ item }">{{ item.alienObj.fName }} {{ item.alienObj.sName }} {{ item.alienObj.thName }} {{ item.alienObj.fthName }}</template>
            </v-data-table>

          </template>
          
        </v-flex>
        </v-layout>
      </v-container>
    </v-main>
  </v-app>
</template>
<script>
  import Menu from './Menu';
  import axios from 'axios';
  import moment from 'moment'
  import { format } from 'date-fns'
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
        countries: [],
        date1: new Date().toISOString().substr(0, 10),
        date2: new Date().toISOString().substr(0, 10),
        menu1: false,
        menu2: false,
        pagination: {
                current: 1,
                total: 0
        },
        country: '+249',
        editcountry: [],
        countryRules: [
          v => !!v || 'Country is required',
        ],
        flag: '',
        flagRules: [
          //v => !v || 'A file is required'
        ],
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
        fileChanged(event) {
          this.flag  = event
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
            // Add a response interceptor
           /*axios.interceptors.response.use(function (response) {
                // Do something with response data
                return response;
              }, function (error) {
                // Do something with response error
                return Promise.reject(error);
              });
            await axios.get('http://127.0.0.1:3000/posts',config).then(response => {
            //await axios.get('http://localhost:8000/table/Visa').then(response => {
                    //this.skeletonval = 1;
                    this.posts = response.data;
                    console.log(this.posts);
                })
                .catch(error => {
                  console.log(error);
                  this.$swal({
                        position: 'top-end',
                        icon: 'error',
                        title: 'لا يمكن الأتصال مع المخدم',
                        timer:1000
                      });
                })*/
        },
        onPageChange() {
            this.checkToken();
        },
        search(){
          if(this.$refs.form.validate())
          {
            /*const formData  = new FormData();
            formData.append('flag', this.flag);
            formData.append('country', this.country);*/
            const config = {
                    headers: {
                        'Authorization': 'Basic dXNlcjpwYXNz',
                        'Content-Type': 'application/json',
                    }
            }
            this.countries = []
            const BodyJson = [{where: "issueDate",value: this.date1,operation: ">date"},{where: "issueDate",value: this.date2,operation: "<date"},{where: "alienObj.countryObj.code",value: this.country,operation: "="}]
            //const body = {data: BodyJson}
           axios.post('http://localhost:3000/FileToArchiveAlienWS/webresources/API/5/1.1.1.1/45AE666F7/Condition/EntryPermission/issueDate',BodyJson,config)
                .then(response => {
                      //this.dialog = false
                      //this.showprogress = false
                      //this.uploadPercentage = 0
                      this.countries = response.data
                      //this.flag = ''
                      console.log(response.data);
                      /*this.pagination.current = 1;
                      this.$swal({
                        position: 'top-end',
                        icon: 'success',
                        title: 'تمت العملية بنجاح',
                        showConfirmButton: false,
                        timer: 1500
                      }).then(() => { 
                        this.skeletonval = 0;
                        this.getCountries();
                        }
                      );*/
                })
                .catch(err => {
                  console.log(err);
                })
          }
        },
        GeneratePdf(){},
        show(event){
          axios.get('http://62.12.99.11/steefa/lara/public/show/'+event.currentTarget.id)
                .then(response => {
                      this.id = JSON.parse(JSON.stringify(response.data))[0].id;
                      this.country = JSON.parse(JSON.stringify(response.data))[0].country;
                      this.chksave = false
                      this.chkedit = true
                      this.dialog = true
                })
                .catch(err => {
                  console.log(err);
                })
        },
    },
    mounted() {
    /*window.setInterval(() => {
      this.getCountries()
    }, 10000)*/
    this.checkToken()
    },
    computed: {
      getPercentage () {
        return this.uploadPercentage
      },
      getmail () {
        return this.$store.state.getEmail
      },
      computedDateFormattedMomentjs () {
        return this.date ? moment(this.date).format('dddd, MMMM Do YYYY') : ''
      },
      computedDateFormattedDatefns () {
        return this.date ? format(this.date, 'EEEE, MMMM do yyyy') : ''
      },
    },
  }
</script>
<style scoped>
input{
  direction: ltr;
}

</style>