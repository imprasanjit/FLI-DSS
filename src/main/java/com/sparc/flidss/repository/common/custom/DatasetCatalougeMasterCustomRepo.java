package com.sparc.flidss.repository.common.custom;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.sparc.flidss.utility.DivisionCountDTO;

@Repository
public class DatasetCatalougeMasterCustomRepo {
	@PersistenceContext
	private EntityManager entityManager;

	@SuppressWarnings("unchecked")
	public List<DivisionCountDTO> getDivisionCountPerDataSet(@Param("ids") Set<Integer> ids) 
	{
		// Query queryy = entityManager.createNativeQuery("select dv.int_id AS
		// id,dv.chrv_division_nm AS division,count(dv.int_id) AS count from
		// public.data_catalogue_master dc join public.division_master dv on
		// dc.int_fk_division=dv.int_id and dc.int_fk_dataset IN(?1) group by
		// dv.int_id,dv.chrv_division_nm",DivisionCountDTO.class);
		Query queryy = entityManager.createNativeQuery(
				"select dv.int_id AS id,dv.chrv_division_nm AS division,count(dc.int_fk_division) AS count from public.division_master dv  \r\n"
						+ "left join public.data_catalogue_master dc on dv.int_id=dc.int_fk_division and dc.int_fk_dataset IN(?1) group by dv.int_id,dv.chrv_division_nm\r\n"
						+ "order by count(dc.int_fk_division) desc,dv.chrv_division_nm",
				DivisionCountDTO.class);
		List<DivisionCountDTO> resultList = new ArrayList<DivisionCountDTO>();
		resultList = queryy.setParameter(1, ids).getResultList();
		return resultList;

	}

}
