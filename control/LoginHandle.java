package control;

import other.OpenBrowser;
import database.MySqld;
import view.LoginView;
import view.Manager;
import view.RegisterView;
import javax.swing.*;
import java.awt.event.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


public class LoginHandle extends KeyAdapter implements ActionListener{
    private LoginView login;
    public static String user;
    public static String pass;

    
    public LoginHandle(LoginView login){
        this.login = login;
    }

    
    @Override
    public void actionPerformed(ActionEvent e) {
        if("Login".equals(e.getActionCommand())){
            try {
                login();
            } catch (SQLException | ClassNotFoundException | InterruptedException ex) {
                ex.printStackTrace();
            }
        }
        else if("Register".equals(e.getActionCommand())){
            new RegisterView();
        }
    }

    private void login() throws SQLException, ClassNotFoundException, InterruptedException {
        boolean flag=false;
        Connection con=new MySqld().getCon();
        String sql="select username,password from user";
        Statement sta=con.createStatement();
        ResultSet set =sta.executeQuery(sql);
        ArrayList<String> username=new ArrayList<>();
        ArrayList<String> password=new ArrayList<>();
        
        while(set.next()){
            username.add(set.getString(1));
            password.add(set.getString(2));

        }
        for(int j = 0; j < username.size(); j++){
            if (username.get(j).equals(login.getText_user().getText()) && 
                    password.get(j).equals(String.valueOf(login.getText_psd().getPassword())))
            {
                if(new MySqld().findRole()){
                    JOptionPane.showMessageDialog(null,
                            "Welcome to the Web Management System!");
                    new OpenBrowser();}
                else {
                    new Manager();
                }

                login.dispose();

                flag = true;
            }
        }
        
        sta.close();
        con.close();
        
        if(!flag){
            JOptionPane.showMessageDialog(login,"Incorrect username or password.");
        }

        user =login.getText_user().getText();
        char[] ch=login.getText_psd().getPassword();
        pass=String.valueOf(ch);
    }

    @Override
    public void keyPressed(KeyEvent e) {
        if( KeyEvent.VK_ENTER == e.getKeyCode()){
            try {
                login();
            } catch (SQLException | ClassNotFoundException | InterruptedException ex) {
                ex.printStackTrace();
            }
        }
    }
}
