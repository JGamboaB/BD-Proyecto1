package com.mw.api.repository;

import com.mw.api.model.wk_merchants;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface MerchantRepository extends JpaRepository<wk_merchants, Integer>{

}
