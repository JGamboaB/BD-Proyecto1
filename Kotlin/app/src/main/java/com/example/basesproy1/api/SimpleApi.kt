package com.example.basesproy1.api

import com.example.basesproy1.model.Post
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.POST

interface SimpleApi {

    // GET API  ===
    @GET("posts/1")
    //@GET("workouts/:shaquille.oatmeal")
    suspend fun getPost(): Response<Post>

    // POST API ===
    @POST("posts")
    //@POST("")
    suspend fun pushPost(
        @Body post: Post
    ): Response<Post>

}