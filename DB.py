from flask import Flask,render_template, request,  redirect, url_for, session
from flask import Flask,jsonify,json
from flask_mysqldb import MySQL
from datetime import datetime
import MySQLdb.cursors
import re

app = Flask(__name__)

app.secret_key = '011101'

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'sulomas'

mysql = MySQL(app)

@app.route("/testQR", methods = ['GET', 'POST'])
def QR():
    if 'loggedin' in session:
        id=session['id']
        username=session['username']
        cur = mysql.connection.cursor() 
        cur.execute("""SELECT username FROM accounts WHERE id = %s""", (id,))
        data = cur.fetchone()
        if data:
            if  request.method =='POST':
                qrcode_content = request.form['text']
                cursor = mysql.connection.cursor()
                cursor.execute("""INSERT INTO qr_scanner (ACC_ID,content) VALUES('%s','%s')""" % (id,qrcode_content))
                mysql.connection.commit()
                cursor.close()
                if  request.method =='POST':
                    now = datetime.now()
                    current_time = now.strftime('%Y-%m-%d %H:%M:%S')
                    key = request.form['text']
                    cursor = mysql.connection.cursor()
                    cursor.execute("""UPDATE bincollection SET Status = ('Collected'),DATETIME = %s WHERE BIN_CODE = %s AND ACC_ID = %s""", (current_time,key,id))
                    mysql.connection.commit()
                    cursor.close()
        return render_template('testqr.html')
    # User is not loggedin redirect to login page
    return redirect(url_for('login'))

@app.route("/camera")
def Cam():
    if 'loggedin' in session:
        # User is loggedin show them the home page
        return render_template('camera.html', username=session['username'])
    # User is not loggedin redirect to login page
    return redirect(url_for('login'))

@app.route("/adminlogin", methods=['GET', 'POST'])
def adminlogin():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
    # Create variables for easy access
        username = request.form['username']
        password = request.form['password']
        # Check if account exists using MySQL
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM admin WHERE Username = %s AND Password = md5(%s)', (username, password,))
        # Fetch one record and return result
        account = cursor.fetchone()
        # If account exists in accounts table in out database
        if account:
            # Create session data, we can access this data in other routes
            session['Loggedin'] = True
            session['ID'] = account['ID']
            session['Username'] = account['Username']
            # Redirect to home page
            return render_template('Dashboard.html')
        else:
            # Account doesnt exist or username/password incorrect
            msg = 'Incorrect username/password!'
    return render_template('adminlogin.html', msg=msg)

@app.route("/login", methods=['GET', 'POST'])
def login():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
    # Create variables for easy access
        username = request.form['username']
        password = request.form['password']
        # Check if account exists using MySQL
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM accounts WHERE username = %s AND password = md5(%s)', (username, password,))
        # Fetch one record and return result
        account = cursor.fetchone()
        # If account exists in accounts table in out database
        if account:
            # Create session data, we can access this data in other routes
            session['loggedin'] = True
            session['id'] = account['id']
            session['username'] = account['username']
            # Redirect to home page
            return render_template('TestQR.html')
        else:
            # Account doesnt exist or username/password incorrect
            msg = 'Incorrect username/password!'
    return render_template('login.html', msg=msg)

@app.route('/admin/login/logout')
def adminlogout():
    # Remove session data, this will log the user out
   session.pop('Loggedin', None)
   session.pop('ID', None)
   session.pop('Username', None)
   # Redirect to login page
   return redirect(url_for('adminlogin'))

@app.route('/login/logout')
def logout():
    # Remove session data, this will log the user out
   session.pop('loggedin', None)
   session.pop('id', None)
   session.pop('username', None)
   # Redirect to login page
   return redirect(url_for('login'))

@app.route("/register", methods=['GET', 'POST'])
def reg():
        # Output message if something goes wrong...
    msg = ''
    # Check if "username", "password" and "email" POST requests exist (user submitted form)
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form and 'email' in request.form:
        # Create variables for easy access
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']
        # Check if account exists using MySQL
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM admin WHERE Username = %s OR Email = %s', (username,email,))
        account = cursor.fetchone()
        # If account exists show error and validation checks
        if account:
            msg = 'Account already exists!'
        elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
            msg = 'Invalid email address!'
        elif not re.match(r'[A-Za-z0-9]+', username):
            msg = 'Username must contain only characters and numbers!'
        elif not username or not password or not email:
            msg = 'Please fill out the form!'
        else:
            # Account doesnt exists and the form data is valid, now insert new account into accounts table
            cursor.execute('INSERT INTO admin VALUES (NULL, %s, md5(%s), %s)', (username, password, email,))
            mysql.connection.commit()
            msg = 'You have successfully registered!'
    elif request.method == 'POST':
        # Form is empty... (no POST data)
        msg = 'Please fill out the form!'
    # Show registration form with message (if any)
    return render_template('register.html', msg=msg)   

@app.route("/forgot", methods=['GET', 'POST'])
def Forgot():
        # Output message if something goes wrong...
    msg = ''
    # Check if "username", "password" and "email" POST requests exist (user submitted form)
    if request.method == 'POST' and  'password' in request.form and 'email' in request.form:
        # Create variables for easy access
        password = request.form['password']
        email = request.form['email']
        # Check if account exists using MySQL
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM admin WHERE Email = %s', (email,))
        # Fetch one record and return result
        account = cursor.fetchone()
        # If account exists show error and validation checks
        if account:
            cursor.execute('SELECT * FROM admin WHERE Password = md5(%s) AND Email = %s', (password,email,))
            # Fetch one record and return result
            passwordreset = cursor.fetchone()
            if passwordreset:
                msg = 'Please Enter The New Password'
            else:
                sql = "UPDATE admin SET Password=md5(%s) WHERE Email=%s"
                data = (password,email,)
                cursor.execute(sql, data)
                mysql.connection.commit()
                msg = 'You have successfully reset your password!'
        else:
            msg = 'Please Enter The Correct Email'
    return render_template('forget_password.html',msg=msg)

@app.route("/ProfilePage", methods=['GET', 'POST'])
def profile():
    msg = ''
    if 'Loggedin' in session:
        id=session['ID']
        cur = mysql.connection.cursor() 
        cur.execute("""SELECT Email FROM admin WHERE ID = %s""", (id,))
        data = cur.fetchone()
        if data:
            # Check if "username", "password" and "email" POST requests exist (user submitted form)
            if request.method == 'POST' and  'username' in request.form and 'cpassword' in request.form: 
                # Create variables for easy access
                C_username = request.form['username']
                passwordreset = request.form['cpassword']
                # Check if account exists using MySQL
                cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
                cursor.execute('SELECT * FROM admin WHERE Username = %s', (C_username,))
                # Fetch one record and return result
                account = cursor.fetchone()
                # If account exists show error and validation checks
                if account:
                    msg= 'Username exist!'
                else:
                    sql = "UPDATE admin SET Username=%s,Password = md5(%s) WHERE ID=%s"
                    datareset = (C_username,passwordreset,id,)
                    cursor.execute(sql, datareset)
                    session['Username'] = C_username
                    mysql.connection.commit()
                    msg = 'You have successfully update your profile!'
        # User is loggedin show them the ProfilePage page
        return render_template('profilepage.html', username=session['Username'],data=data,msg=msg)
    # User is not loggedin redirect to login page
    return redirect(url_for('adminlogin'))    

@app.route("/dashboard")
def dashboard():
        # Check if user is loggedin
    if 'Loggedin' in session:
        # User is loggedin show them the home page
        return render_template('dashboard.html', username=session['Username'])
    # User is not loggedin redirect to login page
    return redirect(url_for('adminlogin'))

@app.route("/customers")
def cus():
        # Check if user is loggedin
    if 'Loggedin' in session:
        # User is loggedin show them the home page
        return render_template('customer.html', username=session['Username'])
    # User is not loggedin redirect to login page
    return redirect(url_for('adminlogin'))


@app.route("/customersview")
def customersview():
    if 'Loggedin' in session:
        id=session['ID']
        username=session['Username']
        cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor) 
        cur.execute("""SELECT * FROM accounts""")
        data = cur.fetchall()
        history = []
        content = {}
        for result in data:
            content = {'id': result['id'],'username': result['username'],'email': result['email'],'phone_no': result['phone_no']}
            history.append(content)
            content={}
        # User is loggedin show them the home page
        return jsonify(clients = history)
    # User is not loggedin redirect to login page
    return redirect(url_for('adminlogin'))

@app.route("/scanlisthistory")
def scanlist():
    if 'Loggedin' in session:
        id=session['ID']
        username=session['Username']
        cur = mysql.connection.cursor() 
        cur.execute("""SELECT content FROM qr_scanner""")
        data = cur.fetchall()
        # User is loggedin show them the home page
        return render_template('scanlist.html',data = data,username = username)
    # User is not loggedin redirect to login page
    return redirect(url_for('adminlogin'))

@app.route("/scanlist")
def list():
    if 'Loggedin' in session:
        id=session['ID']
        username=session['Username']
        cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor) 
        cur.execute("""SELECT * FROM accounts RIGHT JOIN qr_scanner ON accounts.id = qr_scanner.ACC_ID""")
        data = cur.fetchall()
        history = []
        content = {}
        for result in data:
            content = {'ID': result['ID'],'ACC_ID': result['ACC_ID'],'username': result['username'],'content': result['content'],'DateTime': result['DateTime']}
            history.append(content)
            content={}
        # User is loggedin show them the home page
        return jsonify(Scanlist = history)
    # User is not loggedin redirect to login page
    return redirect(url_for('adminlogin'))

@app.route("/bin")
def bin():
        # Check if user is loggedin
    if 'Loggedin' in session:
        # User is loggedin show them the home page
        return render_template('bincollection.html', username=session['Username'])
    # User is not loggedin redirect to login page
    return redirect(url_for('adminlogin'))
    
@app.route("/BinCollection")
def JsBinCollection():
    if 'Loggedin' in session:
        id=session['ID']
        username=session['Username']
        cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor) 
        cur.execute("""SELECT * FROM accounts RIGHT JOIN bincollection ON accounts.id = bincollection.ACC_ID""")
        data = cur.fetchall()
        history = []
        content = {}
        for result in data:
            content = {'username': result['username'],'BIN_CODE': result['BIN_CODE'],'Address': result['Address'],'Status': result['Status'],'DATE/TIME': result['DATETIME'],'Latitude': result['Latitude'],'Longtitude': result['Longtitude']}
            history.append(content)
            content={}
        # User is loggedin show them the home page
        return jsonify(Collect = history)
    # User is not loggedin redirect to login page
    return redirect(url_for('adminlogin'))

@app.route("/RegisOperator", methods=['GET', 'POST'])
def Operator():
    # Output message if something goes wrong...
    msg = ''
    if 'Loggedin' in session:
        if request.method == 'POST' and 'username' in request.form and 'cpassword' in request.form and 'email' in request.form and 'phone_num' in request.form:
            # Create variables for easy access
            username = request.form['username']
            password = request.form['cpassword']
            email = request.form['email']
            phone_num = request.form['phone_num']
            # Check if account exists using MySQL
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute('SELECT * FROM accounts WHERE username = %s OR email = %s', (username,email,))
            account = cursor.fetchone()
            # If account exists show error and validation checks
            if account:
                msg = 'Account already exists!'
            elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
                msg = 'Invalid email address!'
            elif not re.match(r'[A-Za-z0-9]+', username):
                msg = 'Username must contain only characters and numbers!'
            elif not username or not password or not email:
                msg = 'Please fill out the form!'
            else:
                # Account doesnt exists and the form data is valid, now insert new account into accounts table
                cursor.execute('INSERT INTO accounts VALUES (NULL, %s, md5(%s), %s, %s)', (username, password, email,phone_num,))
                mysql.connection.commit()
                msg = 'You have successfully registered!'
        # elif request.method == 'POST':
        #     # Form is empty... (no POST data)
        #     msg = 'Please fill out the form!'
        elif request.method == 'POST' and 'Bincode' in request.form and 'address' in request.form and 'lat' in request.form and 'longit' in request.form and 'description' in request.form:
            # Create variables for easy access
            Bincode = request.form['Bincode']
            address = request.form['address']
            description = request.form['description']
            lat = request.form['lat']
            longit = request.form['longit']
            # Check if account exists using MySQL
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute('SELECT * FROM bincollection WHERE BIN_CODE = %s', (Bincode,))
            matchbincode = cursor.fetchone()
            if matchbincode:
                sql = "UPDATE bincollection SET ACC_ID = 0,Address=%s,Description=%s,Latitude=%s,Longtitude=%s,DATETIME='0000-00-00 00:00:00',Status='Not Collected' WHERE BIN_CODE=%s"
                data = (address,description,lat,longit,Bincode,)
                cursor.execute(sql, data)
                mysql.connection.commit()
            else:
                cursor.execute('INSERT INTO bincollection VALUES (NULL, 0, %s, %s, %s, %s, %s,"0000-00-00 00:00:00","Not Collected")', ( Bincode, address, lat, longit, description,))
                mysql.connection.commit()
                # binmsg = 'You have successfully applied!'
        # Show registration form with message (if any)
        return render_template('regisoperator.html', msg=msg)
    # User is not loggedin redirect to login page
    return redirect(url_for('adminlogin'))

@app.route("/Operator")
def KpiOperator():
    if 'Loggedin' in session:
    # User is loggedin show them the home page
        return render_template('kpioperator.html')
    # User is not loggedin redirect to login page
    return redirect(url_for('adminlogin'))

@app.route("/taskschedule")
def taskschedule():
    if 'Loggedin' in session:
        id=session['ID']
        username=session['Username']
        cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor) 
        cur.execute("""SELECT * FROM dailytask""")
        data = cur.fetchall()
        history = []
        content = {}
        for result in data:
            content = {'ID': result['ID'],'username': result['username'],'BIN_CODE': result['BIN_CODE'],'Datetime': result['Datetime']}
            history.append(content)
            content={}
        # User is loggedin show them the home page
        return jsonify(schedule = history)
    # User is not loggedin redirect to login page
    return redirect(url_for('adminlogin'))

@app.route("/TaskSchedule", methods=['GET', 'POST'])
def DailyTask():
    if 'Loggedin' in session:
        cursor = mysql.connection.cursor() 
        cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        result = cur.execute('SELECT * FROM accounts ORDER BY id')
        name = cur.fetchall()
        if name:
            cursor = mysql.connection.cursor()
            cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            result = cur.execute("SELECT * FROM bincollection ORDER BY ID")
            data = cur.fetchall()   
        return render_template('taskplanning.html',name = name, data = data)
    # User is not loggedin redirect to login page
    return redirect(url_for('adminlogin'))

@app.route("/DailyTask", methods=['GET', 'POST'])
def Task():
    if 'Loggedin' in session:
        if request.method == 'POST':
            name = request.form['username']
            date = request.form['date']
            cursor = mysql.connection.cursor()
            cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            for getid in request.form.getlist('mycheckbox'):
                cursor.execute('SELECT BIN_CODE FROM bincollection WHERE ID = {0}'.format(getid))
                matchbincode = cursor.fetchone()
                if matchbincode:
                    cursor.execute('SELECT * FROM dailytask WHERE BIN_CODE = %s', (matchbincode,))
                    matcode = cursor.fetchone()
                    if matcode:
                        sql = "UPDATE dailytask SET username = %s,Datetime=%s WHERE BIN_CODE=%s"
                        data = (name,date,matchbincode,)
                        cursor.execute(sql, data)
                        mysql.connection.commit()
                    else:
                        cursor.execute('INSERT INTO dailytask VALUES (NULL, %s, %s, %s)', ( name, matchbincode, date,))
                        mysql.connection.commit()
                cur.execute('SELECT * FROM accounts WHERE username = %s', (name,))
                ppl = cur.fetchone()
                if ppl:
                    sql = "UPDATE bincollection SET ACC_ID=%s,DATETIME='0000-00-00 00:00:00',Status='Not Collected' WHERE BIN_CODE=%s"
                    sop = (ppl['id'],matchbincode,)
                    cursor.execute(sql, sop)
                    mysql.connection.commit()
            return redirect(url_for('DailyTask'))   
    # User is not loggedin redirect to login page
    return redirect(url_for('adminlogin'))

@app.route("/Test")
def Test():
    return render_template('test.html')
