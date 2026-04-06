"use client";

import { useEffect } from "react";
import { AnimatePresence, motion } from "framer-motion";

type ImageModalProps = {
  isOpen: boolean;
  onClose: () => void;
  title?: string;
  src?: string;
  aspectClassName?: string;
  children?: React.ReactNode;
  showCloseButton?: boolean;
  showTitle?: boolean;
};

export default function ImageModal({
  isOpen,
  onClose,
  title,
  src,
  aspectClassName = "",
  children,
  showCloseButton = true,
  showTitle = true,
}: ImageModalProps) {
  useEffect(() => {
    if (!isOpen) return;

    const onKeyDown = (e: KeyboardEvent) => {
      if (e.key === "Escape") onClose();
    };

    window.addEventListener("keydown", onKeyDown);
    return () => window.removeEventListener("keydown", onKeyDown);
  }, [isOpen, onClose]);

  return (
    <AnimatePresence>
      {isOpen && (
        <>
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={onClose}
            className="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm"
          />
          <motion.div
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            exit={{ opacity: 0, scale: 0.95 }}
            transition={{ type: "spring", damping: 25 }}
            className="fixed inset-4 sm:inset-8 md:inset-16 z-50 flex items-center justify-center"
          >
            <div
              onClick={(e) => e.stopPropagation()}
              className={`relative w-full h-full max-w-4xl max-h-[85vh] rounded-card border border-border overflow-hidden bg-bg flex flex-col ${aspectClassName}`}
            >
              {(showTitle && title) || showCloseButton ? (
                <div className="flex items-center justify-between gap-3 px-4 py-3 border-b border-border bg-bg/95">
                  <div className="min-w-0 flex-1">
                    {showTitle && title ? (
                      <p className="font-mono text-xs text-text-secondary truncate">{title}</p>
                    ) : null}
                  </div>
                  {showCloseButton ? (
                    <button
                      onClick={onClose}
                      className="w-10 h-10 rounded-btn bg-bg/90 border border-border flex items-center justify-center text-text-primary hover:text-primary transition-colors"
                      aria-label="Fechar"
                      type="button"
                    >
                      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                      </svg>
                    </button>
                  ) : null}
                </div>
              ) : null}

              <div className="w-full flex-1 min-h-0">
                {children ? (
                  <div className="w-full h-full">{children}</div>
                ) : src ? (
                  <img src={src} alt={title || "Imagem"} className="w-full h-full object-contain bg-secondary" />
                ) : null}
              </div>
            </div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
}
