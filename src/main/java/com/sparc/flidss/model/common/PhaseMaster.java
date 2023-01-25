package com.sparc.flidss.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the phase_master database table.
 * 
 */
@Entity
@Table(name="phase_master")
@NamedQuery(name="PhaseMaster.findAll", query="SELECT p FROM PhaseMaster p")
public class PhaseMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	//@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="int_id")
	private Integer intId;

	@Column(name="int_phase")
	private Integer intPhase;

	//bi-directional many-to-one association to DivisionMaster
	/*
	 * @OneToMany(mappedBy="phaseMaster") private List<DivisionMaster>
	 * divisionMasters;
	 * 
	 * //bi-directional many-to-one association to NfbMaster
	 * 
	 * @OneToMany(mappedBy="phaseMaster") private List<NfbMaster> nfbMasters;
	 * 
	 * //bi-directional many-to-one association to RangeMaster
	 * 
	 * @OneToMany(mappedBy="phaseMaster") private List<RangeMaster> rangeMasters;
	 */

	public PhaseMaster() {
	}

	public Integer getIntId() {
		return this.intId;
	}

	public void setIntId(Integer intId) {
		this.intId = intId;
	}

	public Integer getIntPhase() {
		return this.intPhase;
	}

	public void setIntPhase(Integer intPhase) {
		this.intPhase = intPhase;
	}

	/*
	 * public List<DivisionMaster> getDivisionMasters() { return
	 * this.divisionMasters; }
	 * 
	 * public void setDivisionMasters(List<DivisionMaster> divisionMasters) {
	 * this.divisionMasters = divisionMasters; }
	 * 
	 * public DivisionMaster addDivisionMaster(DivisionMaster divisionMaster) {
	 * getDivisionMasters().add(divisionMaster);
	 * divisionMaster.setPhaseMaster(this);
	 * 
	 * return divisionMaster; }
	 * 
	 * public DivisionMaster removeDivisionMaster(DivisionMaster divisionMaster) {
	 * getDivisionMasters().remove(divisionMaster);
	 * divisionMaster.setPhaseMaster(null);
	 * 
	 * return divisionMaster; }
	 * 
	 * public List<NfbMaster> getNfbMasters() { return this.nfbMasters; }
	 * 
	 * public void setNfbMasters(List<NfbMaster> nfbMasters) { this.nfbMasters =
	 * nfbMasters; }
	 * 
	 * public NfbMaster addNfbMaster(NfbMaster nfbMaster) {
	 * getNfbMasters().add(nfbMaster); nfbMaster.setPhaseMaster(this);
	 * 
	 * return nfbMaster; }
	 * 
	 * public NfbMaster removeNfbMaster(NfbMaster nfbMaster) {
	 * getNfbMasters().remove(nfbMaster); nfbMaster.setPhaseMaster(null);
	 * 
	 * return nfbMaster; }
	 * 
	 * public List<RangeMaster> getRangeMasters() { return this.rangeMasters; }
	 * 
	 * public void setRangeMasters(List<RangeMaster> rangeMasters) {
	 * this.rangeMasters = rangeMasters; }
	 * 
	 * public RangeMaster addRangeMaster(RangeMaster rangeMaster) {
	 * getRangeMasters().add(rangeMaster); rangeMaster.setPhaseMaster(this);
	 * 
	 * return rangeMaster; }
	 * 
	 * public RangeMaster removeRangeMaster(RangeMaster rangeMaster) {
	 * getRangeMasters().remove(rangeMaster); rangeMaster.setPhaseMaster(null);
	 * 
	 * return rangeMaster; }
	 */

}