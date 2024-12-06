package control;

import database.MySqld;
import view.ChangeAcoountOther;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

public class ChangeAccountHandle implements ActionListener {
    ChangeAcoountOther change;
    public ChangeAccountHandle(ChangeAcoountOther change){
      this.change = change;
    }
    
    @Override
    public void actionPerformed(ActionEvent e){
        if ("Change Current User Information".equals(e.getActionCommand())) {
            try {
                new MySqld().updateAccount();
                change.dispose();
            } catch (SQLException ex) {
                ex.printStackTrace();
            } catch (ClassNotFoundException ex) {
                ex.printStackTrace();
            }
        }
    }
}
