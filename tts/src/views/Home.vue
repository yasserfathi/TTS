<template>
  <v-app>
    <v-main>
      <v-container fluid fill-height ma-0 pa-0 class="grey lighten-4">
        <v-col id="login" cols="12" sm="6" class="primary lighten-0" style="padding:160px">
          <img src="../../static/call-center.png" alt="ترحال" style="width:300px">
        </v-col>
        <v-col cols="12" sm="6">
        <v-layout align-center justify-center>
        <v-flex xs12 sm8 md8 lg10>
            <v-card class="elevation-1 pa-2 white lighten-3">
              <v-form v-model="valid" ref="form" @submit="submit" lazy-validation>
              <v-card-text>
                <div class="layout column align-center">
                  <img src="../../static/m.png" alt="ترحال" width="200" height="200">
                  <h1 class="flex my-4 primary--text text--lighten-0">T T S</h1>
                </div>
                  <v-text-field
                    name="email"
                    prepend-icon="mdi-account"
                    type="text"
                    v-model="email"
                    :autocomplete="autocomplete"
                    :rules="emailRules"
                    @keydown.enter="submit"
                    required
                  ></v-text-field>

                  <v-text-field
                    id="كلمة المرور"
                    name="password"
					:append-icon="showpassword ? 'mdi-eye' : 'mdi-eye-off'"
                    prepend-icon="mdi-lock"
					:type="showpassword ? 'text' : 'password'"
                    v-model="password"
                    :rules="passwordRules"
					@click:append="showpassword = !showpassword"
           @keydown.enter="submit"
                  ></v-text-field>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="primary darken-0" block rounded style="color:#fff" @click="submit" :loading="loading" :disabled="!valid">تسجيل الدخول</v-btn>
              </v-card-actions>
              </v-form>
            </v-card>
            <v-dialog
      v-model="dialog"
      width="800px"
    >
      <v-form ref="form2" lazy-validation>
      <v-card>
        <v-card-title style="color:#fff" class="primary lighten-1">
          Change Password
        </v-card-title>
        <v-container>
            <v-col
              class="align-center justify-space-between"
              cols="12"
            >
              <v-row>
                <v-text-field
                                  id="password_change"
                                  :type="'password'"
                                  name="password_change"
                                  v-model="password_change"
                                  prepend-icon="mdi-lock"
                                  :rules="password_changeRules"
                                  label="Password"
                                ></v-text-field>
            </v-row>
            <v-row>
                <v-text-field
                                  id="password_change_confirm"
                                  :type="'password'"
                                  name="password_change_confirm"
                                  v-model="password_change_confirm"
                                  prepend-icon="mdi-lock"
                                  :rules="password_changeRules"
                                  label="Confirm Password"
                                ></v-text-field>
            </v-row>
            </v-col>
        </v-container>
        <v-card-actions>
          <v-btn color="success" @click="change_password">حفظ</v-btn>
        </v-card-actions>
      </v-card>
      </v-form>
    </v-dialog>
        </v-flex>
        </v-layout>
        </v-col>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import axios from "axios";
export default {
  data: () => ({
    showpassword: false,
    loading: false,
    chksave:true,
    valid: false,
    email: "",
    dialog: false,
    password_change: '',
    password_change_confirm: '',
    msg: "",
    icon: "",
    temp: "",
    ResponseData: "",
    autocomplete: new Date().getTime().toString(), //==
    emailRules: [
      (v) => !!v || "الرجاء ادخال البريد الالكتروني",
      (v) => /.+@.+/.test(v) || "البريد الالكنروني غير صحيح",
    ],
    email2Rules: [
      (v) => !!v || "الرجاء ادخال البريد الالكتروني",
      (v) => /.+@.+/.test(v) || "البريد الالكنروني غير صحيح",
    ],
    password: "",
    passwordRules: [
        (v) => !!v || 'Password is required',
        (v) => (v && v.length <= 10) || 'Name must be less than 10 characters',
      ],
    password_changeRules: [(v) => !!v || "الرجاء ادخال كلمة المرور"],
    password_change_confirmRules: [(v) => !!v || "الرجاء ادخال كلمة المرور"],
  }),
  methods: {
    submit() {
      if (this.$refs.form.validate()) {

        axios.post(
            "http://127.0.0.1/backend/api/auth/login",
            { email: this.email, password: this.password },
            {
              headers: {
                "Content-type": "application/json",
              },
            }
          )
          .then((response) => {
            this.ResponseData = response.data
            if(response.data != "none")
            {
              if(response.data.message == "new")
              {
                this.temp = response.data.token.original.access_token
                this.dialog = true
              }
              else
              {
                localStorage.setItem("storeddata", response.data.access_token)
                this.$store.dispatch("setToken", response.data)
                if(response.data.user.role == 'Agent')
                  this.$router.push('agentticket')
                else
                  this.$router.push('ticket')
              }
            }
            else
            this.$swal('الرجاء التأكد من بيانات الدخول','','warning')
          })
          .catch((error) => {
            if(error.message == 'Network Error')
            {
              this.msg = 'خطأ في الاتصال مع المخدم'
              this.icon = 'error'
            }
            else
            if(error.message == 'Request failed with status code 401')
            {
              this.msg = 'الرجاء التأكد من بيانات الدخول'
              this.icon = 'warning'
            }
            this.$swal(this.msg,'',this.icon)
            this.ResponseData = error
            console.clear()
          });
      }
    },
    change_password() {
      if (this.$refs.form2.validate()) {
        this.dialog = false
        axios.put(
            "http://127.0.0.1/backend/api/auth/user/update",
            { email: this.email, password: this.password,new_password: this.password_change },
            {
              headers: {
                        'Authorization': 'Bearer '+this.temp,
                        'Access-Control-Allow-Origin': true,
                    }
            }
          )
          .then((response) => {
            this.ResponseData = response
            this.$swal('تمت العملية بنجاح','','success')
          })
          .catch((error) => {
            if(error.message == 'Network Error')
            {
              this.msg = 'خطأ في الاتصال مع المخدم'
              this.icon = 'error'
            }
            else
            if(error.message == 'Request failed with status code 401')
            {
              this.msg = 'الرجاء التأكد من بيانات الدخول'
              this.icon = 'warning'
            }
            this.$swal(this.msg,'',this.icon)
            this.ResponseData = error
          });
      }
    },
  },
  mounted() {
    //this.$refs.form.reset();
  },
};
</script>
<style scoped lang="css">
  #login {
    height: 100%;
    width: 100%;
    content: "";
    z-index: 0;
  }
</style>
