package control;

import database.MySqld;
import view.ChangeAcoountOther;
import view.LoginView;
import view.Manager;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

public class ItemHandle implements ActionListener {
    Manager manager;
    public ItemHandle(Manager manager){
        this.manager=manager;
    }

    public void actionPerformed(ActionEvent e) {

        if ("Change Current User Information".equals(e.getActionCommand())) {
            try {
                new ChangeAcoountOther();
                new MySqld().findNowAccount();
            } catch (SQLException ex) {
                ex.printStackTrace();
            } catch (ClassNotFoundException ex) {
                ex.printStackTrace();
            }

        }
        else if (e.getActionCommand()=="Login"){
            manager.dispose();
            new LoginView();
        }
        else if (e.getActionCommand()=="Logout"){
            manager.dispose();
        }
    }
}
