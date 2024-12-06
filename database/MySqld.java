package database;

import control.LoginHandle;
import other.StringArryToString;
import other.SystemTime;
import view.*;

import javax.swing.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.Objects;


public class MySqld {
    private Connection con = null;
    private Statement state = null;
    private ResultSet res = null;
    private ResultSet res1 = null;
    PreparedStatement ps;
    public static String username;
    public static String password;
    public static String name;
    public static String id;
    public static String phone;
    public static int role;

    public static String start_city;
    public static String reach_city;
    public static ArrayList<String> date_list=new ArrayList<>();
    public static ArrayList<String> time_list=new ArrayList<>();

    
    public static Object[][] arr = null;
    public static String ordernum;
    public MySqld() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/bs_airplane_booking", 
                "root", "qianjiashu");
        state = con.createStatement();
    }


    public void findAllOrders() {
        String sql = "select * from orders where username='" + LoginView.text_user.getText()+"';";
        try {
            state = con.createStatement();
            res = state.executeQuery(sql);
            Manager.text_under.setText("");
            Manager.text_under.setText(
                    "Order Information\nOrder Number\tDate\tFlight Number\tDeparture City\tDeparture Airport\tDestination City\tArrival Airport\tOperator\tPassenger Name\tPassenger ID\tPassenger Phone\t" + "\n");
            while (res.next()) {
                Manager.text_under.setText(Manager.text_under.getText() + 
                        res.getString(1) + "\t" + res.getString(2) + 
                        "\t" + res.getString(3) + "\t" +res.getString(4) +
                        "\t" + res.getString(5) +"\t" + res.getString(6) +
                        "\t" + res.getString(7) + "\t" + res.getString(8) + 
                        "\t" +res.getString(9) + "\t" +res.getString(10) +
                        "\t" +res.getString(11) +"\n");
            }
        } catch (SQLException e) {

        } finally {

            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                state.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

   
    public void deleteOrders() {
        String sql = "DELETE FROM orders WHERE order_num = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, Manager.text_find.getText());
            int row = ps.executeUpdate();
            if (row != 0) {
                JOptionPane.showMessageDialog(null,
                        "Cancellation Successful", "Cancel Ticket", 
                        JOptionPane.INFORMATION_MESSAGE);
            } else
                JOptionPane.showMessageDialog(null,
                        "Cancellation Failed", "Cancel Ticket", 
                        JOptionPane.WARNING_MESSAGE);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void deleteOrderChangeTicket() {
        String sql = "DELETE FROM orders WHERE order_num = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, Manager.text_find.getText());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public void findOrders(){
        String sql = "select * from orders where order_num='" + Manager.text_find.getText()+"';";
        try {
            state = con.createStatement();
            res = state.executeQuery(sql);
            while (res.next()) {
                start_city = res.getString("start_city");
                reach_city = res.getString("reach_city");
            }
        } catch (SQLException e) {

        } finally {

            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                state.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public void findTime(){
        String sql = "select * from flight where start_city='" + MySqld.start_city + 
                "' and reach_city='" + MySqld.reach_city+"';";
        try {
            state = con.createStatement();
            res = state.executeQuery(sql);
            while (res.next()) {
                String date=res.getString("date");
                String start_time=res.getString("start_time");
                String[] date_emp=date.split("-");
                String[] start_time_emp=start_time.split(":");
                System.out.println(new StringArryToString().toString(date_emp));
                System.out.println(new StringArryToString().toString(start_time_emp));
                Long time=Long.valueOf(new StringArryToString().toString(date_emp)+"" + 
                        new StringArryToString().toString(start_time_emp));
                Long system_time= Long.valueOf(new SystemTime().systemInit2());
                if (time>=system_time){
                    date_list.add(date);
                    time_list.add(start_time);
                }
            }
        } catch (SQLException e) {
          e.printStackTrace();
        } finally {

            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                state.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    
    public void findNowAccount() {
        String sql = "select * from user where username='"+ LoginHandle.user +"';";
        try {
            state = con.createStatement();
            res = state.executeQuery(sql);
            while (res.next()) {
                username=res.getString(1);
                ChangeAcoountOther.text_username.setText(username);
                password=res.getString(2);
                ChangeAcoountOther.text_password.setText(password);
                name=res.getString(3);
                ChangeAcoountOther.text_name.setText(name);
                id=res.getString(4);
                ChangeAcoountOther.text_id.setText(id);
                phone=res.getString(5);
                ChangeAcoountOther.text_phone.setText(phone);

            }
        } catch (SQLException e) {

        } finally {

            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                state.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }



    public void findNowAccount1() {
        String sql = "select * from user where username='"+ LoginHandle.user +"';";
        try {
            state = con.createStatement();
            res = state.executeQuery(sql);
            while (res.next()) {
                username=res.getString(1);
                password=res.getString(2);
                name=res.getString(3);
                id=res.getString(4);
                phone=res.getString(5);
            }
        } catch (SQLException e) {

        } finally {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                state.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }


    public boolean findRole() {
        String sql = "select * from user where username='"+ LoginView.text_user.getText() +"';";
        try {
            state = con.createStatement();
            res = state.executeQuery(sql);
            while (res.next()) {
                role=res.getInt(6);
                System.out.println(role);
        }
        } catch (SQLException e) {

        } finally {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                state.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }
    

    public boolean findFlightIsExits() {

        String sql_findOrders = "select date, flight_num from flight where date='"+
                Manager.text_time.getText()+"' and flight_num='" + 
                arr[TableShowPanel.table.getSelectedRow()][1]+"';";

        try {
            state = con.createStatement();
            res = state.executeQuery(sql_findOrders);
            while (res.next()){
                String sql_findSame="select date,flight_num from orders where date='"+
                        res.getString("date")+"' and flight_num='"+
                        res.getString("flight_num")+"';";
                res1=state.executeQuery(sql_findSame);
                if(res1.next()){
                    return false;
                }
            }

        } catch (SQLException e) {

        } finally {

            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                state.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return true;
    }

    
    public void updateAccount() {
        String sql = "update user set password='"+ChangeAcoountOther.text_name.getText()+ "',name='"
                +ChangeAcoountOther.text_name.getText()+"',id='"+
                ChangeAcoountOther.text_id.getText()+"',phone='"+
                ChangeAcoountOther.text_name.getText()+"' where username='"+ 
                LoginHandle.user +"';";
        
        try {
            state = con.createStatement();
            int count = state.executeUpdate(sql);
            System.out.println(count);
            if (count != 0)
                JOptionPane.showMessageDialog(null, 
                        "Modify Successfully", "Modify Password", JOptionPane.INFORMATION_MESSAGE);
            else
                JOptionPane.showMessageDialog(null, 
                        "Modify Failed", "Modify Password", JOptionPane.WARNING_MESSAGE);
        } catch (SQLException e) {

        } finally {

            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                state.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }

    }
  
    
    public void addOrders() {
        ordernum = new SystemTime().systemInit1();
        String sql = "insert into orders (" +
                "order_num,date,flight_num,start_city,start_airport,reach_city,reach_airport,username,name,id,phone) " +
                "values (?,?,?,?,?,?,?,?,?,?,?)";
        try {

            System.out.println(sql);
            ps = con.prepareStatement(sql);
            ps.setString(1, ordernum);
            ps.setString(2, String.valueOf(arr[TableShowPanel.table.getSelectedRow()][0]));
            ps.setString(3, String.valueOf(arr[TableShowPanel.table.getSelectedRow()][1]));
            ps.setString(4, String.valueOf(arr[TableShowPanel.table.getSelectedRow()][2]));
            ps.setString(5, String.valueOf(arr[TableShowPanel.table.getSelectedRow()][3]));
            ps.setString(6, String.valueOf(arr[TableShowPanel.table.getSelectedRow()][5]));
            ps.setString(7, String.valueOf(arr[TableShowPanel.table.getSelectedRow()][6]));
            ps.setString(8, username);
            ps.setString(9, name);
            ps.setString(10, id);
            ps.setString(11, phone);
            int row = ps.executeUpdate();
            System.out.println(row);
            if (row != 0) {
                JOptionPane.showMessageDialog(null, 
                        "Booking Successful", "Book Flight", JOptionPane.INFORMATION_MESSAGE);
                seatDown();
            } else JOptionPane.showMessageDialog(null,
                    "Booking Failed", "Book Flight", JOptionPane.WARNING_MESSAGE);
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null,
                    "System error, please try again later.");
        } finally {
            try {
                con.close();
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }
    }
    
    
    public void seatDown(){
        String sql="update flight set seat_count =(seat_count - 1) where flight_num='"+
                arr[TableShowPanel.table.getSelectedRow()][1]+"' and date='"+
                arr[TableShowPanel.table.getSelectedRow()][0]+"';";
        try{
            state=con.createStatement();
            int row=state.executeUpdate(sql);
            System.out.println(row);
        }catch(SQLException e){
            JOptionPane.showMessageDialog(null,
                    "System error, please try again later.");
        }

    }


    public void addTable(String info1,String info2,String info3) throws SQLException {
        String sql1 = "select * from flight where start_city = ?";
        String sql2 = "select * from flight where reach_city = ?";
        String sql3 = "select * from flight where date=?";
        String sql4 = "select * from flight";
        try {
            if (!Objects.equals(info1, "")) {
                ps = con.prepareStatement(sql1);
                ps.setString(1, info1);
            } else if (!Objects.equals(info2, "")) {
                ps = con.prepareStatement(sql2);
                ps.setString(1, info2);
            } else if (!Objects.equals(info3, "")) {
                ps = con.prepareStatement(sql3);
                ps.setString(1, info3);
            } else {
                ps = con.prepareStatement(sql4);
            }

            res = ps.executeQuery();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        String[] temp = new String[1024];

        int arrlength = 0;
        while (res.next()) {
            temp[arrlength++] = res.getString(1) + "#" + res.getString(2) + "#" +
                    res.getString(3) + "#" + res.getString(4) + "#" +
                    res.getString(5) + "#" + res.getString(6) + "#" +
                    res.getString(7) + "#" + res.getString(8) + "#" +
                    res.getInt(9) + "#" + res.getString(10) + "#" +
                    res.getDouble(11);
        }
        if (arrlength == 0) {
            arr = new Object[1][11];
        } else {
            arr = new Object[arrlength][11];
        }

        if (arrlength == 0) {
            System.out.println("???????");
            for (int i = 0; i < 11; i++) {
                arr[0][i] = "???????";
            }
        } else {
            for (int i = 0; i < arrlength; i++) {
                String[] s = temp[i].split("#");
                for (int j = 0; j < 11; j++) {
                    arr[i][j] = s[j];
                }
            }
        }

        new TableShowPanel().addTable(arr);
    }

    public Connection getCon() {
        return con;
    }

    public Statement getState() {
        return state;
    }

}