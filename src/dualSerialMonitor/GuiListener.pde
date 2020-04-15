class GuiListener implements ItemListener, ChangeListener, ActionListener, KeyListener {
  PApplet pa;

  GuiListener(PApplet _pa) {
    pa = _pa;
  }

  void itemStateChanged(ItemEvent e) { 

  }

  void stateChanged(ChangeEvent e) {

  }

  /**
   * テキストボックス内でのエンターキー押下によるコマンド送信
   */
  void keyPressed(java.awt.event.KeyEvent e) {
    if(e.getKeyCode() == java.awt.event.KeyEvent.VK_ENTER) {
      for (int i=0;i<serialMonitors.length;i++) {
        if (e.getSource() == serialMonitors[i].sendText) {
          if (serialMonitors[i].serialPort != null) {
            serialMonitors[i].serialPort.write(serialMonitors[i].sendText.getText() + "\r\n");
            serialMonitors[i].sendText.setText("");
          }
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
    // シリアルポートの呼びなおしボタンが押された
    if (e.getSource() == reflesSerialListButton) {
      refleshSerialList();
      return;
    }

    for (int i=0;i<serialMonitors.length;i++) {
      // セレクトボックスで任意のシリアルポートが選択された
      if (e.getSource() == serialMonitors[i].serialListBox) {
        println("serialListBox " + serialMonitors[i].serialListBox.getSelectedItem() + " selected");
      }
      // [connect]ボタンが押された
      else if (e.getSource() == serialMonitors[i].connectButton) {
        // 接続状態でなければ、接続試行開始
        if (serialMonitors[i].connectButton.getText().equals(BUTTON_LABEL_CONNECT)) {
          try {
            println(" => try to connect ");

            String targetPort = (String)serialMonitors[i].serialListBox.getSelectedItem();
            int baudRate = Integer.parseInt((String)serialMonitors[i].baudRateBox.getSelectedItem());
            if (serialMonitors[i].serialPort == null) {
              serialMonitors[i].serialPort = new Serial(pa, targetPort, baudRate);

              serialMonitors[i].captionText.setText("Monitor" + serialMonitors[i].id + "(Connect to: " + targetPort + ")");

              // ボタンのラベルを[release]に変更
              serialMonitors[i].connectButton.setText(BUTTON_LABEL_RELEASE);

              // 送信の枠を有効に
              serialMonitors[i].sendText.setEnabled(true);
              serialMonitors[i].sendText.setBackground(Color.white);
              serialMonitors[i].sendButton.setEnabled(true);
            }
          }
          catch (Exception e2) {
            serialMonitors[i].logText.setText(serialMonitors[i].logText.getText() + "\r\n[error]" + e2);
          }
        }
        // 接続を閉じる
        else {
          if (serialMonitors[i].serialPort != null) {
            try {
              serialMonitors[i].serialPort.stop();
              serialMonitors[i].serialPort.dispose();
              serialMonitors[i].serialPort = null;

              serialMonitors[i].captionText.setText("Monitor" + serialMonitors[i].id);

              serialMonitors[i].connectButton.setText(BUTTON_LABEL_CONNECT);

              serialMonitors[i].sendText.setEnabled(false);
              serialMonitors[i].sendText.setBackground(Color.gray);
              serialMonitors[i].sendButton.setEnabled(false);
            }
            catch (Exception e2) {
              serialMonitors[i].logText.setText(serialMonitors[i].logText.getText() + "\r\n[error]" + e2);
            }
          }
        }
      }
      // 送信ボタンが押された
      else if (e.getSource() == serialMonitors[i].sendButton) {
        if (serialMonitors[i].serialPort != null) {
          serialMonitors[i].serialPort.write(serialMonitors[i].sendText.getText());
          serialMonitors[i].sendText.setText("");
        }
      }
    }
  }
}  
