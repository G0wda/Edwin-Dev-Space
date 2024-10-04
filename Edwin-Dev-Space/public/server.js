const express = require('express');
const http = require('http');
const WebSocket = require('ws');
const pty = require('node-pty');
const os = require('os');

const app = express();
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

// Serve frontend files (for example, an HTML page to render xterm.js)
app.use(express.static(__dirname + '/public'));

wss.on('connection', (ws) => {
  // Create a new terminal instance for each connection
  const shell = os.platform() === 'win32' ? 'powershell.exe' : 'bash';
  const ptyProcess = pty.spawn(shell, [], {
    name: 'xterm-color',
    cols: 80,
    rows: 30,
    cwd: process.env.HOME,
    env: process.env
  });

  // Send terminal output to the WebSocket client
  ptyProcess.on('data', (data) => {
    ws.send(data);
  });

  // Receive commands from the client and write to the terminal
  ws.on('message', (msg) => {
    ptyProcess.write(msg);
  });

  // Clean up when the WebSocket connection is closed
  ws.on('close', () => {
    ptyProcess.kill();
  });
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
