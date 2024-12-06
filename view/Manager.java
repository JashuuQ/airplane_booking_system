package view;

import control.*;
import database.MySqld;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumnModel;
import java.awt.*;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Vector;

public class Manager extends JFrame {
    public static int selectedRow;
    JPanel pan1; // Panel for basic information
    public static JPanel pan_init; // Panel for displaying the table
    JScrollPane pan3;
    JMenuBar menuBar;
    JMenu menu;
    JMenu menu1;
    JMenuItem item3;
    JMenuItem item5,item6;
    JLabel label_startcity;
    JLabel label_reachcity,label_time;
    public static JTextField text_startcity,text_reachcity,text_time;
    public static JTextField text_find;
    JButton button_find;
    public static JButton button_order;
    public static JButton button_back;
    public static JButton button_change;
    public static JButton button_refresh;
    public static JButton button_reset;
    public static JTextArea text_under;
    
    public Manager(){
        init();
        setTitle("Airplane Ticket Booking System");
        setResizable(false);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setVisible(true);
        validate();
    }
    
    public void init(){
        this.setLayout(null);
        this.setBounds(0,0,1219,810);
        this.setLocationRelativeTo(null);
        // Add background image
        ImageIcon img=new ImageIcon("img/1.png");
        JLabel bk=new JLabel(img);
        bk.setBounds(0,0, 1200, 100);
        this.add(bk);
        // Add menu bar
        menuBar=new JMenuBar();

        // first menu
        menu=new JMenu("Manage");
        item3=new JMenuItem(
                "Change Current User Information",
                new ImageIcon("img/m3.png"));
        menu.add(item3);
        menuBar.add(menu);
        
        // second menu
        menu1=new JMenu("Account");
        item5=new JMenuItem("Login",new ImageIcon("img/m5.png"));
        item6=new JMenuItem("Logout",new ImageIcon("img/m6.png"));
        itemEvent();
        menu1.add(item5);
        menu1.add(item6);
        menuBar.add(menu1);
        this.add(menuBar);
        this.setJMenuBar(menuBar);

        // Add labels and buttons
        pan1=new JPanel();
        pan1.setLayout(new FlowLayout(FlowLayout.CENTER));
        pan1.setBorder(BorderFactory.createTitledBorder("    Basic Information"));
        pan1.setBounds(21,100,1150,100);
        
        label_startcity=new JLabel("Departure City");
        
        text_startcity=new JTextField(15);
        pan1.add(label_startcity);
        pan1.add(text_startcity);
        this.add(pan1);
        
        label_reachcity=new JLabel("Destination City");
        label_time=new JLabel("Time");
        text_reachcity=new JTextField(15);
        text_time=new JTextField(15);
        
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String today = sdf.format(d);
        text_time.setText(today);
        pan1.add(label_reachcity);
        pan1.add(text_reachcity);
        pan1.add(label_time);
        pan1.add(text_time);
        button_find =new JButton("Search Flights");
        button_order =new JButton("Book Flight");
        pan1.add(button_find);
        pan1.add(button_order);
        
        
        JLabel label_end=new JLabel("Enter your order number to cancel or change a ticket:");
        text_find=new JTextField(10);
        button_back =new JButton("Cancel Ticket");
        button_change =new JButton("Change Ticket");
        button_refresh=new JButton("Refresh Orders");
        button_reset=new JButton("Reset Data");
        buttonEvent();
        
       
        pan1.add(label_end);
        pan1.add(text_find);
        pan1.add(button_back);
        pan1.add(button_change);
        pan1.add(button_refresh);
        pan1.add(button_reset);


        pan_init = new JPanel();
        pan_init.setLayout(null);
        pan_init.setBounds(5, 200, 1190, 335);
        pan_init.setBorder(BorderFactory.createTitledBorder("       Flight Information Display"));
        
        JLabel label_init = new JLabel(
                "No content available. Please enter 'Departure City,' 'Destination City,' " +
                        "and 'Date,' then click >> Search Flights << to view results."
        );
        label_init.setBounds(180, 400, 1000, 40);
        pan_init.add(label_init);
        this.add(pan_init);



        text_under=new JTextArea(20,30);
        pan3 = new JScrollPane(text_under);
        pan3.setBounds(5,540,1190,200);
        pan3.setBorder(BorderFactory.createTitledBorder("    Order Information Display"));
        this.add(pan3);
        new TableShowPanel(this);
        init_action();
    }
    
    public void init_action(){
        try{
            new MySqld().findAllOrders();
        }catch(SQLException | ClassNotFoundException e){
            System.out.println("Failed to display order information.");
        }

    }


    public void itemEvent() {
        item3.addActionListener(new ItemHandle(this));
        item5.addActionListener(new ItemHandle(this));
        item6.addActionListener(new ItemHandle(this));
    }
    
    public void buttonEvent(){
        button_find.addActionListener(new ManagerHandle(this));
        button_order.addActionListener(new ManagerHandle(this));
        button_back.addActionListener(new ManagerHandle(this));
        button_change.addActionListener(new ManagerHandle(this));
        button_refresh.addActionListener(new ManagerHandle(this));
        button_reset.addActionListener(new ReSetDataHandle());
    }
}
