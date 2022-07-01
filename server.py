from flask import Flask
from flask import render_template
from flask import Response, request, jsonify
app = Flask(__name__)

#Routes 
@app.route('/')
def homepage(): 
   return render_template('homepage.html')

@app.route('/resume', methods=['GET'])
def resume():
   return render_template('resume.html')

@app.route('/projects', methods=['GET'])
def projects():
   return render_template('projects.html')

# Might want to refine this later
# @app.route('/view/<id>', methods=['GET', 'POST'])
# def view(id = None):     
#     item = projects[id]
#     return render_template('view.html', projects=item)

if __name__ == '__main__':  
   app.run(debug = True)
