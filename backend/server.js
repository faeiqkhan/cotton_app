const express = require("express");
const mongodb = require("mongodb");
const cors = require("cors");
const bodyParser = require("body-parser");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
require("dotenv").config();

const app = express();
const MongoClient = mongodb.MongoClient;
const url = "mongodb://127.0.0.1:27017"; // Local MongoDB URL
const dbName = "cotton_bales_app";
let db;

// Connect to MongoDB
MongoClient.connect(url, { useUnifiedTopology: true })
  .then((client) => {
    db = client.db(dbName);
    console.log("✅ MongoDB Connected");
  })
  .catch((err) => console.error("❌ MongoDB Connection Error:", err));

app.use(cors());
app.use(bodyParser.json());

// Register Route
app.post("/register", async (req, res) => {
  const { email, password, role } = req.body;

  if (!role || (role !== "buyer" && role !== "seller")) {
    return res.status(400).json({ message: "Invalid role selected" });
  }

  try {
    const existingUser = await db.collection("users").findOne({ email });
    if (existingUser) {
      return res.status(400).json({ message: "User already exists" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = { email, password: hashedPassword, role };
    await db.collection("users").insertOne(newUser);

    res.status(201).json({ message: "User registered successfully" });
  } catch (error) {
    res.status(500).json({ message: "Server error" });
  }
});

// Login Route
app.post("/login", async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await db.collection("users").findOne({ email });
    if (!user) {
      return res.status(400).json({ message: "User not found" });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ message: "Invalid password" });
    }

    const token = jwt.sign({ userId: user._id, role: user.role }, "your_jwt_secret", { expiresIn: "1h" });

    res.json({ token, role: user.role });
  } catch (error) {
    res.status(500).json({ message: "Server error" });
  }
});

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

// Start Server
const PORT = process.env.PORT || 5000;
app.listen(PORT, "0.0.0.0", () => console.log(`🚀 Server running on port ${PORT}`));
