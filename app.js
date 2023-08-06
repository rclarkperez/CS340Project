// App.js

/*
    SETUP
*/
var express = require('express');   // We are using the express library for the web server
var app     = express();            // We need to instantiate an express object to interact with the server in our code
PORT        = 9124;                 // Set a port number at the top so it's easy to change in the future

// app.js
const { engine } = require('express-handlebars');
var exphbs = require('express-handlebars');     // Import express-handlebars
app.engine('.hbs', engine({extname: ".hbs"}));  // Create an instance of the handlebars engine to process templates
app.set('view engine', '.hbs');                 // Tell express to use the handlebars engine whenever it encounters a *.hbs file.

// Database
var db = require('./database/db-connector')

// app.js - SETUP section
app.use(express.json())
app.use(express.urlencoded({extended: true}))
app.use(express.static(__dirname + '/public'));         // this is needed to allow for the form to use the ccs style sheet/javscript
    

// app.js
app.get('/', function(req, res)
    {
        let query1 = "SELECT * FROM EmergencyPhysicians;";
        db.pool.query(query1, function(error, rows, fields){
            res.render('index', {data: rows});
        })
    });

app.get('/', function(req, res)
{
    // Declare Query 1
    let query1;

    // If there is no query string, we just perform a basic SELECT
    if (req.query.name === undefined)
    {
        query1 = "SELECT * FROM EmergencyPhysicians ";
    }

    // If there is a query string, we assume this is a search, and return desired results
    else
    {
        query1 = `SELECT * FROM EmergencyPhysicians WHERE name LIKE "${req.query.name}%"`
    }

    // Query 2 is the same in both cases
    let query2 = "SELECT * FROM EmergencyPhysicians;";

    // Run the 1st query
    db.pool.query(query1, function(error, rows, fields){
        
        // Save the emPhys
        let emPhys = rows;
        
        // Run the second query
        db.pool.query(query2, (error, rows, fields) => {
            
            // Save the emPhyss
            let emPhyss = rows;

            // BEGINNING OF NEW CODE

            // Construct an object for reference in the table
            // Array.map is awesome for doing something with each
            // element of an array.
            let emPhysmap = {}
            emPhyss.map(emPhys => {
                let id = parseInt(emPhys.id, 10);

                emPhysmap[id] = emPhys["name"];
            })

            // Overwrite the certification ID with the name of the emPhys in the emPhys object
            emPhys = emPhys.map(emPhys => {
                return Object.assign(emPhys, {certification: emPhysmap[emPhys.certification]})
            })

            // END OF NEW CODE
            return res.render('index', {data: emPhys, emPhyss: emPhyss});
        })
    })
});


app.post('/add-emPhys-form', function(req, res){
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Capture NULL values
    let certification = parseInt(data['input-certification']);
    if (isNaN(certification))
    {
        certification = 'NULL'
    }

    let age = parseInt(data['input-age']);
    if (isNaN(age))
    {
        age = 'NULL'
    }

    // Create the query and run it on the database
    query1 = `INSERT INTO EmergencyPhysicians (name, certification) VALUES ('${data['input-name']}', ${certification})`;
    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM EmergencyPhysicians and
        // presents it on the screen
        else
        {
            res.redirect('/');
        }
    })
});

app.post('/add-emPhys-ajax', function(req, res) 
{
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Capture NULL values
    let certification = parseInt(data.certification);
    if (isNaN(certification))
    {
        certification = 'NULL'
    }

    let age = parseInt(data.age);
    if (isNaN(age))
    {
        age = 'NULL'
    }

    // Create the query and run it on the database
    query1 = `INSERT INTO EmergencyPhysicians (name, certification) VALUES ('${data.name}', ${certification})`;
    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }
        else
        {
//             // If there was no error, perform a SELECT * on EmergencyPhysicians //             query2 = `SELECT EmergencyPhysicians.id, EmergencyPhysicians.name, EmergencyPhysicians.certification, bsg_planets.name 
// FROM EmergencyPhysicians 
// LEFT JOIN bsg_planets ON EmergencyPhysicians certification = bsg_planets.id;`;
//             db.pool.query(query2, function(error, rows, fields){

//                 // If there was an error on the second query, send a 400
//                 if (error) {
                    
                    // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
                    console.log(error);
                    res.sendStatus(400);
                }
                // If all went well, send the results of the query back.
                // else
                // {
                //     res.send(rows);
                // }
            res.send(rows);

            })
});

app.delete('/delete-emPhys-ajax/', function(req,res,next){
  let data = req.body;
  let emPhysID = parseInt(data.id);
//   let deleteBsg_Cert_EmPhys = `DELETE FROM bsg_cert_emPhys WHERE pid = ?`;
  let deleteEmergencyPhysicians= `DELETE FROM EmergencyPhysicians WHERE id = ?`;


        // Run the 1st query
        db.pool.query(deleteBsg_Cert_EmPhys, [emPhysID], function(error, rows, fields){
            if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error);
            res.sendStatus(400);
            }

            else
            {
                // Run the second query
                db.pool.query(deleteEmergencyPhysicians  [emPhysID], function(error, rows, fields) {

                    if (error) {
                        console.log(error);
                        res.sendStatus(400);
                    } else {
                        res.sendStatus(204);
                    }
                })
            }
})});

app.put('/put-emPhys-ajax', function(req,res,next){                                   
  let data = req.body;

  let certification = parseInt(data.certification);
  let emPhys = parseInt(data.name);

  queryUpdateCertification = `UPDATE EmergencyPhysicians SET certification = ? WHERE EmergencyPhysicians.id = ?`;
//   selectCertification = `SELECT * FROM bsg_planets WHERE id = ?`

        // Run the 1st query
        db.pool.query(queryUpdateCertification, [certification, emPhys], function(error, rows, fields){
            if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error);
            res.sendStatus(400);
            }

            // If there was no error, we run our second query and return that data so we can use it to update the emPhys's
            // table on the front-end
            else
            {
                // // Run the second query
                // db.pool.query(selectCertification, [certification], function(error, rows, fields) {
        
                //     if (error) {
                //         console.log(error);
                //         res.sendStatus(400);
                //     } else {
                        res.send(rows);
                    // }
                // })
            }
})});



/*
    LISTENER
*/
app.listen(PORT, function(){            // This is the basic syntax for what is called the 'listener' which receives incoming requests on the specified PORT.
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});