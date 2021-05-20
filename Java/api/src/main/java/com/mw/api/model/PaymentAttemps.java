package com.mw.api.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.*;

import ch.qos.logback.core.util.SystemInfo;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;


/*
@NamedStoredProcedureQueries({
        @NamedStoredProcedureQuery(
                name = "registerPayment",
                procedureName = "wk_registerPayment",
                parameters = {
                    @StoredProcedureParameter(name = "pClientUserName", type = String.class, mode = ParameterMode.IN),
                    @StoredProcedureParameter(name = "pMerchantName", type = String.class, mode = ParameterMode.IN),
                    @StoredProcedureParameter(name = "pAmount", type = BigDecimal.class, mode = ParameterMode.IN),
                    @StoredProcedureParameter(name = "pPaymentStatus", type = String.class, mode = ParameterMode.OUT)
                }
        )
})
 */
@Entity
@Table(name = "wk_paymentAttemps")
@EntityListeners(AuditingEntityListener.class)
public class PaymentAttemps {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long paymentAttempid;

    @Column(name = "clientid", nullable = false)
    private long clientid;

    @Column(name = "paymentstatusid", nullable = false)
    private int paymentStatusid;

    @Column(name = "merchantid", nullable = false)
    private int merchantid;

    @CreationTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "posttime", nullable = false)
    private Date posttime;

    @Column(name = "amount", nullable = false)
    private BigDecimal amount;

    @Column(name = "currentsymbol", nullable = false)
    private String currentSymbol;

    @Column(name = "errornumber", nullable = false)
    private long errorNumber;

    @Column(name = "merchanttransNumber", nullable = false)
    private long merchantTransNumber;

    @Column(name = "description", nullable = false)
    private String description;

    @CreationTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "paymenttimestamp", nullable = false)
    private Date paymentTimeStamp;

    @Column(name = "computername", nullable = false)
    private String computerName;

    @Column(name = "username", nullable = false)
    private String userName;

    @Column(name = "ipadress", nullable = false)
    private String ipAdress;

    @Column(name = "checksum", nullable = true)
    private int checkSum;


    public long getPaymentAttempid() {
        return paymentAttempid;
    }

    public void setPaymentAttempid(long paymentAttempid) {
        this.paymentAttempid = paymentAttempid;
    }

    public long getClientid() {
        return clientid;
    }

    public void setClientid(long clientid) {
        this.clientid = clientid;
    }

    public int getPaymentStatusid() {
        return paymentStatusid;
    }

    public void setPaymentStatusid(int paymentStatusid) {
        this.paymentStatusid = paymentStatusid;
    }

    public int getMerchantid() {
        return merchantid;
    }

    public void setMerchantid(int merchantid) {
        this.merchantid = merchantid;
    }

    public Date getPosttime() {
        return posttime;
    }

    public void setPosttime(Date posttime) {
        this.posttime = posttime;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getCurrentSymbol() {
        return currentSymbol;
    }

    public void setCurrentSymbol(String currentSymbol) {
        this.currentSymbol = currentSymbol;
    }

    public long getErrorNumber() {
        return errorNumber;
    }

    public void setErrorNumber(long errorNumber) {
        this.errorNumber = errorNumber;
    }

    public long getMerchantTransNumber() {
        return merchantTransNumber;
    }

    public void setMerchantTransNumber(long merchantTransNumber) {
        this.merchantTransNumber = merchantTransNumber;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getPaymentTimeStamp() {
        return paymentTimeStamp;
    }

    public void setPaymentTimeStamp(Date paymentTimeStamp) {
        this.paymentTimeStamp = paymentTimeStamp;
    }

    public String getComputerName() {
        return computerName;
    }

    public void setComputerName(String computerName) {
        this.computerName = computerName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getIpAdress() {
        return ipAdress;
    }

    public void setIpAdress(String ipAdress) {
        this.ipAdress = ipAdress;
    }

    public int getCheckSum() {
        return checkSum;
    }

    public void setCheckSum(int checkSum) {
        this.checkSum = checkSum;
    }
}
