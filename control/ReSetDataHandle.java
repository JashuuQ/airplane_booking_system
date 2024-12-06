package control;

import view.Manager;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
public class ReSetDataHandle implements ActionListener {
    
    public void actionPerformed(ActionEvent e){
        Manager.text_reachcity.setText("");
        Manager.text_startcity.setText("");
        Manager.text_find.setText("");
    }
}
