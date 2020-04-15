class GuiListener implements ItemListener, ChangeListener, ActionListener, KeyListener {
  PApplet pa;

  GuiListener(PApplet _pa) {
    pa = _pa;
  }

  void itemStateChanged(ItemEvent e) { 
    /*if (e.getSource() == c1) {
     println(c1.getSelectedItem() + " selected");
     }
     else if (e.getSource() == c2) {
     println(c2.getSelectedItem() + " selected");
     }*/
  }

  void stateChanged(ChangeEvent e) {
    /*if (e.getSource() == b1) {
     println("b1 changed");
     }
     else if (e.getSource() == b2) {
     println("b2 changed");
     }*/
  }
  
  void keyPressed(java.awt.event.KeyEvent e) {
    if(e.getKeyCode() == java.awt.event.KeyEvent.VK_ENTER) {
      if (e.getSource() == sendText1) {
        if (serial1 != null) {
          serial1.write(sendText1.getText() + "\r\n");
          sendText1.setText("");
        }
      }
      else if (e.getSource() == sendText2) {
        if (serial2 != null) {
          serial2.write(sendText2.getText() + "\r\n");
          sendText2.setText("");
        }
      }
    }
  }

  void keyReleased(java.awt.event.KeyEvent e) {
    if(e.getKeyCode() == java.awt.event.KeyEvent.VK_ENTER) {
    }
  }
  
  void keyTyped(java.awt.event.KeyEvent e) {
    if(e.getKeyCode() == java.awt.event.KeyEvent.VK_ENTER) {
    }
  }

  void actionPerformed(ActionEvent e) {
    if (e.getSource() == serialList1) {
      println("serialList1 " + serialList1.getSelectedItem() + " selected");
    } else if (e.getSource() == serialList2) {
      println("serialList2 " + serialList2.getSelectedItem() + " selected");
    }
    // LOG1の接続にチャレンジ
    else if (e.getSource() == connectButton1) {
      if (connectButton1.getText().equals(BUTTON_LABEL_CONNECT)) {
        try {
          println(" => try to connect ");         
          String targetPort = (String)serialList1.getSelectedItem();
          int baudRate = Integer.parseInt((String)baud1.getSelectedItem());
          if (serial1 == null) {
            serial1 = new Serial(pa, targetPort, baudRate);

            label1.setText("LOG1(Connect to: " + targetPort + ")");

            connectButton1.setText(BUTTON_LABEL_RELEASE);
            //connectButton1.setEnabled(false);
            
            sendText1.setEnabled(true);
            sendText1.setBackground(Color.white);
            sendButton1.setEnabled(true);
          }
        }
        catch (Exception e2) {
          logText1.setText(logText1.getText() + "\r\n[error]" + e2);
        }
      }
      else {
        if (serial1 != null) {
          try {
            serial1.stop();
            serial1.dispose();
            serial1 = null;
  
            label1.setText("LOG1");
  
            connectButton1.setText(BUTTON_LABEL_CONNECT);
            
            sendText1.setEnabled(false);
            sendText1.setBackground(Color.gray);
            sendButton1.setEnabled(false);
          }
          catch (Exception e2) {
            logText1.setText(logText1.getText() + "\r\n[error]" + e2);
          }
        }
      }
    }
    // LOG2の接続にチャレンジ
    else if (e.getSource() == connectButton2) {
      if (connectButton2.getText().equals(BUTTON_LABEL_CONNECT)) {
        try {
          println(" => try to connect ");         
          String targetPort = (String)serialList2.getSelectedItem();
          int baudRate = Integer.parseInt((String)baud2.getSelectedItem());
          if (serial2 == null) {
            serial2 = new Serial(pa, targetPort, baudRate);

            label2.setText("LOG2(Connect to: " + targetPort + ")");

            connectButton2.setText(BUTTON_LABEL_RELEASE);
            //connectButton2.setEnabled(false);
            
            sendText2.setEnabled(true);
            sendText2.setBackground(Color.white);
            sendButton2.setEnabled(true);
          }
        }
        catch (Exception e2) {
          logText2.setText(logText2.getText() + "\r\n[error]" + e2);
        }
      }
      else {
        if (serial2 != null) {
          try {
            serial2.stop();
            serial2.dispose();
            serial2 = null;
  
            label2.setText("LOG2");
  
            connectButton2.setText(BUTTON_LABEL_CONNECT);
            
            sendText2.setEnabled(false);
            sendText2.setBackground(Color.gray);
            sendButton2.setEnabled(false);
          }
          catch (Exception e2) {
            logText2.setText(logText2.getText() + "\r\n[error]" + e2);
          }
        }
      }
    }
    else if (e.getSource() == sendButton1) {
      if (serial1 != null) {
        serial1.write(sendText1.getText());
        sendText1.setText("");
      }
    }
    else if (e.getSource() == sendButton2) {
      if (serial2 != null) {
        serial2.write(sendText2.getText());
        sendText2.setText("");
      }
    }
    else if (e.getSource() == reflesSerialListButton) {
      refleshSerialList();
    }
  }
}  
