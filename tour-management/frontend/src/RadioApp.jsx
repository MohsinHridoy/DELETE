import React, { useMemo, useRef, useState } from "react";
import styles from "./radio.module.css";

function RadioApp() {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [isPlaying, setIsPlaying] = useState(false);
  const audioRef = useRef(null);

  const streamUrl = useMemo(() => {
    // Placeholder stream. Replace with your radio stream URL.
    return "https://icecast.radiofrance.fr/fiprap.db320.mp3";
  }, []);

  const togglePlay = () => {
    const audio = audioRef.current;
    if (!audio) return;
    if (isPlaying) {
      audio.pause();
      setIsPlaying(false);
      return;
    }
    audio.play().then(() => setIsPlaying(true)).catch(() => {});
  };

  return (
    <div className={styles.wrapper}>
      <audio ref={audioRef} src={streamUrl} preload="none" />

      <div className={styles.screen}>
        <header className={styles.header}>
          <button
            aria-label="Open menu"
            className={styles.hamburger}
            onClick={() => setIsMenuOpen(true)}
          >
            <span />
            <span />
            <span />
          </button>
        </header>

        <main className={styles.content}>
          <div className={styles.artworkShell}>
            <div className={styles.artwork} />
          </div>
          <h3 className={styles.title}>Cleara Radio Online</h3>
          <div className={styles.subtitle}>Now Playing</div>
        </main>

        <footer className={styles.footer}>
          <button
            className={styles.playButton}
            onClick={togglePlay}
            aria-label={isPlaying ? "Pause" : "Play"}
          >
            {isPlaying ? (
              <div className={styles.pauseIcon} />
            ) : (
              <div className={styles.playIcon} />
            )}
          </button>
        </footer>
      </div>

      <aside className={`${styles.drawer} ${isMenuOpen ? styles.open : ""}`}>
        <div className={styles.drawerHeader}>
          <button
            className={styles.drawerHandle}
            aria-label="Close menu"
            onClick={() => setIsMenuOpen(false)}
          />
        </div>
        <nav className={styles.drawerNav}>
          <a href="#">Player</a>
          <a href="#">About App</a>
          <a href="#">Terms</a>
          <a href="#">Privacy</a>
          <a href="#">Disclaimer</a>
          <a href="#">Contact</a>
        </nav>
      </aside>

      {isMenuOpen && (
        <div className={styles.scrim} onClick={() => setIsMenuOpen(false)} />
      )}
    </div>
  );
}

export default RadioApp;

