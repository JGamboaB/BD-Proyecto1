package com.mw.api.model;

import java.util.Date;

import javax.persistence.*;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@Entity
/*
@NamedStoredProcedureQuery(

        name = "calculate",
        procedureName = "calculate",
        parameters = {
                @StoredProcedureParameter(mode = ParameterMode.IN, type = Double.class, name = "x"),
                @StoredProcedureParameter(mode = ParameterMode.IN, type = Double.class, name = "y"),
                @StoredProcedureParameter(mode = ParameterMode.OUT, type = Double.class, name = "sum")
        }
)
*/
@Table(name = "wk_steps")
public class Steps {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int stepid;

    @Column(name = "ticketid", nullable = false)
    private int ticketid;

    @Column(name = "employeeid", nullable = false)
    private long employeeid;

    @Column(name = "description", nullable = false)
    private String description;

    @CreationTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "started", nullable = false)
    private Date started;

    @CreationTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "finished", nullable = true)
    private Date finished;

    public int getStepid() {
        return stepid;
    }

    public void setStepid(int stepid) {
        this.stepid = stepid;
    }

    public int getTicketid() {
        return ticketid;
    }

    public void setTicketid(int ticketid) {
        this.ticketid = ticketid;
    }

    public long getEmployeeid() {
        return employeeid;
    }

    public void setEmployeeid(long employeeid) {
        this.employeeid = employeeid;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getStarted() {
        return started;
    }

    public void setStarted(Date started) {
        this.started = started;
    }

    public Date getFinished() {
        return finished;
    }

    public void setFinished(Date finished) {
        this.finished = finished;
    }

    @Override
    public String toString() {
        return "wk_steps{" +
                "stepid=" + stepid +
                ", ticketid=" + ticketid +
                ", employeeid=" + employeeid +
                ", description='" + description + '\'' +
                ", started=" + started +
                ", finished=" + finished +
                '}';
    }

}
