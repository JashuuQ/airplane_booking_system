package control;

import database.MySqld;
import view.RegisterView;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RegisterHandle implements ActionListener {
    RegisterView register;
    MySqld mySqld;
    PreparedStatement ps;

    public RegisterHandle(RegisterView register) {
        this.register = register;
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getActionCommand().equals("Register")) {
            if (register.username.getText().trim().isEmpty()) {
                JOptionPane.showMessageDialog(null, 
                        "Username cannot be empty!", 
                        "Warning", JOptionPane.WARNING_MESSAGE);
                return;
            } else if (register.password.getText().trim().isEmpty()) {
                JOptionPane.showMessageDialog(null, 
                        "Password cannot be empty!", 
                        "Warning", JOptionPane.WARNING_MESSAGE);
                return;
            } else if (register.realname.getText().trim().isEmpty()) {
                JOptionPane.showMessageDialog(null, 
                        "Real name cannot be empty!", 
                        "Warning", JOptionPane.WARNING_MESSAGE);
                return;
            } else if (register.id.getText().trim().isEmpty()) {
                JOptionPane.showMessageDialog(null, 
                        "ID cannot be empty!", 
                        "Warning", JOptionPane.WARNING_MESSAGE);
                return;
            } else if (register.phone.getText().trim().isEmpty()) {
                JOptionPane.showMessageDialog(null, 
                        "Phone number cannot be empty!", 
                        "Warning", JOptionPane.WARNING_MESSAGE);
                return;
            } else {
                try {
                    Connection con = new MySqld().getCon(); // Establish database connection
                    String sql = "INSERT INTO user VALUES (?,?,?,?,?)";
                    ps = con.prepareStatement(sql);
                    ps.setString(1, register.username.getText());
                    ps.setString(2, register.password.getText());
                    ps.setString(3, register.realname.getText().trim());
                    ps.setString(4, register.id.getText().trim());
                    ps.setString(5, register.phone.getText().trim());

                    int res = ps.executeUpdate();
                    if (res != 0) {
                        JOptionPane.showMessageDialog(null, 
                                "Registration successful!", 
                                "Registration Message", JOptionPane.PLAIN_MESSAGE);
                    } else {
                        JOptionPane.showMessageDialog(null, 
                                "Registration failed!", 
                                "Registration Message", JOptionPane.PLAIN_MESSAGE);
                    }
                    con.close();
                    ps.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                } catch (ClassNotFoundException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }
}
