class SerialMonitor {
  PApplet pa;
  int id;

  JComboBox serialListBox;
  JComboBox baudRateBox;
  
  JLabel captionText;
  JTextArea logText;
  JTextField sendText;
  
  JButton connectButton;
  JButton sendButton;

  Serial serialPort;
  String msg;

  int offsetX, offsetY;

  SerialMonitor(PApplet _pa, int _x, int _y) {
    pa = _pa;
    offsetX = _x;
    offsetY = _y;
  }

  void setId(int _id) {
    id = _id;
  }

  void init(JPanel _panel, GuiListener _listener) {
    captionText = new JLabel("Monitor" + id); 
    captionText.setForeground(Color.red); 
    captionText.setBounds(
      offsetX,
      MARGIN_Y,
      500,
      LINE_HEIGHT);

    //serialListBox = new JComboBox(serialList); 
    serialListBox = new JComboBox(); 
    serialListBox.addActionListener(_listener);
    serialListBox.setBounds(
      offsetX, 
      captionText.getY() + captionText.getHeight() + GAP_H, 
      350, 
      LINE_HEIGHT);

    baudRateBox = new JComboBox(BAUD_LIST); 
    baudRateBox.setBounds(
      serialListBox.getX() + serialListBox.getWidth(), 
      captionText.getY() + captionText.getHeight() + GAP_H, 
      100, 
      LINE_HEIGHT);

    connectButton = new JButton(BUTTON_LABEL_CONNECT);
    connectButton.addActionListener(_listener);
    connectButton.setBounds(
      baudRateBox.getX() + baudRateBox.getWidth(), 
      captionText.getY() + captionText.getHeight() + GAP_H, 
      90, 
      LINE_HEIGHT);

    {
      JLabel l = new JLabel("Recv"); 
      l.setForeground(Color.red); 
      l.setBounds(
        offsetX, 
        serialListBox.getY() + serialListBox.getHeight() + GAP_H, 
        500, 
        LINE_HEIGHT);
      
      _panel.add(l);
    }

    logText = new JTextArea();
    logText.setLineWrap(true);
    logText.setPreferredSize(new Dimension(450, 400));
    logText.setBounds(
        offsetX, 
        serialListBox.getY() + serialListBox.getHeight() + LINE_HEIGHT + GAP_H, 
        540, 
        550);


    {
      JLabel l = new JLabel("Send(Press Enter Key)"); 
      l.setForeground(Color.red); 
      l.setBounds(
        offsetX, 
        logText.getY() + logText.getHeight() + GAP_H, 
        500, 
        LINE_HEIGHT);

      _panel.add(l);
    }

    sendText = new JTextField();
    sendText.setBackground(Color.gray);
    sendText.addKeyListener(_listener);
    sendText.setEnabled(false);
    sendText.setBounds(
      offsetX - 5, 
      logText.getY() + logText.getHeight() + LINE_HEIGHT + GAP_H, 
      550, 
      LINE_HEIGHT);

    sendButton = new JButton("Send(without Enter Code)");
    sendButton.setEnabled(false);
    sendButton.addActionListener(_listener); 
    sendButton.setBounds(
      offsetX, 
      sendText.getY() + sendText.getHeight() + GAP_H, 
      200, 
      LINE_HEIGHT);

    _panel.add(captionText);
    _panel.add(serialListBox);
    _panel.add(baudRateBox);
    _panel.add(connectButton);
    _panel.add(logText);
    _panel.add(sendText);
    _panel.add(sendButton);
  }
}  
