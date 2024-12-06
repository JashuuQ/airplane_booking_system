package control;

import database.MySqld;
import view.ChangeTicket;
import view.Manager;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

import static view.TableShowPanel.list;

public class ManagerHandle implements ActionListener {
    Manager manger;

    public ManagerHandle(Manager manger) {
        this.manger = manger;
    }

    public void actionPerformed(ActionEvent e) {
        if (e.getActionCommand().equals("Book Flight")) {
            try {
                if (!(new MySqld().findFlightIsExits())) {
                    JOptionPane.showMessageDialog(null,
                            "The order already exists, booking is not possible!");
                } else {
                    new MySqld().findNowAccount1();
                    new MySqld().addOrders();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            } catch (ClassNotFoundException ex) {
                ex.printStackTrace();
            }


        }
        else if (e.getActionCommand().equals("Search Flights")) {
            try {
                new MySqld().addTable(
                        Manager.text_startcity.getText(),
                        Manager.text_reachcity.getText(),
                        Manager.text_time.getText());
            } catch (SQLException ex) {
                ex.printStackTrace();
            } catch (ClassNotFoundException ex) {
                ex.printStackTrace();
            }
        } else if (e.getActionCommand().equals("Cancel Ticket")) {
            try {
                int isRight =  JOptionPane.showConfirmDialog(null,
                        "Are you sure you want to cancel the ticket?", "Confirmation", 
                        javax.swing.JOptionPane.YES_NO_CANCEL_OPTION);
                if (isRight == JOptionPane.YES_OPTION){
                    System.out.println("Attempting to cancel ticket with order number: " + 
                            Manager.text_find.getText()); // test
                    new MySqld().deleteOrders();
                }

            } catch (Exception ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(null,
                        "An error occurred while processing your request.",
                        "Error", JOptionPane.ERROR_MESSAGE);
            }

        } else if (e.getActionCommand().equals("Change Ticket")) {
            try {
                new MySqld().findOrders(); // Fetch departure and destination cities
                new MySqld().findTime();
                new ChangeTicket();
                new MySqld().deleteOrderChangeTicket();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        else if (e.getActionCommand().equals("Refresh Orders")) {
            try {
                if (list != null){
                    for (String elements: list
                    ) {
                        System.out.print(elements);
                    }}
                System.out.println(list.size());
                new MySqld().findAllOrders();
            } catch (SQLException ex) {
                ex.printStackTrace();
            } catch (ClassNotFoundException ex) {
                ex.printStackTrace();
            }
        }
    }
}
