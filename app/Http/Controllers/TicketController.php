<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use Validator;
use Illuminate\Http\Request;
use Carbon\Carbon;
use App\Ticket;


class TicketController extends Controller
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
        return json_encode(Ticket::all());
        //return response()->json($tickets);
        //return Ticket::get();
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
                'ticket_no' => 'required',
                'caller_phone' => 'required|string',
                'caller_name' => 'required|string',
                'caller_balance' => 'required|string',
                'plate_no' => 'required|string',
                'type' => 'required|string',
                'purpose' => 'required|string',
                'category' => 'required',
                'status' => 'required|string',
                'content' => 'required|string',
                ['created_by' => auth()->user()['id']]
            ]);
            
            if ($validator->fails()) {
				return response()->json([
					'validator' => $validator->failed(),
				], 201);
            }
            
            $ticket = Ticket::create(array_merge(
                        $validator->validated(),
						['ticket_no' => $request->ticket_no.Carbon::now()->timestamp]
                    ));

            return response()->json([
                'message' => 'Successfully registered',
                'ticket' => $ticket
            ], 200);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Ticket  $ticket
     * @return \Illuminate\Http\Response
     */
    public function show(Ticket $ticket)
    {
        //
    }

    public function search($phrase)
    {
        if(Auth::check())
        {
            $result = Ticket::where('id','=', $phrase)
					->orWhere('ticket_no', 'like', '%' . $phrase . '%')
					->orWhere('caller_name', 'like', '%' . $phrase . '%')
					->orWhere('caller_phone', '=', $phrase)
					->orWhere('ticket_no', '=', $phrase)
					->get();
            return response()->json([
                'ticket' => $result
            ], 201);
        }
    }
	
	public function search_status($status)
    {
        if(Auth::check())
        {
            $result = Ticket::where('status','=', $status)->get();
            return response()->json([
                'ticket' => $result
            ], 201);
        }
    }
	
	public function created_opened_status()
    {
        if(Auth::check())
        {
            $result = Ticket::where('status','=', 'created')->orwhere('status','=', 'opened')->get();
            return response()->json([
                'ticket' => $result
            ], 201);
        }
    }
	
	public function update_status(Request $request)
    {
        if(Auth::check())
        {
            $result = Ticket::where('status','=', $request->status)->get();
			$ticket = Ticket::find($request->id);
			$ticket->status = $request->status;
			$ticket->save();
			
            return response()->json([
                'ticket' => 'Updated'
            ], 201);
        }
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Ticket  $ticket
     * @return \Illuminate\Http\Response
     */
    public function edit(Ticket $ticket)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Ticket  $ticket
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Ticket $ticket)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Ticket  $ticket
     * @return \Illuminate\Http\Response
     */
    public function destroy(Ticket $ticket)
    {
        //
    }
}
