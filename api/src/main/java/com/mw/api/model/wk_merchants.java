package com.mw.api.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;


@Entity
@Table(name = "wk_merchants")
public class wk_merchants {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int merchantid;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "url", nullable = false)
    private String url;

    @Column(name = "iconurl", nullable = false)
    private String iconUrl;

    public int getMerchantid() {
        return merchantid;
    }

    public void setMerchantid(int merchantid) {
        this.merchantid = merchantid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getIconUrl() {
        return iconUrl;
    }

    public void setIconUrl(String iconUrl) {
        this.iconUrl = iconUrl;
    }

    @Override
    public String toString() {
        return "wk_merchants{" +
                "merchantid=" + merchantid +
                ", name='" + name + '\'' +
                ", url='" + url + '\'' +
                ", iconUrl='" + iconUrl + '\'' +
                '}';
    }
}




/**
 * CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_merchants` (
 *   `merchantid` INT NOT NULL AUTO_INCREMENT,
 *   `name` VARCHAR(100) NOT NULL,
 *   `url` VARCHAR(255) NOT NULL,
 *   `enabled` BIT NOT NULL DEFAULT 1,
 *   `iconUrl` VARCHAR(255) NOT NULL,
 *   PRIMARY KEY (`merchantid`))
 * ENGINE = InnoDB;
 */