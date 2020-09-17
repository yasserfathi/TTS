<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


/*Route::group([
    'middleware' => 'api',
    'prefix' => 'auth'

], function ($router) {
    Route::post('login', 'AuthController@login');
    Route::post('register', 'AuthController@register');
    Route::post('logout', 'AuthController@logout');
    Route::post('refresh', 'AuthController@refresh');
    Route::get('user-profile', 'AuthController@userProfile');
    Route::resource('category', 'CategoryController');
});*/

Route::group([
    'middleware' => 'api',
    'prefix' => 'auth'

], function ($router) {

    Route::post('register', 'AuthController@register');
    Route::post('login', 'AuthController@login');
    Route::post('logout', 'AuthController@logout');
    Route::post('refresh', 'AuthController@refresh');
    Route::get('profile', 'AuthController@profile');
    Route::post('update', 'AuthController@update');
    Route::get('users/show', 'AuthController@show');
    
    Route::get('ticket/created_opened_status', 'TicketController@created_opened_status');
    Route::get('ticket/search/{name?}', 'TicketController@search');
    Route::get('ticket/search_status/{name?}', 'TicketController@search_status');
	Route::resource('ticket', 'TicketController');
	Route::post('ticket/update_status', 'TicketController@update_status');
    Route::resource('category', 'CategoryController');
    Route::resource('purpose', 'PurposeController');
    Route::resource('app', 'AppController');
	Route::resource('user', 'UserController');
    Route::resource('filter', 'filterController');
    

});
Route::resource('users', 'UserController');