/*******************************************************************************
 *  Author : Group BBHC
 *  License : AGPL v3
 ******************************************************************************/
package mypub

class Comment {

	String username
	Date postDate = new Date()
	String text
	static belongsTo = [pub : Pub]

	String toString () {
		if (text.length()>30){
			return username +
			' : ' + text.substring(0, 30)
		}
		else {
			return username +
			' : ' + text
		}
	}


	static constraints = {  text size: 1..160 }
}