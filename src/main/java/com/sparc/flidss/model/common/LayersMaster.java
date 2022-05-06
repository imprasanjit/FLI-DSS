package com.sparc.flidss.model.common;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "layers_master")
public class LayersMaster {
	@Id
	private Integer id;
	private String name;
	@ManyToOne
	@JoinColumn(name = "fk_pid")
	private LayersMaster pid;
	private Integer seqno;
	private String desc;
	private String source;
	private String scale;
	private String layername;
//    @ManyToOne
//    @JoinColumn(name="divisionMaster")
//    private DivisionMaster divnMaster;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public LayersMaster getPid() {
		return pid;
	}

	public void setPid(LayersMaster pid) {
		this.pid = pid;
	}

	public Integer getSeqno() {
		return seqno;
	}

	public void setSeqno(Integer seqno) {
		this.seqno = seqno;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getScale() {
		return scale;
	}

	public void setScale(String scale) {
		this.scale = scale;
	}

	public String getLayername() {
		return layername;
	}

	public void setLayername(String layername) {
		this.layername = layername;
	}

}
