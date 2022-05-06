package com.sparc.flidss.security.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

//import com.sparc.flidss.security.service.CustomAccessDeniedHandler;
import com.sparc.flidss.security.service.DssUserDetailsServiceImpl;

@SuppressWarnings("deprecation")
@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Bean
	public UserDetailsService userDetailsService() {
		return new DssUserDetailsServiceImpl();
	}

	/*
	 * @Bean public BCryptPasswordEncoder passwordEncoder() { return new
	 * BCryptPasswordEncoder(); }
	 */

	@Bean
	public DaoAuthenticationProvider authenticationProvider() {
		DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
		authProvider.setUserDetailsService(userDetailsService());
		authProvider.setPasswordEncoder(passwordEncoder());

		return authProvider;
	}

	/*
	 * @Bean public AccessDeniedHandler accessDeniedHandler() { return new
	 * CustomAccessDeniedHandler(); }
	 */

	@Bean
	public PasswordEncoder passwordEncoder() {
		return NoOpPasswordEncoder.getInstance();
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.authenticationProvider(authenticationProvider());

	}

//	public void getRoleBasedOnPermission() {
//		List<SetPermissionMaster> permission = setPermissionRepository.findAll();
//		System.out.println("Permission -> " + permission);
//		for(SetPermissionMaster s:permission) {
//			System.out.println(s.getPositionMaster().getChrvPositionNm());
//			String role = s.getPositionMaster().getChrvPositionNm();
//			roles.add(role);
//			pRole = (String[]) roles.toArray();
//	}
//		System.out.println(pRole); 
//	}

//	@Override
//	protected void configure(HttpSecurity http) throws Exception {
//
//		
//			
//			http.authorizeRequests()
//	.antMatchers("/GIS/dataCatalogue","/FLD/**","/DSS/**","/changepassword","/profilesettings")
//    .hasAnyAuthority(pRole)
//	.antMatchers("/**/**.css").permitAll()
//	.antMatchers("/**/**.js").permitAll()
//	.antMatchers("/UserMgmt/**").hasAnyAuthority("Administrator")
//	
//	.and().formLogin().loginPage("/login").usernameParameter("username").passwordParameter("password")
//	.successForwardUrl("/login_success_url").permitAll().failureForwardUrl("/login_failure_url").permitAll()
//	.and().logout().permitAll().and().exceptionHandling().accessDeniedPage("/access-denied")
//	.and().csrf().disable();
//		}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// System.out.println(Principal.class);
		http.authorizeRequests()
				.antMatchers("/GIS/**", "/FLD/**", "/DSS/**", "/changepassword", "/profilesettings", "/UserProject/**")
				.hasAnyAuthority("Administrator", "CDLTP Head", "DGPS Survey", "Lab Co-Ordinator", "JVC",
						"Progress Tracker", "Geo Consultant", "Geo Consultant", "CDLTP Head", "QC", "FITGC", "PCCF",
						"Scientist", "Verification Team", "Head", "Circle Div Co-Ordinator", "DGPS QC Asistan",
						"Tahasildar", "Division Level", "DFO", "ACF", "Range Level", "RO", "RI", "Forester",
						"Forest Guard", "ARI", "District  Level", "RCCF")

				.antMatchers("/flidss/**").permitAll().antMatchers("/UserMgmt/**").hasAnyAuthority("Administrator")
				.and().formLogin().loginPage("/login").usernameParameter("username").passwordParameter("password")
				.successForwardUrl("/login_success_url").permitAll().failureForwardUrl("/login_failure_url").permitAll()
				.and().logout().permitAll().and().exceptionHandling().accessDeniedPage("/access-denied")
				// .accessDeniedHandler(accessDeniedHandler())
				.and().csrf().disable();
	}

}
