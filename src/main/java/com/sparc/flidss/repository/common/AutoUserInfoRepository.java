package com.sparc.flidss.repository.common;

import java.util.List;
import java.util.Optional;
import java.util.stream.Stream;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.sparc.flidss.model.common.AutoUserInfoMaster;
import com.sparc.flidss.model.common.UsersRole;
@Repository
public interface AutoUserInfoRepository extends JpaRepository<AutoUserInfoMaster, Integer> {
	
	@Query(value = "SELECT max(int_id) FROM auto_user_info_master", nativeQuery = true)
	Integer getMaxId();
	@Query(value ="SELECT * FROM auto_user_info_master where chrv_name is not null and chrv_name != '' and int_user_sts = 1 EXCEPT select u.* from auto_user_info_master u right join users_roles au on u.int_id=au.user_id order by chrv_name", nativeQuery=true)
	List<AutoUserInfoMaster> getAllActiveUsers();
	//@Query(value = "SELECT * FROM auto_user_info_master where chrv_user_id=:uId and int_user_sts=1", nativeQuery = true)
	Optional<AutoUserInfoMaster> findBychrvUserIdAndIntUserSts(String uId,Integer userSts);
	
	AutoUserInfoMaster findBychrvUserId(String uId);
	
	Optional<AutoUserInfoMaster> findBychrvNm(String chrvNm);
	List<AutoUserInfoMaster> findBychrvContactNo(String contactno);
	AutoUserInfoMaster findBychrvEmail(String email);
	boolean existsBychrvEmail(String email);
	// Boolean validatePassword(String chrvContactNo);
	@Query(value = "select * from auto_user_info_master where int_fk_position =:pos  and int_fk_division = :div", nativeQuery = true)
	List<AutoUserInfoMaster> findByDivAndPositin(Integer pos, Integer div);
	@Query(value = "select * from auto_user_info_master where int_fk_position =:pos", nativeQuery = true)
	List<AutoUserInfoMaster> findAllByPositin(Integer pos);
 
}
