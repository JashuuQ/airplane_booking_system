package view;

import control.ChangeAccountHandle;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

public class ChangeAcoountOther extends JFrame {
    JLabel username,password,name,id,phone;
    public static JTextField text_username,text_password,text_name,text_id,text_phone;
    JButton button;
    JComboBox box;
    public ChangeAcoountOther() throws SQLException, ClassNotFoundException {
        init();
        this.setSize(844,113);
        this.setLocationRelativeTo(null);
        this.setVisible(true);
        this.setResizable(true);
        this.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
    }
    public void init() throws SQLException, ClassNotFoundException {
        this.setLayout(new FlowLayout());
        
        username=new JLabel("Username");
        password=new JLabel("Password");
        name=new JLabel("N a m e");
        id=new JLabel("ID Number");
        phone=new JLabel("Phone Number");
        
        text_username=new JTextField(20);
        text_username.setEditable(false);
        text_password=new JTextField(20);
        text_name=new JTextField(20);
        text_id=new JTextField(20);
        text_phone=new JTextField(20);
        
        button=new JButton("Update Account Information");
        button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

            }
        });
        button.addActionListener(new ChangeAccountHandle(this));
        
        this.add(username);
        this.add(text_username);
        this.add(password);
        this.add(text_password);
        this.add(name);
        this.add(text_name);
        this.add(id);
        this.add(text_id);
        this.add(phone);
        this.add(text_phone);
        this.add(button);
    }
}
