import Feature from './components/organisms/Feature';
import Footer from './components/organisms/Footer';
import Hero from './components/organisms/Hero';
import Navbar from './components/organisms/Navbar';

export function App() {
  return (
    <main className="max-w-screen">
      <Navbar />
      <Hero />
      <Feature />
      <Footer />
    </main>
  );
}

export default App;
