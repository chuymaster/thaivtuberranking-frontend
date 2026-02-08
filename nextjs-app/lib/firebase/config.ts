import { initializeApp, getApps } from 'firebase/app';
import { getAuth, GoogleAuthProvider } from 'firebase/auth';
import { env } from '../env';

const prodConfig = {
  apiKey: 'AIzaSyCoKcVbXJL9qo-OggKxLz1sIfqQhLvdkBo',
  appId: '1:492764029487:web:071f103c42928b7e405cda',
  messagingSenderId: '492764029487',
  projectId: 'thaivtuberranking',
  authDomain: 'thaivtuberranking.firebaseapp.com',
  databaseURL: 'https://thaivtuberranking.firebaseio.com',
  storageBucket: 'thaivtuberranking.appspot.com',
  measurementId: 'G-4QDH9NFZ2Z',
};

const devConfig = {
  apiKey: 'AIzaSyAUeGTBjrwi4JSvDkA_pxQ3vdFeNVjPakk',
  appId: '1:190320569435:web:f73046c513f5bbf941237e',
  messagingSenderId: '190320569435',
  projectId: 'thaivtuberranking-dev',
  authDomain: 'thaivtuberranking-dev.firebaseapp.com',
  storageBucket: 'thaivtuberranking-dev.appspot.com',
};

const firebaseConfig = env.isProduction ? prodConfig : devConfig;

// Initialize Firebase
const app = getApps().length === 0 ? initializeApp(firebaseConfig) : getApps()[0];
const auth = getAuth(app);
const googleProvider = new GoogleAuthProvider();

export { app, auth, googleProvider };
