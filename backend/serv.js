const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const { MongoClient } = require('mongodb');

const app = express();
app.use(cors());
app.use(bodyParser.json());

const mongoURL = 'mongodb://localhost:27017';
const dbName = 'cottonApp';

let db;
MongoClient.connect(mongoURL, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(client => {
    db = client.db(dbName);
    console.log('Connected to MongoDB');
  })
  .catch(error => console.error(error));

app.post('/add-listing', async (req, res) => {
  const { variety, weight, price, sellerEmail } = req.body;

  if (!variety || !weight || !price || !sellerEmail) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  try {
    const result = await db.collection('listings').insertOne({ variety, weight, price, sellerEmail });
    res.status(201).json({ message: 'Listing added successfully', listingId: result.insertedId });
  } catch (error) {
    res.status(500).json({ message: 'Database error', error });
  }
});

app.get('/listings', async (req, res) => {
  try {
    const listings = await db.collection('listings').find().toArray();
    res.status(200).json(listings);
  } catch (error) {
    res.status(500).json({ message: 'Database error', error });
  }
});

app.listen(5000, () => console.log('Server running on port 5000'));
