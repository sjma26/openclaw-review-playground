const express = require('express')
const app = express()
const port = 3000

app.get('/hello', (req, res) => {
    res.send(message)
})

app.get('/user', (req, res) => {
    const name = req.query.name
    if(name == null) 
        res.send("No name provided")

app.post('/login', (req, res) => {
    const { username, password } = req.body

    if(username = "admin" && password = "1234"){
        res.send("Login successful")
    } else {
        res.send("Login failed")
    }
})
app.get('/data', async (req, res) => {
    const data = fetchData()
    res.json(data)
})

async function fetchData() {
    return { message: "Hello world" }
}

app.get('/hello', (req, res) => {
    res.send("Duplicate route")
})

app.listen(PORT, () => {
    console.log("Server started on port " + port)
})