package view;

import database.MySqld;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.sql.SQLException;


public class ChangeTicket extends JFrame {
    
    JButton button1;
    JLabel start_city, reach_city, data;
    public static JTextField text_start_city, text_reach_city;
    JComboBox box;
    public static String selectedValue;
    public static String date_view;
    public static String time_view;

    public static String emp;

    public ChangeTicket() throws SQLException, ClassNotFoundException {
        init();
        this.setSize(380, 400);
        this.setTitle("Ticket Change");
        this.setLocationRelativeTo(null);
        this.setVisible(true);
        this.setResizable(true);
        this.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
    }

    public void init() throws SQLException, ClassNotFoundException {
        this.setLayout(null);
        start_city=new JLabel("Departure City");
        start_city.setFont(new Font("Arial",Font.PLAIN,18));
        start_city.setBounds(50,60,75,36);
        text_start_city=new JTextField();
        text_start_city.setBounds(130,60,155,36);
        reach_city=new JLabel("Destination City");
        reach_city.setFont(new Font("Arial",Font.PLAIN,18));
        reach_city.setBounds(50,120,75,36);
        text_reach_city=new JTextField();
        text_reach_city.setBounds(130,120,155,36);
        data=new JLabel("   Date ");
        data.setFont(new Font("Arial",Font.PLAIN,18));
        data.setBounds(50,180,75,36);

 
        button1=new JButton("Confirm Ticket Change");
        button1.setBounds(115,243,150,30);


        start_city = new JLabel("Departure City");
        reach_city = new JLabel("Destination City");
        text_start_city.setText(MySqld.start_city);
        text_reach_city.setText(MySqld.reach_city);

        data = new JLabel("   Date ");
        box=new JComboBox();
        box.setBounds(130,180,150,36);
        for(int i = 1; i < MySqld.date_list.size(); i++) {
            box.addItem(
                    MySqld.date_list.get(i) + " " + MySqld.time_list.get(i));
        }
        
        button1.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if(e.getActionCommand() == "Confirm Ticket Change"){
                try {

                    int isRight =  JOptionPane.showConfirmDialog(null,
                            "Are you sure you want to change the ticket?",
                            "Confirmation", 
                            javax.swing.JOptionPane.YES_NO_CANCEL_OPTION);
                    if(isRight == JOptionPane.YES_OPTION){
                        new MySqld().addTable(
                                MySqld.start_city, MySqld.reach_city, ChangeTicket.date_view);
                        dispose();
                    }
                    else {
                        dispose();
                    }
                } catch (SQLException ex) {
                    ex.printStackTrace();
                } catch (ClassNotFoundException ex) {
                    ex.printStackTrace();
                }
            }
        }});

        box.setSelectedIndex(-1);


        box.addItemListener(new ItemListener() {
            @Override
            public void itemStateChanged(ItemEvent e) {
                if(e.getStateChange() == ItemEvent.SELECTED){
                    selectedValue =String.valueOf(e.getItem());
                    String[] str=selectedValue.split(" ");
                    date_view=str[0];
                    time_view=str[1];
                }
            }
        });
        
        this.add(text_reach_city);
        this.add(data);
        this.add(box);
        this.add(start_city);
        this.add(text_start_city);
        this.add(reach_city);
        this.add(button1);
    }
}

