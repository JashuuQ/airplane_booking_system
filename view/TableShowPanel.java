package view;

import other.Reflush;

import javax.swing.*;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.MouseAdapter;
import java.util.ArrayList;
import java.util.Arrays;

public class TableShowPanel {
    public static JFrame jf;
    JPanel pan2;
    public static ArrayList<String> list = new ArrayList<>();
    public static JTable table;
    public static DefaultTableModel model;
    public static String selectedFlight;

    Object[] title = {
            "Date", "Flight Number", "Departure City", "Departure Airport", "Departure Time",
            "Destination City", "Arrival Airport", "Arrival Time", "Seats", "Duration (minutes)",
            "Price (USD)"};
    
    public TableShowPanel(JFrame jf){
        this.jf = jf;
    }
    
    public TableShowPanel() {
    }
    
    public void createPanel() {
        pan2 = new JPanel();
        pan2.setLayout(new BorderLayout());
        pan2.setBounds(5,200,1190,335);
        pan2.setBorder(BorderFactory.createTitledBorder("       Flight Information Display"));
        jf.add(pan2);

    }

    public void addTable(Object[][] arr) {
        Manager.pan_init.setVisible(false);
        if (table != null) {
            // Update table data if it already exists
            model.getDataVector().clear();
            model.setDataVector(arr,title);
            table.updateUI();

            for (Object[] row : arr) {
                System.out.println(Arrays.toString(row));
            }

        }
        else {
            // Create panel and add table
            createPanel();
            Reflush.reflush(pan2);
            table = addJTable(title, arr, pan2);
        }
        
        table.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(java.awt.event.MouseEvent e) {
               list.add(selectedFlight);
            }

        });


    }
    public JTable addJTable(Object[] title, Object[][] arr, JPanel jp) {
        // Create the table model
        model = new DefaultTableModel(arr, title) {
            private static final long serialVersionUID = 1L;

            @Override
            public boolean isCellEditable(int row, int column) {
                return false; // Make table cells non-editable
            }
        };
        
        JTable table = new JTable(model);
        
        DefaultTableCellRenderer centerRenderer = new DefaultTableCellRenderer();
        centerRenderer.setHorizontalAlignment(JLabel.CENTER);
        
        for (int i = 0; i < table.getColumnCount(); i++) {
            table.getColumnModel().getColumn(i).setPreferredWidth(200);
            table.getColumnModel().getColumn(i).setCellRenderer(centerRenderer);
        }
        

        // Apply center alignment to the table header
        DefaultTableCellRenderer headerRenderer =
                (DefaultTableCellRenderer) table.getTableHeader().getDefaultRenderer();
        headerRenderer.setHorizontalAlignment(JLabel.CENTER);
        table.getTableHeader().setDefaultRenderer(headerRenderer);

        // Set preferred size for table header
        table.getTableHeader().setPreferredSize(
                new Dimension(table.getTableHeader().getPreferredSize().width, 30)
        );
        
        JScrollPane jsp = new JScrollPane(table);
        jp.setLayout(new BorderLayout());
        jp.add(jsp, BorderLayout.CENTER);
        
        return table;
    }

    

}

