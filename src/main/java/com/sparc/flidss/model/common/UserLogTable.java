package com.sparc.flidss.model.common;



import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the t_user_log database table.
 * 
 */
@Entity
@Table(name="user_log_table")
@NamedQuery(name="UserLogTable.findAll", query="SELECT t FROM UserLogTable t")
public class UserLogTable implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="int_slno")
	private Integer intSlno;

	@Column(name="chrv_ip_address")
	private String chrvIpAddress;

	@Column(name="chrv_user_id")
	private String chrvUserId;

	@Column(name="int_log_status")
	private Integer intLogStatus;

	@Column(name="tms_log_date")
	private Timestamp tmsLogDate;

	//bi-directional many-to-one association to MModule
	
	  @ManyToOne 
	  @JoinColumn(name="fk_int_module_id")
	  private ModuleMaster moduleM;
	 

	//bi-directional many-to-one association to MModuleWork
	
	  @ManyToOne
	  
	  @JoinColumn(name="fk_int_module_work_id") 
	  private ModuleWorkMaster moduleWorkM;
	 
	public UserLogTable() {
	}

	

	public Integer getIntSlno() {
		return this.intSlno;
	}

	public void setIntSlno(Integer intSlno) {
		this.intSlno = intSlno;
	}

	public String getChrvIpAddress() {
		return this.chrvIpAddress;
	}

	public void setChrvIpAddress(String chrvIpAddress) {
		this.chrvIpAddress = chrvIpAddress;
	}

	public String getChrvUserId() {
		return this.chrvUserId;
	}

	public void setChrvUserId(String chrvUserId) {
		this.chrvUserId = chrvUserId;
	}

	public Integer getIntLogStatus() {
		return this.intLogStatus;
	}

	public void setIntLogStatus(Integer intLogStatus) {
		this.intLogStatus = intLogStatus;
	}

	public Timestamp getTmsLogDate() {
		return this.tmsLogDate;
	}

	public void setTmsLogDate(Timestamp tmsLogDate) {
		this.tmsLogDate = tmsLogDate;
	}

	public ModuleMaster getModuleM() {
		return moduleM;
	}

	public void setModuleM(ModuleMaster moduleM) {
		this.moduleM = moduleM;
	}

	public ModuleWorkMaster getModuleWorkM() {
		return moduleWorkM;
	}

	public void setModuleWorkM(ModuleWorkMaster moduleWorkM) {
		this.moduleWorkM = moduleWorkM;
	}

}

