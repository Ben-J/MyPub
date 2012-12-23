/*******************************************************************************
 * Author : Group BBHC
 * Licence : AGPL v3
 ******************************************************************************/
package mypub

class User {

	transient springSecurityService

	String username
	String password
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired
	
	String firstName, lastName, mail, sexe
	Date ddn
	Picture avatar
	
	static hasMany = [friends : User, pictures : Picture, pubs : Pub]

	String toString() {return 'User : ' + firstName + ' ' + lastName							
							}
	
	
	static constraints = {
		username blank: false, unique: true
		password blank: false
		
		firstName blank: false
		lastName blank: false
		mail blank: false, email: true
		avatar nullable:true
		ddn  nullable: true, blank: false, max: new Date().minus(3650)
		sexe  nullable: true, inList: ['M','F']
		
		friends nullable:true
		pictures nullable:true
		pubs nullable:true
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}
}
