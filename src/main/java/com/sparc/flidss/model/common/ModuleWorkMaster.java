package com.sparc.flidss.model.common;



import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the m_module_work database table.
 * 
 */
@Entity
@Table(name="module_work_master")
@NamedQuery(name="ModuleWorkMaster.findAll", query="SELECT m FROM ModuleWorkMaster m")
public class ModuleWorkMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="module_work_id")
	private Integer moduleWorkId;

	@Column(name="chrv_module_work_description")
	private String chrvModuleWorkDescription;

	@Column(name="chrv_module_work_type")
	private String chrvModuleWorkType;

	//bi-directional one-to-Many association to UserLogTable
	@OneToMany(mappedBy="moduleWorkM")
	private List<UserLogTable> userLogsTable;

	public ModuleWorkMaster() {
	}

	public Integer getModuleWorkId() {
		return this.moduleWorkId;
	}

	public void setModuleWorkId(Integer moduleWorkId) {
		this.moduleWorkId = moduleWorkId;
	}

	public String getChrvModuleWorkDescription() {
		return this.chrvModuleWorkDescription;
	}

	public void setChrvModuleWorkDescription(String chrvModuleWorkDescription) {
		this.chrvModuleWorkDescription = chrvModuleWorkDescription;
	}

	public String getChrvModuleWorkType() {
		return this.chrvModuleWorkType;
	}

	public void setChrvModuleWorkType(String chrvModuleWorkType) {
		this.chrvModuleWorkType = chrvModuleWorkType;
	}

	

	public List<UserLogTable> getUserLogsTable() {
		return userLogsTable;
	}

	public void setUserLogsTable(List<UserLogTable> userLogsTable) {
		this.userLogsTable = userLogsTable;
	}

	public UserLogTable addUserLogT(UserLogTable userLogTable) {
		getUserLogsTable().add(userLogTable);
		userLogTable.setModuleWorkM(this);

		return userLogTable;
	}

	public UserLogTable removeUserLogT(UserLogTable userLogTable) {
		getUserLogsTable().remove(userLogTable);
		userLogTable.setModuleWorkM(null);

		return userLogTable;
	}

}
