package com.example.connectivity_plugin

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar

class ConnectivityPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, EventChannel.StreamHandler {

  private lateinit var channel: MethodChannel
  private lateinit var eventChannel: EventChannel
  private lateinit var context: Context

  private var connectivityReceiver: ConnectivityReceiver? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "connectivity_plugin")
    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "connectivity_plugin/changes")
    channel.setMethodCallHandler(this)
    eventChannel.setStreamHandler(this)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    eventChannel.setStreamHandler(null)
    connectivityReceiver?.let { context.unregisterReceiver(it) }
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "isConnected" -> checkInternetConnectivity(result)
      else -> result.notImplemented()
    }
  }

  private fun checkInternetConnectivity(result: MethodChannel.Result) {
    val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
    val network = connectivityManager.activeNetwork
    val capabilities = connectivityManager.getNetworkCapabilities(network)
    val isConnected = capabilities?.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET) == true
    result.success(isConnected)
  }

  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    connectivityReceiver = ConnectivityReceiver(events)
    val filter = IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION)
    context.registerReceiver(connectivityReceiver, filter)
  }

  override fun onCancel(arguments: Any?) {
    connectivityReceiver?.let {
      context.unregisterReceiver(it)
      connectivityReceiver = null
    }
  }

  private class ConnectivityReceiver(private val events: EventChannel.EventSink?) : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
      val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
      val network = connectivityManager.activeNetwork
      val capabilities = connectivityManager.getNetworkCapabilities(network)
      val isConnected = capabilities?.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET) == true
      events?.success(isConnected)
    }
  }
}
