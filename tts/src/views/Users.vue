<template>
  <v-app id="inspire">
    <Menu></Menu>
    <v-main>
      <v-container grid-list-xl fluid>
        <v-layout row wrap>
          <v-flex lg12>
            <template>
              <v-data-table
                ref="myTable"
                :headers="headers"
                :items="users"
                class="elevation-1"
                :footer-props="{
                  showFirstLastPage: true,
                  firstIcon: 'mdi-arrow-collapse-left',
                  lastIcon: 'mdi-arrow-collapse-right',
                  prevIcon: 'mdi-minus',
                  nextIcon: 'mdi-plus',
                }"
              >
                <template v-slot:item.active="{ item }">
                  <v-chip :color="getColor(item.active)" dark><label v-if="item.active == 0">Disable</label><label v-else>Active</label></v-chip>
                </template>
                <template v-slot:top>
                  <v-toolbar flat>
                    <v-dialog v-model="dialog" persistent  width="800px">
                      <template v-slot:activator="{ on, attrs }">
                        <v-btn class="mb-1" v-bind="attrs" v-on="on" color="primary">
                          <v-icon left>mdi-plus</v-icon> New Item
                        </v-btn>
                      </template>
                      <v-form
                        v-model="valid"
                        ref="form"
                        multipart
                        enctype="multipart/form-data"
                        lazy-validation
                      >
                        <v-card>
                          <v-card-title
                            style="color:#fff"
                            class="primary lighten-1"
                          >
                            Full Name
                          </v-card-title>
                          <v-container>
                            <v-col
                              class="align-center justify-space-between"
                              cols="12"
                            >
                              <v-row align="center" class="mr-0">
                                <v-text-field
                                  id="username"
                                  name="username"
                                  label="Full Name"
                                  v-model="username"
                                  prepend-icon="mdi-account-alert"
                                  :rules="usernameRules"
                                  required
                                ></v-text-field>
                              </v-row>
                              <v-row align="center" class="mr-0">
                                <v-text-field
                                  id="email"
                                  name="E-mail"
                                  label="E-mail"
                                  v-model="email"
                                  prepend-icon="mdi-email"
                                  :rules="emailRules"
                                  required
                                ></v-text-field>
                              </v-row>
                              <v-row align="center" class="mr-0">
                                <v-select
                                  id="role"
                                  name="role"
                                  :items="roles"
                                  v-model="role"
                                  prepend-icon="mdi-folder-outline"
                                  :rules="[v => !!v || 'Plese choose a role']"
                                  @change="onSelectRole($event)"
                                  label="Role"
                                ></v-select>
                              </v-row>
                              <v-row align="center" class="mr-0">
                                <v-switch
                                  :label="`User Activation`"
                                  id="active"
                                  name="active"
                                  v-model="active"
                                  prepend-icon="mdi-folder-outline"
                                ></v-switch>
                              </v-row>
                            </v-col>
                          </v-container>
                          <v-card-actions>
                            <v-btn
                              color="red"
                              @click="cancel"
                              >الغاء</v-btn
                            >
                            <v-btn
                              color="success"
                              @click="save"
                              :disabled="!valid"
                              v-if="chksave"
                              >حفظ</v-btn
                            >
                            <v-btn
                              color="success"
                              @click="edit"
                              :disabled="!valid"
                              v-if="chkedit"
                              >تحرير</v-btn
                            >
                          </v-card-actions>
                        </v-card>
                      </v-form>
                    </v-dialog>
                    <v-divider class="mx-4" inset vertical></v-divider>
                    <v-spacer></v-spacer>
                    <v-toolbar-title>Team leaders & Agents</v-toolbar-title>
                  </v-toolbar>
                </template>
                <template v-slot:item.actions="{ item }">
                  <v-icon small class="mr-2" @click="editItem(item)">
                    mdi-pencil
                  </v-icon>
                  <v-icon small @click="deleteItem(item)">
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
import Menu from "./Menu";
import axios from "axios";
import moment from "moment";
import { format } from "date-fns";
export default {
  data() {
    return {
      id: "",
      chksave: true,
      loading: true,
      chkedit: false,
      valid: false,
      dialog: false,
      gdialog: false,
      uploadPercentage: 0,
      editedIndex: -1,
      skeletonval: 0,
      group_name:'',
      showprogress: false,
      roles: ['Agent','Team Leader','Backoffice','Quality'],
      lazy: false,
      headers: [
        { text: "E-mail", value: "email" },
        { text: "User Name", value: "name" },
        { text: "Role", value: "role" },
        { text: "Group Name", value: "group_name" },
        { text: "Active", value: "active" },
        { text: "Actions", value: "actions", sortable: false },
      ],
      editedItem: {
        name: "",
        password: "",
        email: "",
        id: "",
        role: "",
        group_name: "",
        active: "",
      },
      posts: [],
      users: [],
      date1: new Date().toISOString().substr(0, 10),
      date2: new Date().toISOString().substr(0, 10),
      menu1: false,
      menu2: false,
      pagination: {
        current: 1,
        total: 0,
      },
      email: "",
      role: "",
      active: 0,
      username: "",
      password: "123456",
      editcountry: [],
      emailRules: [
        v => !!v || 'E-mail Prefix is required',
        //v => /.+@.+\..+/.test(v) || 'E-mail must be valid',
      ],
      usernameRules: [(v) => !!v || "الرجاء ادخال البيانات"],
      activeRules: [(v) => !!v || "الرجاء ادخال البيانات"],
      flag: "",
      flagRules: [
        //v => !v || 'A file is required'
      ],
    };
  },
  props: {
    source: String,
  },
  components: {
    Menu,
  },
  methods: {
    cancel() {
      this.dialog = false
      this.$refs.form.reset()
    },
    loadgraphmodal() {
      this.gdialog = true;
    },
    loadmodal() {
      this.chksave = true;
      this.chkedit = false;
      this.dialog = true;
    },
    onSelectRole(event) {
      if(event == 'Agent' || event == 'Team Leader')
      this.group_name = 'callcenter'
      else
      this.group_name = event
    },
    onPageChange() {
      this.getData();
    },
    getColor (active) {
        if (active == 1) return 'green'
        else return 'red'
    },
    save() {
      if (this.$refs.form.validate()) {
        this.dialog = false;
        const config = {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("storeddata"),
            "Content-type": "application/json",
          },
        };
        axios
          .post(
            "http://127.0.0.1/backend/api/auth/user",
            { name: this.username,email: this.email+'@tirhal.net',password : this.password,role: this.role,group_name: this.group_name,active:  this.active },
            config
          )
          .then((response) => {
            this.getData();
            console.log(response);
            this.$refs.form.reset();
            this.$swal("تمت العملية بنجاح", "", "success");
          })
          .catch((error) => {
            /*if(error.message == 'Request failed with status code 422')
            this.$swal('البيانات موجودة بالفعل', "", "warning");
            else*/
             //this.$swal(error.message, "", "warning");
             console.log(error.message)
             this.$swal('الرجاء مراجعة البيانات', "", "warning");
          });
      }
    },
    edit() {
      if (this.$refs.form.validate()) {
        this.dialog = false;
        const config = {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("storeddata"),
            "Content-type": "application/json",
          },
        };
        console.log(this.editedItem)
        axios
          .put(
            "http://127.0.0.1/backend/api/auth/user/update",
            { id: this.editedItem["id"],name: this.username,email: this.email,role: this.role,group_name: this.group_name,active:  this.active },
            config
          )
          .then((response) => {
            console.log(response);
            this.getData();
            this.$refs.form.reset();
            this.$swal("تمت العملية بنجاح", "", "success");
          })
          .catch((error) => {
            console.log(error);
            this.$swal("error", "", "warning");
          });
      }
    },
    deleteItem(item){
            this.editedIndex = this.users.indexOf(item)
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
                      axios.delete('http://127.0.0.1/backend/api/auth/user/'+this.editedItem['id'],config)
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
    getData() {
      this.skeletonval = 0;
      const config = {
        headers: {
          Authorization: "Bearer " + localStorage.getItem("storeddata"),
          "Content-Type": "application/json",
        },
      };
      this.users = [];
      axios
        .get("http://127.0.0.1/backend/api/auth/user/show", config)
        .then((response) => {
          //this.dialog = false
          //this.showprogress = false
          //this.uploadPercentage = 0
          this.users = response.data.users;
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
        .catch((err) => {
          console.log(err);
        });
    },
    editItem(item) {
      this.editedIndex = this.users.indexOf(item);
      this.editedItem = Object.assign({}, item);
      this.username = this.editedItem["name"];
      this.password = this.editedItem["password"];
      this.email = this.editedItem["email"];
      this.role = this.editedItem["role"];
      this.active = this.editedItem["active"];
      this.group_name = this.editedItem["group_name"];
      this.chksave = false;
      this.chkedit = true;
      this.dialog = true;
    },
  },
  mounted() {
    this.getData();
    /*window.setInterval(() => {
      this.getCountries()
    }, 10000)*/
    //this.checkToken()
  },
  computed: {
    getPercentage() {
      return this.uploadPercentage;
    },
    getmail() {
      return this.$store.state.getEmail;
    },
    computedDateFormattedMomentjs() {
      return this.date ? moment(this.date).format("dddd, MMMM Do YYYY") : "";
    },
    computedDateFormattedDatefns() {
      return this.date ? format(this.date, "EEEE, MMMM do yyyy") : "";
    },
  },
};
</script>
<style scoped>
.theme--light.v-data-table
  > .v-data-table__wrapper
  > table
  > thead
  > tr:last-child
  > th {
  text-align: center !important;
}
</style>
