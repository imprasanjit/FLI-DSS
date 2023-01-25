package com.sparc.flidss.model.common;


import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the m_module database table.
 * 
 */
@Entity
@Table(name="module_master")
@NamedQuery(name="ModuleMaster.findAll", query="SELECT m FROM ModuleMaster m")
public class ModuleMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="module_id")
	private Integer moduleId;

	@Column(name="chrv_module_description")
	private String chrvModuleDescription;

	@Column(name="chrv_module_type")
	private String chrvModuleType;

	
	//bi-directional one-to-Many association to UserLogTable
		@OneToMany(mappedBy="moduleM")
		private List<UserLogTable> userLogsTable;

	public ModuleMaster() {
	}

	public Integer getModuleId() {
		return this.moduleId;
	}

	public void setModuleId(Integer moduleId) {
		this.moduleId = moduleId;
	}

	public String getChrvModuleDescription() {
		return this.chrvModuleDescription;
	}

	public void setChrvModuleDescription(String chrvModuleDescription) {
		this.chrvModuleDescription = chrvModuleDescription;
	}

	public String getChrvModuleType() {
		return this.chrvModuleType;
	}

	public void setChrvModuleType(String chrvModuleType) {
		this.chrvModuleType = chrvModuleType;
	}

	public List<UserLogTable> getUserLogs() {
		return userLogsTable;
	}

	public void setUserLogs(List<UserLogTable> userLogs) {
		this.userLogsTable = userLogs;
	}

	public UserLogTable addTUserLog(UserLogTable UserLogTable) {
		getUserLogs().add(UserLogTable);
		UserLogTable.setModuleM(this);

		return UserLogTable;
	}

	public UserLogTable removeTUserLog(UserLogTable UserLogTable) {
		getUserLogs().remove(UserLogTable);
		UserLogTable.setModuleM(null);

		return UserLogTable;
	}

}