package com.example.basesproy1.api

import com.example.basesproy1.model.Post
import retrofit2.Response
import retrofit2.http.GET

interface SimpleApi {

    @GET("posts/1")
    //@GET("shaquille.oatmeal")
    suspend fun getPost(): Response<Post>

}