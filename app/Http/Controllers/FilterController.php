<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use Validator;
use Illuminate\Http\Request;
use App\Filter;


class FilterController extends Controller
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
                'filter_title' => 'required|string',
                'purpose' => 'required',
                'filter_type' => 'required',
                'cateory_list' => 'required',
                'created_by' => 'required',
            ]);

            $filter = Filter::create(array_merge(
                        $validator->validated(),
						['created_by' => auth()->user()['id']]
                    ));

            return response()->json([
                'message' => 'Successfully Added',
                'filter' => $filter
            ], 201);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\filter  $filter
     * @return \Illuminate\Http\Response
     */
    public function show()
    {
        return response()->json([
                'filters' => Filter::orderBy('id','desc')->get()
            ], 201);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\filter  $filter
     * @return \Illuminate\Http\Response
     */
    public function edit(Filter $filter)
    {
        //echo $request->input('filter_title');
        /*$flight = App\filter::find(1);

        $flight->filter_title = 'New Flight Name';

        $flight->save();*/
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\filter  $filter
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        
        $filter = Filter::find($request->id);

        $filter->filter_title = $request->filter_title;
        $filter->purpose = $request->purpose;
        $filter->filter_type = $request->filter_type;
        $filter->cateory_list = $request->cateory_list;

        $filter->save();

        return response()->json([
            'message' => 'Successfully Updated',
        ], 201);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\purpose  $purpose
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Filter::where('id', '=', $id)->delete();
        return response()->json([
            'message' => 'Successfully Deleted',
        ], 201);
    }
}
