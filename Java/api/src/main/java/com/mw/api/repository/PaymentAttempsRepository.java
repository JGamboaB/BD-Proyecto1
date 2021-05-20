package com.mw.api.repository;

import com.mw.api.model.PaymentAttemps;
import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.stereotype.Repository;


@Repository
public interface PaymentAttempsRepository extends JpaRepository<PaymentAttemps, Long>{
}
