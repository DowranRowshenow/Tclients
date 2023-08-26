package com.zeroteams.tclients;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Build;
import android.provider.ContactsContract;
import android.telephony.TelephonyManager;

import androidx.core.app.NotificationCompat;

public class CallReceiver extends BroadcastReceiver {

    private String phoneNumber = null;
    private DBHelper db;

    @Override
    public void onReceive(Context context, Intent intent) {
        String state = intent.getStringExtra(TelephonyManager.EXTRA_STATE);
        phoneNumber = intent.getStringExtra(TelephonyManager.EXTRA_INCOMING_NUMBER);

        if (state.equals(TelephonyManager.EXTRA_STATE_RINGING) && phoneNumber != null) {
            System.out.println(phoneNumber);
            if (!isContact(context, phoneNumber)) {
                System.out.println("CALLER DOES NOT EXISTS IN CONTACTS");
                sendNotification(context, phoneNumber);
            }
        }
    }

    private boolean isContact(Context context, String phoneNumber) {
        Uri uri = Uri.withAppendedPath(ContactsContract.PhoneLookup.CONTENT_FILTER_URI, Uri.encode(phoneNumber));
        String[] projection = { ContactsContract.PhoneLookup.DISPLAY_NAME };
        String selection = null;
        String[] selectionArgs = null;
        String sortOrder = null;

        Cursor cursor = context.getContentResolver().query(uri, projection, selection, selectionArgs, sortOrder);
        if (cursor != null) {
            if (cursor.moveToFirst()) {
                cursor.close();
                return true;
            }
            cursor.close();
        }

        System.out.println("CALLER EXISTS IN CONTACTS");
        return false;
    }

    private void sendNotification(Context context, String phoneNumber) {
        // Get User From Database
        db = new DBHelper(context);
        User user = db.getUser(phoneNumber.replace("+",""));
        System.out.println("USER: " + user.userToString());

        // Create a NotificationChannel if necessary.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel("default", "Default", NotificationManager.IMPORTANCE_DEFAULT);
            NotificationManager notificationManager = context.getSystemService(NotificationManager.class);
            notificationManager.createNotificationChannel(channel);
        }

        // Create a NotificationCompat.Builder object.
        NotificationCompat.Builder builder = new NotificationCompat.Builder(context, "default");

        // Set the notification's properties.
        builder.setContentTitle(user.getName());
        builder.setContentText(user.userToString());
        builder.setSmallIcon(R.mipmap.ic_launcher);

        // Get a NotificationManager object.
        NotificationManager notificationManager = null;
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
            notificationManager = context.getSystemService(NotificationManager.class);
        }

        // Notify the user.
        notificationManager.notify(0, builder.build());
    }

}