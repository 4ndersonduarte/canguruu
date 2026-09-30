package br.com.canguruu.canguruu_finance

import android.app.Activity
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private var pendingResult: MethodChannel.Result? = null
    private var pendingBytes: ByteArray? = null
    private val saveRequest = 3901

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "br.com.canguruu/backup")
            .setMethodCallHandler { call, result ->
                if (call.method != "saveBackup") {
                    result.notImplemented()
                    return@setMethodCallHandler
                }
                if (pendingResult != null) {
                    result.error("busy", "Há uma exportação em andamento.", null)
                    return@setMethodCallHandler
                }
                val bytes = call.argument<ByteArray>("bytes")
                val name = call.argument<String>("name")
                if (bytes == null || name == null || bytes.size > 10 * 1024 * 1024) {
                    result.error("invalid", "Cópia inválida.", null)
                    return@setMethodCallHandler
                }
                pendingResult = result
                pendingBytes = bytes
                try {
                    val intent = Intent(Intent.ACTION_CREATE_DOCUMENT).apply {
                        addCategory(Intent.CATEGORY_OPENABLE)
                        type = "application/json"
                        putExtra(Intent.EXTRA_TITLE, name)
                    }
                    startActivityForResult(intent, saveRequest)
                } catch (error: Exception) {
                    pendingResult = null
                    pendingBytes = null
                    result.error("save_unavailable", "Não foi possível abrir o local de destino.", null)
                }
            }
    }

    @Deprecated("Used for the document picker supported by FlutterActivity")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode != saveRequest) return
        val result = pendingResult ?: return
        val bytes = pendingBytes
        pendingResult = null
        pendingBytes = null
        if (resultCode != Activity.RESULT_OK || data?.data == null || bytes == null) {
            result.success(false)
            return
        }
        val uri = data.data!!
        Thread {
            try {
                contentResolver.openOutputStream(uri, "wt")?.use { it.write(bytes) }
                    ?: throw IllegalStateException("Destino indisponível")
                runOnUiThread { result.success(true) }
            } catch (error: Exception) {
                runOnUiThread { result.error("save_failed", "Não foi possível salvar a cópia.", null) }
            }
        }.start()
    }
}
