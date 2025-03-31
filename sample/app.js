/**
 * Sample Express API for UAID demonstration
 */
const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const fs = require('fs');
const path = require('path');

// Initialize Express app
const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(morgan('dev'));

// In-memory data store (for demo purposes)
let users = [
  { id: 1, name: 'John Doe', email: 'john@example.com' },
  { id: 2, name: 'Jane Smith', email: 'jane@example.com' }
];

// Routes
app.get('/', (req, res) => {
  res.send('Welcome to the UAID Demo API');
});

// Get all users
app.get('/api/users', (req, res) => {
  res.json(users);
});

// Get user by ID
app.get('/api/users/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const user = users.find(u => u.id === id);
  
  if (!user) {
    return res.status(404).json({ error: 'User not found' });
  }
  
  res.json(user);
});

// Create a new user
app.post('/api/users', (req, res) => {
  const { name, email } = req.body;
  
  if (!name || !email) {
    return res.status(400).json({ error: 'Name and email are required' });
  }
  
  const newUser = {
    id: users.length + 1,
    name,
    email
  };
  
  users.push(newUser);
  res.status(201).json(newUser);
});

// Update a user
app.put('/api/users/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const { name, email } = req.body;
  
  const userIndex = users.findIndex(u => u.id === id);
  
  if (userIndex === -1) {
    return res.status(404).json({ error: 'User not found' });
  }
  
  users[userIndex] = {
    ...users[userIndex],
    name: name || users[userIndex].name,
    email: email || users[userIndex].email
  };
  
  res.json(users[userIndex]);
});

// Delete a user
app.delete('/api/users/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const userIndex = users.findIndex(u => u.id === id);
  
  if (userIndex === -1) {
    return res.status(404).json({ error: 'User not found' });
  }
  
  const deletedUser = users[userIndex];
  users = users.filter(u => u.id !== id);
  
  res.json(deletedUser);
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Something went wrong!' });
});

// Start the server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});

module.exports = app;
