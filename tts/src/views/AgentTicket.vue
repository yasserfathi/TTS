<template>
  <v-app id="inspire">
    <template>
      <div>
        <v-app-bar
          :clipped-left="$vuetify.breakpoint.lgAndUp"
          app
          v-bind:class="{primary:kolor,secondary:nokolor}"
        >
          <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
          <v-toolbar-title style="width: 250px">
            <span class="hidden-sm-and-down">ترحال TTS</span>
          </v-toolbar-title>
            <template>
      <v-tabs
        fixed-tabs
         color="white"
        v-model="tab"
        class="ml-0 pl-2"
      >
        <v-tabs-slider></v-tabs-slider>
        <v-tab href="#new">
          <v-badge
              color="black"
            >
            <span slot="badge"> {{createdtickts}} </span>
            <v-icon text>mdi-inbox</v-icon> New Ticket
            </v-badge>
        </v-tab>
        <v-tab href="#pending">
          <v-badge
              color="black"
            >
            <span slot="badge"> {{openedtickts}} </span>
            <v-icon text>mdi-ticket</v-icon> Pending Ticket
            </v-badge>
        </v-tab>
      </v-tabs>
    </template>
            
          <v-spacer></v-spacer>
          {{username}}
          <v-menu open-on-hover offset-y>
            <template v-slot:activator="{ on, attrs }">
              <v-btn v-bind="attrs" v-on="on" text>
                <v-avatar size="40px">
                  <img src="../static/avatar/user.png" />
                </v-avatar>
              </v-btn>
            </template>
            <v-list>
              <v-list-item @click="logout">
                <v-list-item-title>
                  <v-icon>mdi-logout</v-icon>تسجيل الخروج
                </v-list-item-title>
              </v-list-item>
            </v-list>
          </v-menu>
          <v-menu offset-y>
            <template v-slot:activator="{ on, attrs }">
              <v-btn icon v-bind="attrs" v-on="on">
                <v-icon>mdi-dots-vertical</v-icon>
              </v-btn>
            </template>

            <v-list>
              <v-list-item @click="logout">
                <v-list-item-title>
                  <v-icon>mdi-logout</v-icon>تسجيل الخروج
                </v-list-item-title>
              </v-list-item>
            </v-list>
          </v-menu>
        </v-app-bar>
      </div>
    </template>
    <v-main>
      <v-container  grid-list-xl fluid>
        <v-layout row wrap>
        <v-flex lg12>
        <template>
        <v-tabs-items v-model="tab">
          <v-tab-item value="new" :transition="false" :reverse-transition="false">
            <v-container color="grey" grid-list-md text-xs-center>
              <v-flex xs12>
               <v-form v-model="search_valid" ref="form" lazy-validation>
                <v-container>
                <v-row align="center" >
                <v-col cols="1" md="1"></v-col>
                <v-col cols="8" md="8">
                <v-autocomplete
                          id="search"
                          name="search"
                          v-model="search"
                          prepend-inner-icon="mdi-card-search-outline"
                          :items="tickets"
                          item-text="caller_name"
                          placeholder="Search by Caller Name"
                          ></v-autocomplete>
                </v-col>
             </v-row>
              </v-container>
              </v-form>
</v-flex>

<template>
            <v-data-table
              ref="myTable"
              :headers="headers"
              :items="tickets"
              class="elevation-1"
              v-if="showtbl"
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
    <template>
  <v-row>
    <v-dialog v-model="dialog_det" fullscreen max-width="1000">
      <v-card>
        <v-toolbar dark color="primary">
          <v-btn icon dark @click="dialog_det = false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
          <v-toolbar-title>Ticket Details</v-toolbar-title>
        </v-toolbar>
        <v-card-text>
          <v-simple-table light class="ma-6">
    <template v-slot:default>
      <tbody>
        <tr>
          <td>Ticket No</td>
          <td>{{ticket_no}}</td>
        </tr>
        <tr>
          <td>Name</td>
          <td>{{caller_name}}</td>
        </tr>
        <tr>
          <td>Phone</td>
          <td>{{caller_phone}}</td>
        </tr>
        <tr>
          <td>Email</td>
          <td>{{caller_email}}</td>
        </tr>
        <tr>
          <td>Balance</td>
          <td>{{caller_balance}}</td>
        </tr>
        <tr>
          <td>Type</td>
          <td>{{type}}</td>
        </tr>
        <tr>
          <td>Purpose</td>
          <td>{{purpose}}</td>
        </tr>
        <tr>
          <td>Plate No</td>
          <td>{{plate_no}}</td>
        </tr>
        <tr>
          <td>Order ID</td>
          <td>{{order_id}}</td>
        </tr>
        <tr>
          <td>Deatils</td>
          <td>{{content}}</td>
        </tr>
      </tbody>
    </template>
  </v-simple-table>
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-row>
</template>
        <v-toolbar-title>New Tickets</v-toolbar-title>
        <v-spacer></v-spacer>
              </v-toolbar>
              </template>
              <template v-slot:item.actions="{ item }">
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
    <template v-slot:[`item.actions`]="{ item }">
      <v-icon
        small
        class="mr-2"
        @click="viewItem(item)"
      >
        mdi-lock-open
      </v-icon>
    </template>
            </v-data-table>

          </template>
              
            </v-container>
          </v-tab-item>
          <v-tab-item value="pending" :transition="false" :reverse-transition="false">
            <v-container color="grey" grid-list-md text-xs-center>
              <v-flex xs12>
               <v-form v-model="search_valid" ref="form" lazy-validation>
                <v-container>
                <v-row align="center" >
                <v-col cols="1" md="1"></v-col>
                <v-col cols="8" md="8">
                <v-autocomplete
                          id="search_pending"
                          name="search_pending"
                          v-model="search_pending"
                          @click:append = "itemsForSelected"
                          prepend-inner-icon="mdi-card-search-outline"
                          :items="tickets"
                          item-text="caller_name"
                          placeholder="Search by Caller Name"
                          clearable deletable-chips
                          ></v-autocomplete>
                </v-col>
             </v-row>
              </v-container>
              </v-form>
</v-flex>

<template>
            <v-data-table
              ref="myTable"
              :headers="headers"
              :items="itemsForSelected"
              class="elevation-1"
              v-if="showtbl"
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
    <template>
  <v-row>
    <v-dialog v-model="dialog_det" fullscreen max-width="1000">
      <v-card>
        <v-toolbar dark color="primary">
          <v-btn icon dark @click="dialog_det = false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
          <v-toolbar-title>Ticket Details</v-toolbar-title>
        </v-toolbar>
        <v-card-text>
          <v-simple-table light class="ma-6">
    <template v-slot:default>
      <tbody>
        <tr>
          <td>Ticket No</td>
          <td>{{ticket_no}}</td>
        </tr>
        <tr>
          <td>Name</td>
          <td>{{caller_name}}</td>
        </tr>
        <tr>
          <td>Phone</td>
          <td>{{caller_phone}}</td>
        </tr>
        <tr>
          <td>Email</td>
          <td>{{caller_email}}</td>
        </tr>
        <tr>
          <td>Balance</td>
          <td>{{caller_balance}}</td>
        </tr>
        <tr>
          <td>Type</td>
          <td>{{type}}</td>
        </tr>
        <tr>
          <td>Purpose</td>
          <td>{{purpose}}</td>
        </tr>
        <tr>
          <td>Plate No</td>
          <td>{{plate_no}}</td>
        </tr>
        <tr>
          <td>Order ID</td>
          <td>{{order_id}}</td>
        </tr>
        <tr>
          <td>Deatils</td>
          <td>{{content}}</td>
        </tr>
      </tbody>
    </template>
  </v-simple-table>
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-row>
</template>
        <v-toolbar-title>Pending Tickets</v-toolbar-title>
        <v-spacer></v-spacer>
              </v-toolbar>
              </template>
              <template v-slot:item.actions="{ item }">
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
    <template v-slot:[`item.actions`]="{ item }">
      <v-icon
        small
        class="mr-2"
        @click="viewItem(item)"
      >
        mdi-lock-open
      </v-icon>
    </template>
            </v-data-table>

          </template>
              
            </v-container>
          </v-tab-item>
        </v-tabs-items>
          </template>
        </v-flex>
        </v-layout>
      </v-container>
    </v-main>
  </v-app>
</template>
<script>
  import axios from 'axios';
  export default {
    data () {
      return {
        id:'',
        tab: null,
        chksave:true,
        loading:true,
        chkedit:false,
        valid: false,
        search_valid: false,
        dialog: false,
        dialog_det: false,
        gdialog: false,
        showtbl: true,
        editedIndex: -1,
        skeletonval: 0,
        showprogress: false,
        caller_phone: '',
        caller_name: '',
        caller_balance: '',
        caller_email: '',
        plate_no: '',
        name: '',
        ophone: '',
        order_id: '',
        trip_request: '',
        type: '',
        purpose: '',
        category: '',
        app: '',
        content: '',
        search: null,
        search_pending: null,
        lazy: false,
        drawer: null,
        username: "",
        isAgent: false,
        isOther: false,
        kolor: true,
        nokolor:  false,
        selected: [1],
        agentitems: [
          {
            title: "Ticket",
            action: "mdi-ticket",
            to: "/agentticket",
            new: true
          },
        ],
        network: "",
        headers: [
          { text: 'Caller Name', value: 'caller_name' },
          { text: 'Phone', value: 'caller_phone' },
          { text: 'Actions', value: 'actions', sortable: false },
        ],
        search_result: [],
        types: ['Driver', 'Passenger'],
        ResponseData: '',
        categories: [],
        apps: [],
        purposes: ['suggestion', 'complaint'],
        editedItem: {
          category_title: '',
          created_at: '',
          id: '',
          updated_at: '',
        },
        posts: [],
        tickets: [],
        ticketsall: [],
        pagination: {
                current: 1,
                total: 0
        },
        categoryRules: [
          v => !!v || 'Please Fill Data',
        ],
      }
    },
    props: {
      source: String,
    },
    methods: {
        async check_Token() {
        const config = {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("storeddata"),
          },
        };
        axios
          .get("http://127.0.0.1/backend/api/auth/profile", config)
          .then((response) => {
            this.username = response.data.name;
            if(response.data.role == 'Agent')
            {
              this.isAgent = true
            }
            this.kolor = true;
            this.nokolor = false;
          })
          .catch((error) => {
            this.username = "";
            this.kolor = false;
            this.nokolor = true;
            this.ResponseData = error
          });
      },
      logout() {
        this.$swal({
          title: "هل تريد الخروج",
          icon: "warning",
          buttons: true,
          dangerMode: true,
        }).then((willDelete) => {
          if (willDelete) {
            const config = {
                    headers: {
                        Authorization: "Bearer " + localStorage.getItem("storeddata")
                    }
            }
            axios
              .post("http://127.0.0.1/backend/api/auth/logout",{} ,config)
              .then()
              .catch(() => {
                console.clear()
              });
              localStorage.removeItem("storeddata");
              this.$store.dispatch("setToken", null);
              this.$router.push("/");
          }
        });
      },
      submit(item) {
      console.log(item)
      /*if (this.$refs.form.validate()) {
        const config = {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("storeddata"),
            "Content-type": "application/json",
          },
        };
        axios.get("http://127.0.0.1/backend/api/auth/ticket/search/"+this.search,config)
          .then((response) => {
            this.tickets = response.data.ticket
            this.showtbl =true
          })
          .catch((error) => {
            this.ResponseData = error
          });
      }*/
    },
        loadmodal(){
          this.chksave = true 
          this.chkedit = false
          this.dialog = true
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
            console.log(config)
            axios.post("http://127.0.0.1/backend/api/auth/ticket",
            {
              ticket_no: this.app,
              caller_phone: this.caller_phone,
              caller_name: this.caller_name,
              caller_balance: this.caller_balance,
              caller_email: this.caller_email,
              plate_no: this.plate_no,
              type: this.type,
              purpose: this.purpose,
              content: this.content,
              category: this.category,
              otherphone: this.ophone,
              status: 'created',
              created_by: '7',
            },config)
            .then((response) => {
             //this.getData();
             console.log(response)
             this.ResponseData = response
          })
          .catch((error) => {
            this.ResponseData = error
            console.log(error)
            this.$swal('error','','warning')
          });
          }
        },
        getData(){
            this.skeletonval = 0
            const config = {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem("storeddata"),
                        'Content-Type': 'application/json',
                    }
            }
            this.tickets = []
           axios.get('http://127.0.0.1/backend/api/auth/ticket/created_opened_status',config)
                .then(response => { 
                      this.tickets = response.data.ticket
                      this.ticketsall = response.data.ticket
                      console.log(response)
                })
                .catch(error => {
                  this.ResponseData = error
                  console.log(error)
                })
            setTimeout(function () {
               this.getData()
            }, 3000);
        },
        viewItem(item){
          this.editedIndex = this.categories.indexOf(item)
          this.editedItem = Object.assign({}, item)
          this.ticket_no = this.editedItem['ticket_no']
          this.caller_phone = this.editedItem['caller_phone']
          this.caller_name = this.editedItem['caller_name']
          this.caller_email = this.editedItem['caller_email']
          this.caller_balance = this.editedItem['caller_balance']
          this.type = this.editedItem['type']
          this.purpose = this.editedItem['purpose']
          this.plate_no = this.editedItem['plate_no']
          this.order_id = this.editedItem['orderid']
          this.content = this.editedItem['content']
          this.dialog_det = true
          if(this.editedItem['status'] == 'created')
            {
              const config = {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem("storeddata"),
                            'Content-Type': 'application/json',
                        }
                }
                this.tickets = []
              axios.post('http://127.0.0.1/backend/api/auth/ticket/update_status',{ id:this.editedItem['id'],status: 'opened' },config)
                    .then(response => {
                          this.getData()
                          console.log(response)
                    })
                    .catch(error => {
                      this.ResponseData = error
                      console.log(error)
                    })
          }//if
        },
        editItem(item){
          this.editedIndex = this.categories.indexOf(item)
          this.editedItem = Object.assign({}, item)
          this.category = this.editedItem['category_title']
          this.chksave = false
          this.chkedit = true
          this.dialog = true
        },
    },
    mounted() {
      //this.username = localStorage.getItem("storeddata");
      this.check_Token();
      this.getData()
      //setTimeout(function () { this.check_Token(); this.getData(); }.bind(this), 1000)
      //this.check_Token()
      //this.username = shared.check_Token()
    },
    watch: {
      createdtickts(newValue) {
            alert(`yes, createdtickts changed: ${newValue}`);
      },
      openedtickts(newValue) {
            alert(`yes, openedtickts changed: ${newValue}`);
      },
    },
    computed: {
      createdtickts() {
          return this.ticketsall.filter((ticketsall) => {
              return ticketsall.status.match('created')
          }).length;
      },
      openedtickts() {
          return this.ticketsall.filter((ticketsall) => {
              return ticketsall.status.match('opened')
          }).length;
      },
      itemsForSelected() {
          return this.tickets.filter((tickets) => {
              return tickets.caller_name.match(this.search_pending)
          });
      }
    },
  }
</script>