package com.zeroteams.tclients;

public class User {
    public static int id;
    public static String number;
    public static String name;
    public static String birth;
    public static String address;
    public static String passport;

    public static void setId(int id) {
        User.id = id;
    }
    public static int getId() {
        return id;
    }

    public static void setNumber(String number) {
        User.number = number;
    }
    public static String getNumber() {
        return number;
    }

    public static void setName(String name) {
        User.name = name;
    }
    public static String getName() {
        return name;
    }

    public static void setBirth(String birth) {
        User.birth = birth;
    }
    public static String getBirth() {
        return birth;
    }

    public static void setAddress(String address) {
        User.address = address;
    }
    public static String getAddress() {
        return address;
    }

    public static void setPassport(String passport) {
        User.passport = passport;
    }
    public static String getPassport() {
        return passport;
    }
    
    public static String userToString() {
        return String.format("Number: %s \nName: %s \nBirth: %s \nAddress: %s \nPassport: %s", number, name, birth, address, passport);
    }
}