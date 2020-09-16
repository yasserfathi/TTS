<template>
  <v-app id="inspire">
    <Menu></Menu>
    <v-main>
      <v-container  grid-list-xl fluid>
        <v-layout row wrap>
        <v-flex lg12>
          <template>
            <v-data-table
              ref="myTable"
              :headers="headers"
              :items="purposes"
              class="elevation-1"
              :footer-props="{
                showFirstLastPage: true,
                firstIcon: 'mdi-arrow-collapse-left',
                lastIcon: 'mdi-arrow-collapse-right',
                prevIcon: 'mdi-minus',
                nextIcon: 'mdi-plus'
              }"
            >
            <template v-slot:top>
            <v-toolbar flat color="white">
              <v-dialog
      v-model="dialog"
      width="800px"
    >
      <template v-slot:activator="{ on, attrs }">
            <v-btn class="mb-1" v-bind="attrs" v-on="on" color="primary">
              <v-icon left>mdi-plus</v-icon> New Item
            </v-btn>
          </template>
      <v-form v-model="valid" ref="form" multipart enctype="multipart/form-data" lazy-validation>
      <v-card>
        <v-card-title style="color:#fff" class="primary lighten-1">
          Purposes
        </v-card-title>
        <v-container>
            <v-col
              class="align-center justify-space-between"
              cols="12"
            >
              <v-row
                align="center"
                class="mr-0"
              >
                <v-text-field
                  id="purpose"
                  name="purpose"
                  label="Purpose title"
                  v-model="purpose"
                  prepend-icon="mdi-folder-outline"
                  :rules="purposeRules"
                  required
                  ></v-text-field>
              </v-row>
            </v-col>
        </v-container>
        <v-card-actions>
          <v-btn color="info" @click="dialog = false" >الغاء</v-btn>
          <v-btn color="success" @click="save" :disabled="!valid" v-if="chksave">حفظ</v-btn>
          <v-btn color="success" @click="edit" :disabled="!valid" v-if="chkedit">تحرير</v-btn>
        </v-card-actions>
      </v-card>
      </v-form>
    </v-dialog>
              <v-divider
                class="mx-4"
                inset
                vertical
              ></v-divider>
              <v-spacer></v-spacer>
        <v-toolbar-title>Purposes</v-toolbar-title>
              </v-toolbar>
              </template>
              <template v-slot:[`item.actions`]="{ item }">
      <v-icon
        small
        class="mr-2"
        @click="editItem(item)"
      >
        mdi-pencil
      </v-icon>
      <v-icon
        small
        @click="deleteItem(item)"
      >
        mdi-delete
      </v-icon>
    </template>
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
  //import Shared from './shared';
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
        editedIndex: -1,
        skeletonval: 0,
        showprogress: false,
        lazy: false,
        user_id: '',
        headers: [
          { text: 'Purpose Title', value: 'purpose_title' },
          { text: 'Actions', value: 'actions', sortable: false },
        ],
        editedItem: {
          purpose_title: '',
          created_at: '',
          id: '',
          updated_at: '',
        },
        posts: [],
        purposes: [],
        date1: new Date().toISOString().substr(0, 10),
        date2: new Date().toISOString().substr(0, 10),
        menu1: false,
        menu2: false,
        pagination: {
                current: 1,
                total: 0
        },
        country: '',
        purpose: '',
        editcountry: [],
        purposeRules: [
          v => !!v || 'Please add a purpose',
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
        },
        onPageChange() {
            this.getData()
        },
        save(){
          if(this.$refs.form.validate())
          {
            this.dialog = false;
            const config = {
            headers: {
                        'Authorization': 'Bearer '+localStorage.getItem("storeddata"),
                        "Content-type": "application/json"
                    }
            }
            axios.post("http://127.0.0.1/backend/api/auth/purpose",{ purpose_title: this.purpose,created_by: this.user_id },config)
            .then((response) => {
             this.getData();
             console.log(response.data);
              this.$refs.form.reset()
              this.$swal({
                title: "",
                text: "تمت العملية بنجاح",
                button: false,
                icon:'success',
                timer: 2000,
              })
          })
          .catch((error) => {
            console.log(error);
            this.$swal('error','','warning')
          });
          }
        },
        edit(){
          if(this.$refs.form.validate())
          {
            this.dialog = false;
            const config = {
            headers: {
                        'Authorization': 'Bearer '+localStorage.getItem("storeddata"),
                        "Content-type": "application/json"
                    }
            }
            axios.put('http://127.0.0.1/backend/api/auth/purpose/update',{ id:this.editedItem['id'],purpose_title: this.purpose },config)
            .then((response) => {
             console.log(response);
             this.getData()
             this.$refs.form.reset()
             this.$swal('تمت العملية بنجاح','','success')
          })
          .catch((error) => {
            console.log(error);
            this.$swal('error','','warning')
          });
          }
        },
        deleteItem(item){
            this.editedIndex = this.purposes.indexOf(item)
            this.editedItem = Object.assign({}, item)
            this.$swal({
                title: "هل تريد اكمال العملية",
                icon: "warning",
                buttons: true,
                dangerMode: true,
              })
              .then((willDelete) => {
                  if (willDelete) {
                      const config = {
                      headers: {
                                  'Authorization': 'Bearer '+localStorage.getItem("storeddata"),
                                  "Content-Type": "application/x-www-form-urlencoded"
                              }
                      }
                      axios.delete('http://127.0.0.1/backend/api/auth/purpose/'+this.editedItem['id'],config)
                        .then(response => {
                              //console.log(this.editedItem['id']);
                              console.log(response);
                              this.$swal({
                                position: 'top-end',
                                icon: 'success',
                                title: 'تمت العملية بنجاح',
                                showConfirmButton: false,
                                timer: 1500
                              }).then(() => {
                                this.skeletonval = 0
                                this.getData()
                                }
                              );
                        })
                        .catch(err => {
                          console.log(err);
                      })
                  }
            });
        },
        getData(){
            this.skeletonval = 0
            const config = {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem("storeddata"),
                        'Content-Type': 'application/json',
                    }
            }
            this.purposes = []
           axios.get('http://127.0.0.1/backend/api/auth/purpose/show',config)
                .then(response => {
                      //this.dialog = false
                      //this.showprogress = false
                      //this.uploadPercentage = 0
                      this.purposes = response.data.purposes
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
        },
        editItem(item){
          this.editedIndex = this.purposes.indexOf(item)
          this.editedItem = Object.assign({}, item)
          this.purpose = this.editedItem['purpose_title']
          this.chksave = false
          this.chkedit = true
          this.dialog = true
        },
        check_Token: function() {
          const config = {
                  headers: {
                      'Authorization': 'Bearer '+localStorage.getItem("storeddata")
                  }
          }
          axios.get('http://127.0.0.1/backend/api/auth/profile',config).then(response => {
                //this.result = response;
                this.user_id = response.data.id
              })
              .catch(error => {
                this.result = error;
                return "error"
              })
        },
    },
    mounted() {
    this.check_Token()
    this.getData()
    /*window.setInterval(() => {
      this.getCountries()
    }, 10000)*/
    //this.checkToken()
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
.theme--light.v-data-table > .v-data-table__wrapper > table > thead > tr:last-child > th {
      text-align: center !important;
    }
</style>
