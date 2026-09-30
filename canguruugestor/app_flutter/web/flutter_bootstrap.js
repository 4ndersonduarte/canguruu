{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  serviceWorkerSettings: { serviceWorkerVersion: {{flutter_service_worker_version}} },
  onEntrypointLoaded: async (engineInitializer) => {
    const runner = await engineInitializer.initializeEngine({
      fontFallbackBaseUrl: new URL('fonts/', document.baseURI).href
    });
    await runner.runApp();
    document.getElementById('loading')?.remove();
  }
});
