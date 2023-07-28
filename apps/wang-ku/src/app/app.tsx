import Navbar from "./components/organisms/Navbar";
import Hero from "./components/organisms/Hero"
import Feature from "./components/organisms/Feature";
import Footer from "./components/organisms/Footer";

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
