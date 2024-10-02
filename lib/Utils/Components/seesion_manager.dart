class SessionManager {
  static String currentScreen = "";
  static String previousScreen = "";

  static void setCurrentScreen(String screen) {
    currentScreen = screen;
  }

  static String getCurrentScreen() {
    return currentScreen;
  }

  static void setPreviousScreen(String screen) {
    previousScreen = screen;
  }

  static String getPreviousScreen() {
    return previousScreen;
  }
}
