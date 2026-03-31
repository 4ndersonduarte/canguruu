"use client";

import { motion, AnimatePresence } from "framer-motion";

type VideoModalProps = {
  isOpen: boolean;
  onClose: () => void;
  videoUrl?: string; // YouTube embed URL
};

export default function VideoModal({ isOpen, onClose, videoUrl }: VideoModalProps) {
  const embedUrl = videoUrl || "https://www.youtube.com/embed/dQw4w9WgXcQ?autoplay=1";

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
            <div className="relative w-full max-w-4xl aspect-video rounded-card border border-border overflow-hidden bg-bg">
              <button
                onClick={onClose}
                className="absolute top-3 right-3 z-10 w-10 h-10 rounded-btn bg-bg/90 border border-border flex items-center justify-center text-text-primary hover:text-primary transition-colors"
                aria-label="Fechar"
              >
                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
              <iframe
                src={embedUrl}
                title="Vídeo"
                className="w-full h-full"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowFullScreen
              />
            </div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
}
