import { initializeApp, getApps } from "firebase/app"
import { getAuth } from "firebase/auth"
import { getFirestore } from "firebase/firestore"

// ============================================================
// FIREBASE CONFIGURATION
// ============================================================
// Replace the values below with your Firebase project config.
// You can find these in your Firebase Console:
// 1. Go to https://console.firebase.google.com/
// 2. Select your project (or create one)
// 3. Click the gear icon (Settings) > Project settings
// 4. Scroll down to "Your apps" and select your web app
// 5. Copy the firebaseConfig object values
// ============================================================

const firebaseConfig = {
  apiKey: process.env.NEXT_PUBLIC_FIREBASE_API_KEY || "YOUR_API_KEY",
  authDomain: process.env.NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN || "YOUR_AUTH_DOMAIN",
  projectId: process.env.NEXT_PUBLIC_FIREBASE_PROJECT_ID || "YOUR_PROJECT_ID",
  storageBucket: process.env.NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET || "YOUR_STORAGE_BUCKET",
  messagingSenderId: process.env.NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID || "YOUR_MESSAGING_SENDER_ID",
  appId: process.env.NEXT_PUBLIC_FIREBASE_APP_ID || "YOUR_APP_ID",
}

// Initialize Firebase (prevent re-initialization on hot reload)
const app = getApps().length === 0 ? initializeApp(firebaseConfig) : getApps()[0]

// Export Firebase services
export const auth = getAuth(app)
export const db = getFirestore(app)
export default app
