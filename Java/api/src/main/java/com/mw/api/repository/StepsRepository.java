package com.mw.api.repository;

import com.mw.api.model.Steps;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.persistence.*;

@Repository
public interface StepsRepository extends JpaRepository<Steps, Integer> {


}












