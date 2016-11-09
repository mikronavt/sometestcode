import webapp2

form="""
<form method="post">
	What is your birthday, motherfucker?
	<br>
	
	<label> Month
		<input type="text" name="month">
	</label>
	
	<label> Day
		<input type="text" name="day">
	</label>
	
	<label> Year
		<input type="text" name="year">
	</label>
	
	<br>
	<br>
	<input type="submit">
</form>
"""

class MainPage(webapp2.RequestHandler):
    def get(self):
		self.response.write(form)
		
	
	def post(self):
		self.redirect("/thanks")

class ThanksHandler(webapp2.RequestHandler):
	def get(self):
		self.response.write("Blalala")


app = webapp2.WSGIApplication([
    ('/', MainPage), ('/thanks', ThanksHandler)
], debug=True)