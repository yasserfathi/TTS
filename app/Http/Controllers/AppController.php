<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use Validator;
use Illuminate\Http\Request;
use App\App;


class AppController extends Controller
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
                'app_name' => 'required|string',
                'app_abbr' => 'required|string',
                'created_by' => 'required',
            ]);

            $app = App::create(array_merge(
                        $validator->validated(),
						['created_by' => auth()->user()['id']]
                    ));

            return response()->json([
                'message' => 'Successfully Added',
                'app' => $app
            ], 201);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\App  $app
     * @return \Illuminate\Http\App
     */
    public function show()
    {
        return response()->json([
				'apps' => App::orderBy('id','desc')->get()
            ], 201);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\purpose  $purpose
     * @return \Illuminate\Http\Response
     */
    public function edit(Purpose $purpose)
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
     * @param  \App\App  $app
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        
        $app = App::find($request->id);

        $app->app_name = $request->app_name;
		
        $app->app_abbr = $request->app_abbr;

        $app->save();

        return response()->json([
            'message' => 'Successfully Updated',
        ], 201);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\App  $app
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        App::where('id', '=', $id)->delete();
        return response()->json([
            'message' => 'Successfully Deleted',
        ], 201);
    }
}
