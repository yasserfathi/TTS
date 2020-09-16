<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use Validator;
use Illuminate\Http\Request;
use App\Users;


class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function __construct()
    {
        //$this->middleware('auth:api', ['except' => ['create']]);
    }

    public function index()
    {
        
        /*$ticket = Ticket::all();
        echo($ticket);*/
        return response()->json(auth()->user());
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        if(Auth::check())
        {
            $validator = Validator::make($request->all(), [               
				'name' => 'required|string',
                'email' => 'required|string',
				'created_by' => 'required',
                'password' => 'required|string',
                'role' => 'required',
                'group_name' => 'required',
                'active' => 'required',
                'updated_at' => 'required',
                'created_at' => 'required',
            ]);

            $users = Users::create(array_merge(
                        $validator->validated(),
						['created_by' => auth()->user()['id']],
						['password' => bcrypt($request->password)]
                    ));

            return response()->json([
                'message' => 'Successfully Added',
                'users' => $users
            ], 201);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\purpose  $purpose
     * @return \Illuminate\Http\Response
     */
    public function show()
    {
         if(Auth::check()){
			 return response()->json([
                'users' => Users::orderBy('id','desc')->get()
            ], 201);
		 }
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\purpose  $purpose
     * @return \Illuminate\Http\Response
     */
    public function edit(Users $users)
    {
        //echo $request->input('purpose_title');
        /*$flight = App\purpose::find(1);

        $flight->purpose_title = 'New Flight Name';

        $flight->save();*/
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\purpose  $purpose
     * @return \Illuminate\Http\Response
     */
    
	public function update(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string|min:6',
        ]);
		
		if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }
		
		Users::where('email', '=', $request->email)->update(array('password' => bcrypt($request->new_password)));

        //$user->password = bcrypt($request->password);

        //$users->save();

        return response()->json([
            'message' => 'Updated Successfully'
        ], 201);
    }
	/*public function update(Request $request)
    {
        $users = Users::find($request->id);

        $users->name = $request->name;
		if($users->password != ''){
			$users->password = bcrypt($request->password);
		}
        $users->email = $request->email;
        $users->role = $request->role;
        $users->group_name = $request->group_name;
        $users->active = $request->active;
        //$users->save();

        return response()->json([
            'message' =>  $users
        ], 201);
    }
	
	public function reset_update(Request $request)
    {
        $users = Users::find($request->id);

        $users->name = $request->name;
		if
		$users->password = bcrypt($request->password);
        $users->email = $request->email;
        $users->role = $request->role;
        $users->group_name = $request->group_name;
        $users->active = $request->active;
        $users->save();

        return response()->json([
            'message' => 'Reset Successfully'
        ], 201);
    }*/

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\users  $users
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Users::where('id', '=', $id)->delete();
        return response()->json([
            'message' => 'Successfully Deleted',
        ], 201);
    }
}
