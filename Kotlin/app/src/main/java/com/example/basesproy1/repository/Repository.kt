package com.example.basesproy1.repository

import com.example.basesproy1.api.RetrofitInstance
import com.example.basesproy1.model.Post
import retrofit2.Response

class Repository {

    suspend fun getPost(): Response<Post> {
        return RetrofitInstance.api.getPost()
    }

}