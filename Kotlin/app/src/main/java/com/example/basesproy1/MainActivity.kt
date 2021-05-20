package com.example.basesproy1

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.TextView
import android.widget.Toast
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.example.basesproy1.model.Post
import com.example.basesproy1.repository.Repository

class MainActivity : AppCompatActivity() {

    private lateinit var viewModel: MainViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val textView = findViewById(R.id.textPrueba) as TextView

        val repository = Repository()
        val viewModelFactory = MainViewModelFactory(repository)
        viewModel = ViewModelProvider(this, viewModelFactory).get(MainViewModel::class.java)

        /*
        // POST ===
        val myPost = Post(2, 2, "Prueba", "Flyway k7")
        viewModel.pushPost(myPost)
        viewModel.myResponse.observe(this, Observer { response ->
            if(response.isSuccessful){
                Log.d("Main", response.body().toString())
                Log.d("Main", response.code().toString())
                Log.d("Main", response.message())
            }else{
                Toast.makeText(this, response.code(), Toast.LENGTH_SHORT).show()
            }
        })
        */


        // GET  ===
        viewModel.getPost()
        viewModel.myResponse.observe(this, Observer { response ->
            if(response.isSuccessful){

                /*
                Log.d("Response", response.body()?.userId.toString())
                Log.d("Response", response.body()?.id.toString())
                textView.text = response.body()?.title!!
                //Log.d("Response", response.body()?.title!!)
                Log.d("Response", response.body()?.body!!)
                 */


                Log.d("Response", response.body()?.Name.toString())
                Log.d("Response", response.body()?.Creation_Date.toString())
                textView.text = response.body()?.Name.toString()


            }else{
                Log.d("Response", response.errorBody().toString())
                textView.text = response.code().toString()
            }
        })

    }
}