package com.sparc.flidss.viewmodel;


public class UvwNfbDetails {

	Integer IntId;
	String NfbName;
	String NfbType;
	Double NareaSkqm;
	Double NareaHa;
	String NotfNo;
	String NotfDt;
	String NotfCopy;
	Double DgpsfHa;
	Double DgpsdHa;
	Double JvHa;
	String JvRpt;
	Double CmvHa;
	Double MmvHa;
	Integer IntFkPhase;
	Integer IntFkCircle;
	String chrvCircle;
	Integer IntFkDivision;
	String chrvDivisionNm;
	String ChrvFkRangeCd;
	String chrvRangeNm;
	Integer intFkDistrict;
	String district;

	
	public UvwNfbDetails() {
		super();
		// TODO Auto-generated constructor stub
	}


	public UvwNfbDetails(Integer intId, String nfbName, String nfbType, Double nareaSkqm, Double nareaHa, String notfNo,
			String notfDt, String notfCopy, Double dgpsfHa, Double dgpsdHa, Double jvHa, String jvRpt, Double cmvHa,
			Double mmvHa, Integer intFkPhase, Integer intFkCircle, String chrvCircle, Integer intFkDivision,
			String chrvDivisionNm, String chrvFkRangeCd, String chrvRangeNm, Integer intFkDistrict,String district) {
		super();
		IntId = intId;
		NfbName = nfbName;
		NfbType = nfbType;
		NareaSkqm = nareaSkqm;
		NareaHa = nareaHa;
		NotfNo = notfNo;
		NotfDt = notfDt;
		NotfCopy = notfCopy;
		DgpsfHa = dgpsfHa;
		DgpsdHa = dgpsdHa;
		JvHa = jvHa;
		JvRpt = jvRpt;
		CmvHa = cmvHa;
		MmvHa = mmvHa;
		IntFkPhase = intFkPhase;
		IntFkCircle = intFkCircle;
		this.chrvCircle = chrvCircle;
		IntFkDivision = intFkDivision;
		this.chrvDivisionNm = chrvDivisionNm;
		ChrvFkRangeCd = chrvFkRangeCd;
		this.chrvRangeNm = chrvRangeNm;
		this.intFkDistrict=intFkDistrict;
		this.district=district;
	}


	public Integer getIntId() {
		return IntId;
	}


	public void setIntId(Integer intId) {
		IntId = intId;
	}


	public String getNfbName() {
		return NfbName;
	}


	public void setNfbName(String nfbName) {
		NfbName = nfbName;
	}


	public String getNfbType() {
		return NfbType;
	}


	public void setNfbType(String nfbType) {
		NfbType = nfbType;
	}


	public Double getNareaSkqm() {
		return NareaSkqm;
	}


	public void setNareaSkqm(Double nareaSkqm) {
		NareaSkqm = nareaSkqm;
	}


	public Double getNareaHa() {
		return NareaHa;
	}


	public void setNareaHa(Double nareaHa) {
		NareaHa = nareaHa;
	}


	public String getNotfNo() {
		return NotfNo;
	}


	public void setNotfNo(String notfNo) {
		NotfNo = notfNo;
	}


	public String getNotfDt() {
		return NotfDt;
	}


	public void setNotfDt(String notfDt) {
		NotfDt = notfDt;
	}


	public String getNotfCopy() {
		return NotfCopy;
	}


	public void setNotfCopy(String notfCopy) {
		NotfCopy = notfCopy;
	}


	public Double getDgpsfHa() {
		return DgpsfHa;
	}


	public void setDgpsfHa(Double dgpsfHa) {
		DgpsfHa = dgpsfHa;
	}


	public Double getDgpsdHa() {
		return DgpsdHa;
	}


	public void setDgpsdHa(Double dgpsdHa) {
		DgpsdHa = dgpsdHa;
	}


	public Double getJvHa() {
		return JvHa;
	}


	public void setJvHa(Double jvHa) {
		JvHa = jvHa;
	}


	public String getJvRpt() {
		return JvRpt;
	}


	public void setJvRpt(String jvRpt) {
		JvRpt = jvRpt;
	}


	public Double getCmvHa() {
		return CmvHa;
	}


	public void setCmvHa(Double cmvHa) {
		CmvHa = cmvHa;
	}


	public Double getMmvHa() {
		return MmvHa;
	}


	public void setMmvHa(Double mmvHa) {
		MmvHa = mmvHa;
	}


	public Integer getIntFkPhase() {
		return IntFkPhase;
	}


	public void setIntFkPhase(Integer intFkPhase) {
		IntFkPhase = intFkPhase;
	}


	public Integer getIntFkCircle() {
		return IntFkCircle;
	}


	public void setIntFkCircle(Integer intFkCircle) {
		IntFkCircle = intFkCircle;
	}


	public String getChrvCircle() {
		return chrvCircle;
	}


	public void setChrvCircle(String chrvCircle) {
		this.chrvCircle = chrvCircle;
	}


	public Integer getIntFkDivision() {
		return IntFkDivision;
	}


	public void setIntFkDivision(Integer intFkDivision) {
		IntFkDivision = intFkDivision;
	}


	public String getChrvDivisionNm() {
		return chrvDivisionNm;
	}


	public void setChrvDivision_nm(String chrvDivisionNm) {
		this.chrvDivisionNm = chrvDivisionNm;
	}


	public String getChrvFkRangeCd() {
		return ChrvFkRangeCd;
	}


	public void setChrvFkRangeCd(String chrvFkRangeCd) {
		ChrvFkRangeCd = chrvFkRangeCd;
	}


	public String getChrvRangeNm() {
		return chrvRangeNm;
	}


	public void setChrvRange_nm(String chrvRangeNm) {
		this.chrvRangeNm = chrvRangeNm;
	}


	public Integer getIntFkDistrict() {
		return intFkDistrict;
	}


	public void setIntFkDistrict(Integer intFkDistrict) {
		this.intFkDistrict = intFkDistrict;
	}


	public String getDistrict() {
		return district;
	}


	public void setDistrict(String district) {
		this.district = district;
	}


	public void setChrvDivisionNm(String chrvDivisionNm) {
		this.chrvDivisionNm = chrvDivisionNm;
	}


	public void setChrvRangeNm(String chrvRangeNm) {
		this.chrvRangeNm = chrvRangeNm;
	}
	
	
}
