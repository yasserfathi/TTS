<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use Validator;
use Illuminate\Http\Request;
use App\Category;


class CategoryController extends Controller
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
                'category_title' => 'required|string',
                'created_by' => 'required',
                'category_type' => 'required',
                'category_priority' => 'required',
            ]);

            $category = Category::create(array_merge(
                        $validator->validated(),
						['created_by' => auth()->user()['id']]
                    ));

            return response()->json([
                'message' => 'Successfully Added',
                'category' => $category
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
                'categories' => Category::orderBy('id','desc')->get()
            ], 201);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function edit(Category $category)
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
        
        $category = Category::find($request->id);

        $category->category_title = $request->category_title;
        $category->category_type = $request->category_type;
        $category->category_priority = $request->category_priority;

        $category->save();

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
        Category::where('id', '=', $id)->delete();
        return response()->json([
            'message' => 'Successfully Deleted',
        ], 201);
    }
}
