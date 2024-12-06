package view;

import control.RegisterHandle;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class RegisterView extends JFrame {

    public static JTextField username;
    public static JTextField password;
    public static JTextField realname;
    public static JTextField id;
    public static JTextField phone;

    public RegisterView() {
        initialize();
        this.setBounds(500, 300, 800, 560);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setTitle("User Registration");
        this.setVisible(true);
    }

    private void initialize() {
        JLabel label = new JLabel("--- User Registration ---");
        label.setBounds(360, 180, 200, 25);
        label.setFont(new Font(null, Font.BOLD, 18));
        this.add(label);

        JLabel userLabel = new JLabel("Username");
        userLabel.setBounds(322, 222, 80, 25);
        userLabel.setFont(new Font(null, Font.PLAIN, 14));
        this.add(userLabel);

        JLabel passwordLabel = new JLabel("Password");
        passwordLabel.setBounds(322, 254, 80, 25);
        passwordLabel.setFont(new Font(null, Font.PLAIN, 14));
        this.add(passwordLabel);

        JLabel realNameLabel = new JLabel("Real Name");
        realNameLabel.setBounds(322, 286, 80, 25);
        realNameLabel.setFont(new Font(null, Font.PLAIN, 14));
        this.add(realNameLabel);

        JLabel idCardLabel = new JLabel("ID Number");
        idCardLabel.setBounds(300, 318, 80, 25);
        this.add(idCardLabel);

        JLabel phoneNumberLabel = new JLabel("Phone");
        phoneNumberLabel.setBounds(322, 350, 80, 25);
        phoneNumberLabel.setFont(new Font(null, Font.PLAIN, 14));
        this.add(phoneNumberLabel);

        username = new JTextField();
        username.setBounds(380, 222, 120, 25);
        this.add(username);

        password = new JPasswordField();
        password.setBounds(380, 254, 120, 25);
        this.add(password);

        realname = new JTextField();
        realname.setBounds(380, 286, 120, 25);
        this.add(realname);

        id = new JTextField();
        id.setBounds(380, 318, 120, 25);
        this.add(id);

        phone = new JTextField();
        phone.setBounds(380, 350, 120, 25);
        this.add(phone);

        JPanel panel = new JPanel(null);
        panel.setBounds(290, 170, 245, 225);
        panel.setBackground(Color.WHITE);
        panel.setBorder(BorderFactory.createLineBorder(Color.GRAY));
        this.add(panel);

        JButton registerButton = new JButton("Register");
        registerButton.setBounds(320, 405, 80, 25);
        this.add(registerButton);
        registerButton.addActionListener(new RegisterHandle(this));

        JButton backButton = new JButton("Back");
        backButton.setBounds(420, 405, 80, 25);
        this.add(backButton);

        JLabel mentionLabel = new JLabel("");
        mentionLabel.setBounds(350, 100, 120, 25);
        mentionLabel.setForeground(Color.RED);
        mentionLabel.setFont(new Font(null, Font.BOLD, 17));
        this.add(mentionLabel);

        backButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // Close the registration window
                dispose();
            }
        });
    }
}
