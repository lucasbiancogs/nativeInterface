package com.example.nativeInterface

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    // Lembrando que kotlin usa aspas duplas
    private val CHANNEL = "lucas.biancogs.com.br/nativo"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if(call.method == "calcSum") {
                var a = call.argument<Int>(key: "a")?.toInt() ?: 0
                var b = call.argument<Int>(key: "b")?.toInt() ?: 0

                result.success(a + b)
            } else {
                result.notImplemented()
            }
        }
    }
}
