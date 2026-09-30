import Header from "@/components/Header";
import Hero from "@/components/Hero";
import Services from "@/components/Services";
import ClientsStories from "@/components/ClientsStories";
import LogosSection from "@/components/LogosSection";
import WorksGallery from "@/components/WorksGallery";
import Contact from "@/components/Contact";
import Plans from "@/components/Plans";
import WebsiteSection from "@/components/WebsiteSection";
import Footer from "@/components/Footer";

export default function Home() {
  return (
    <main className="min-h-screen">
      <Header />
      <Hero />
      <Services />
      <ClientsStories />
      <LogosSection />
      <WorksGallery />
      <WebsiteSection />
      <Plans />
      <Contact />
      <Footer />
    </main>
  );
}
