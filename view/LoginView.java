package view;

import control.LoginHandle;

import javax.swing.*;
import java.awt.*;

public class LoginView extends JFrame {
    public static JTextField text_user;
    public static JPasswordField text_psd;

    public static void main(String[] args) {
        new LoginView();
    }

    public LoginView() {
        this.setTitle("Airplane Ticket Booking System");
        this.setSize(500, 400);
        this.setLocationRelativeTo(null);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Use GridBagLayout
        Container container = this.getContentPane();
        container.setLayout(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.fill = GridBagConstraints.HORIZONTAL;
        gbc.insets = new Insets(5, 10, 5, 10);

        // Title label
        JLabel title = new JLabel("Airplane Ticket Booking System", JLabel.CENTER);
        title.setFont(new Font("Arial", Font.BOLD, 20));
        gbc.gridx = 0;
        gbc.gridy = 0;
        gbc.gridwidth = 2;
        gbc.insets = new Insets(10, 10, 20, 10);
        container.add(title, gbc);

        // Username label
        JLabel label_user = new JLabel("Username:");
        label_user.setFont(new Font("Arial", Font.PLAIN, 16));
        gbc.gridx = 0;
        gbc.gridy = 1;
        gbc.gridwidth = 1;
        gbc.insets = new Insets(5, 10, 5, 5);
        container.add(label_user, gbc);

        // Username text field
        text_user = new JTextField(15);
        gbc.gridx = 1;
        gbc.gridy = 1;
        gbc.insets = new Insets(5, 5, 5, 10);
        container.add(text_user, gbc);

        // Password label
        JLabel label_psd = new JLabel("Password:");
        label_psd.setFont(new Font("Arial", Font.PLAIN, 16));
        gbc.gridx = 0;
        gbc.gridy = 2;
        gbc.insets = new Insets(5, 10, 5, 5);
        container.add(label_psd, gbc);

        // Password text field
        text_psd = new JPasswordField(15);
        gbc.gridx = 1;
        gbc.gridy = 2;
        gbc.insets = new Insets(5, 5, 5, 10);
        container.add(text_psd, gbc);

        // Login button
        JButton button_login = new JButton("Login");
        gbc.gridx = 0;
        gbc.gridy = 3;
        gbc.insets = new Insets(10, 10, 10, 5);
        container.add(button_login, gbc);

        // Register button
        JButton button_register = new JButton("Register");
        gbc.gridx = 1;
        gbc.gridy = 3;
        gbc.insets = new Insets(10, 5, 10, 10);
        container.add(button_register, gbc);

        // Add action listeners (example)
        button_login.addActionListener(new LoginHandle(this));
        button_register.addActionListener(new LoginHandle(this));
        text_psd.addKeyListener(new LoginHandle(this));

        // Set visible
        this.setVisible(true);
    }

    public JTextField getText_user() {
        return text_user;
    }

    public JPasswordField getText_psd() {
        return text_psd;
    }
}
