package com.example.basesproy1.model

import com.google.gson.annotations.SerializedName

data class Post (

    val userId: Int,
    val id: Int,
    val title: String,
    val body: String


    /*
    @SerializedName("Creation Date")
    val Name: String,
    val Creation_Date: String
    */
)