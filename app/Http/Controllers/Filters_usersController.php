<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use Validator;
use Illuminate\Http\Request;
use App\Filters_users;


class Filters_usersController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['create']]);
    }

    public function index()
    {
        
        /*$ticket = Ticket::all();
        echo($ticket);*/
        //return response()->json(auth()->user());
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
                'user' => 'required',
                'filter_title' => 'required',
                'user_id' => 'required',
            ]);

            $filters_users = Filters_users::create(array_merge(
                        $validator->validated(),
						['user_id' => auth()->user()['id']]
                    ));

            return response()->json([
                'message' => 'Successfully Added',
                'filters_users' => $filters_users
            ], 201);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function show()
    {
        return response()->json([
                'filters_users' => \DB::table('filters_users')
				->join('users','filters_users.user','=','users.id')
				->where('filters_users.deleted_at','=','NULL')
				->select('filters_users.id as id','user','name','filter_title')->orderBy('filters_users.id','desc')->get()
            ], 201);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function edit(Filters_users $filters_users)
    {
        //echo $request->input('category_title');
        /*$flight = App\Category::find(1);

        $flight->category_title = 'New Flight Name';

        $flight->save();*/
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        
        $filters_users = Filters_users::find($request->id);

        $filters_users->user = $request->user;
        $filters_users->filter_title = $request->filter_title;

        $filters_users->save();

        return response()->json([
            'message' => 'Successfully Updated',
        ], 201);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Filters_users::where('id', '=', $id)->delete();
        return response()->json([
            'message' => 'Successfully Deleted',
        ], 201);
    }
}
