package com.zeroteams.tclients;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import java.util.ArrayList;
import java.util.List;

public class DBHelper extends SQLiteOpenHelper {

    private static final String DATABASE_NAME = "clients.db";
    private static final int DATABASE_VERSION = 1;

    public DBHelper(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        //db.execSQL("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, email TEXT)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        // Drop the old table if it exists.
        //db.execSQL("DROP TABLE IF EXISTS users");

        // Create a new table.
        //db.execSQL("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, email TEXT)");
    }

    public List<User> getUsers(String number) {
        List<User> users = new ArrayList<>();

        SQLiteDatabase db = getReadableDatabase();
        Cursor cursor = db.rawQuery("SELECT * FROM user WHERE number LIKE '%" + number + "%' LIMIT 100", null);

        while (cursor.moveToNext()) {
            User user = new User();
            user.setId(cursor.getInt(0));
            user.setNumber(cursor.getString(1));
            user.setName(cursor.getString(2));

            users.add(user);
        }

        cursor.close();
        db.close();

        return users;
    }

    public User getUser(String number) {
        User user = new User();

        SQLiteDatabase db = getReadableDatabase();
        Cursor cursor = db.rawQuery("SELECT * FROM user WHERE number LIKE '%" + number + "%' LIMIT 1", null);

        while (cursor.moveToNext()) {
            user.setId(cursor.getInt(0));
            user.setNumber(cursor.getString(1));
            user.setName(cursor.getString(2));
            user.setBirth(cursor.getString(3));
            user.setAddress(cursor.getString(4));
            user.setPassport(cursor.getString(5));
        }

        cursor.close();
        db.close();

        return user;
    }
}