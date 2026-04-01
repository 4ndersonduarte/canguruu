"use client";

import { useState, useEffect } from "react";

export function useTheme() {
  const [isDark, setIsDark] = useState(false);

  useEffect(() => {
    // Função para determinar se deve ser modo escuro baseado no horário
    const checkTimeBasedTheme = () => {
      const hour = new Date().getHours();
      // Modo escuro das 18h (6pm) às 6h (6am)
      const shouldBeDark = hour >= 18 || hour < 6;
      setIsDark(shouldBeDark);
    };

    // Verificar imediatamente
    checkTimeBasedTheme();

    // Verificar a cada minuto para transição suave
    const interval = setInterval(checkTimeBasedTheme, 60000);

    return () => clearInterval(interval);
  }, []);

  return { isDark };
}
