import processing.serial.*;
import java.awt.*; 
import java.awt.event.*; 
import javax.swing.*; 
import javax.swing.event.*;

static JFrame f; 

JLabel label1, label2;
static JComboBox serialList1, serialList2; 
static JComboBox baud1, baud2; 
static JButton connectButton1, connectButton2;
static JTextArea logText1, logText2; 
static JTextField sendText1, sendText2;

static JButton sendButton1, sendButton2;

Serial serial1, serial2;
String msg1, msg2;

long serialListAutoLoader;

void setup() { 
  surface.setVisible(false);

  GuiListener listener = new GuiListener(this);
  String[] serialList = Serial.list();

  JPanel p1 = new JPanel();
  p1.setLayout(null);
  {
    // create labels 
    label1 = new JLabel("LOG1"); 
    label1.setForeground(Color.red); 
    //l1.setMinimumSize(new Dimension(20, 20));
    label1.setBounds(20, 20, 500, 20);
    
    serialList1 = new JComboBox(serialList); 
    //c1.addItemListener(listener); 
    serialList1.addActionListener(listener);
    //c1.setMinimumSize(new Dimension(20, 20));
    serialList1.setBounds(20, 50, 350, 20);

    baud1 = new JComboBox(BAUD_LIST); 
    //baud1.addActionListener(listener);
    baud1.setBounds(370, 50, 100, 20);

    connectButton1 = new JButton(BUTTON_LABEL_CONNECT);
    connectButton1.setBounds(475, 50, 90, 20);
    connectButton1.addActionListener(listener);
  
    {
      JLabel l = new JLabel("Recv"); 
      l.setForeground(Color.red); 
      l.setBounds(20, 80, 500, 20);
      p1.add(l);
    }

    logText1 = new JTextArea();
    logText1.setLineWrap(true);
    logText1.setPreferredSize(new Dimension(450, 400));
    //t1.setMinimumSize(new Dimension(100, 100));
    logText1.setBounds(20, 110, 540, 550);
    
    {
      JLabel l = new JLabel("Send(Press Enter Key)"); 
      l.setForeground(Color.red); 
      l.setBounds(20, 670, 500, 20);
      p1.add(l);
    }
    
    sendText1 = new JTextField();
    sendText1.setBounds(15, 690, 550, 20);
    sendText1.setBackground(Color.gray);
    sendText1.addKeyListener(listener);
    sendText1.setEnabled(false);
    
    sendButton1 = new JButton("Send(without Enter Code)");
    sendButton1.setBounds(20, 715, 200, 20);
    sendButton1.setEnabled(false);
    sendButton1.addActionListener(listener); 

    p1.add(label1);
    p1.add(serialList1);
    p1.add(baud1);
    p1.add(connectButton1);
    p1.add(logText1);
    p1.add(sendText1);
    p1.add(sendButton1);
  }
  
  {
    label2 = new JLabel("LOG2"); 
    label2.setForeground(Color.blue); 
    //l2.setMinimumSize(new Dimension(20, 20));
    label2.setBounds(600, 20, 450, 20);

    serialList2 = new JComboBox(serialList); 
    //c2.addItemListener(listener);
    serialList2.addActionListener(listener);
    //c2.setMinimumSize(new Dimension(20, 20));
    serialList2.setBounds(600, 50, 350, 20);

    baud2 = new JComboBox(BAUD_LIST); 
    //baud2.addActionListener(listener);
    baud2.setBounds(950, 50, 100, 20);
    
    connectButton2 = new JButton(BUTTON_LABEL_CONNECT);
    connectButton2.setBounds(1055, 50, 90, 20);
    connectButton2.addActionListener(listener); 
  
    {
      JLabel l = new JLabel("Recv"); 
      l.setForeground(Color.blue); 
      l.setBounds(600, 80, 500, 20);
      p1.add(l);
    }

    logText2 = new JTextArea();
    logText2.setLineWrap(true);
    logText2.setPreferredSize(new Dimension(450, 400));
    //t2.setMinimumSize(new Dimension(100, 100));
    //logText2.setEnabled(false);
    logText2.setBounds(600, 110, 540, 550);
    
    {
      JLabel l = new JLabel("Send(Press Enter Key)"); 
      l.setForeground(Color.blue); 
      l.setBounds(600, 670, 500, 20);
      p1.add(l);
    }

    sendText2 = new JTextField();
    sendText2.setBounds(595, 690, 550, 20);
    sendText2.setBackground(Color.gray);
    sendText2.addKeyListener(listener);
    sendText2.setEnabled(false);

    sendButton2 = new JButton("Send(without Enter Code)");
    sendButton2.setBounds(600, 715, 200, 20);
    sendButton2.setEnabled(false);
    sendButton2.addActionListener(listener); 
    
    p1.add(label2);
    p1.add(serialList2);
    p1.add(baud2);
    p1.add(connectButton2);
    p1.add(logText2);
    p1.add(sendText2);
    p1.add(sendButton2);
  }
  
  f = new JFrame("Dual Serial Monitor"); 
  f.add(p1);
  f.setSize(W_WIDTH, W_HEIGHT); 
  f.setVisible(true); 
}

void draw() {
  /*if (millis() - serialListAutoLoader > 5000) {
    String[] serialList = Serial.list();
    
    DefaultComboBoxModel model = new DefaultComboBoxModel( serialList );
    serialList1.setModel( model );
    serialList2.setModel( model );
    
    serialListAutoLoader = millis();
  }*/
}

void serialEvent(Serial _serialPort) {
  String str = _serialPort.readString();//Until('\r');
  if (_serialPort.equals(serial1)) {
    logText1.setText(logText1.getText() + str);
  }
  else if (_serialPort.equals(serial2)) {
    logText2.setText(logText2.getText() + str);
  }
}
