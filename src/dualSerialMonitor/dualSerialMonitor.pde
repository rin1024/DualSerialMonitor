import processing.serial.*;
import java.awt.*; 
import java.awt.event.*; 
import javax.swing.*; 
import javax.swing.event.*;

JButton reflesSerialListButton;
SerialMonitor serialMonitors[];

String[] serialList;

void setup() { 
  surface.setVisible(false);

  GuiListener listener = new GuiListener(this);
  serialList = Serial.list();

  JPanel panel = new JPanel();
  panel.setLayout(null);

  serialMonitors = new SerialMonitor[NUM_MONITORS];
  for (int i=0;i<serialMonitors.length;i++) {
    int x = MONITOR_WIDTH * i + MARGIN_X;
    int y = 0;
    serialMonitors[i] = new SerialMonitor(this, x, y);
    serialMonitors[i].setId(i + 1);
    serialMonitors[i].init(panel, listener);
  }

  reflesSerialListButton = new JButton("Reflesh Serial List");
  reflesSerialListButton.setBounds(20, 745, 1120, 20);
  reflesSerialListButton.addActionListener(listener); 
  panel.add(reflesSerialListButton);

  JFrame f = new JFrame("Dual Serial Monitor"); 
  f.add(panel);
  f.setSize(W_WIDTH, W_HEIGHT); 
  f.setVisible(true);

  refleshSerialList();
}

void draw() {
}

void serialEvent(Serial _serialPort) {
  String str = _serialPort.readString();

  for (int i=0;i<serialMonitors.length;i++) {
    if (_serialPort.equals(serialMonitors[i].serialPort)) {
      serialMonitors[i].logText.setText(serialMonitors[i].logText.getText() + str);
    }
  }
}

void refleshSerialList() {
  if (serialList != Serial.list()) {
    serialList = Serial.list();

    for (int i=0;i<serialMonitors.length;i++) {
      DefaultComboBoxModel model = new DefaultComboBoxModel( serialList );
      String selectedItem = (String)serialMonitors[i].serialListBox.getSelectedItem();
      serialMonitors[i].serialListBox.setModel(model);
      if (selectedItem != null) {
        serialMonitors[i].serialListBox.setSelectedItem(selectedItem);
      }
    }
  }
}
