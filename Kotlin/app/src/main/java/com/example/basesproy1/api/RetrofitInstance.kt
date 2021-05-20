package com.example.basesproy1.api

//import com.example.basesproy1.util.Constants.Companion.BASE_URL
import com.example.basesproy1.util.Constants.Companion.BASE_URL_PRUEBA
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

object RetrofitInstance {

    private val retrofit by lazy{
        Retrofit.Builder()
            .baseUrl(BASE_URL_PRUEBA)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
    }

    val api: SimpleApi by lazy {
        retrofit.create(SimpleApi::class.java)
    }

}