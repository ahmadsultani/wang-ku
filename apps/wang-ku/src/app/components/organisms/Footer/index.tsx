import Logo from '../../../../assets/logo.svg';
import LogoLabel from '../../../../assets/logo-label.svg';

export function Footer() {
  return (
    <footer>
      <header className="py-[52px] bg-green-50 flex flex-col-reverse md:flex-row justify-center items-start md:items-center gap-[52px] px-7">
        <section className="md:w-5/12">
          <h1 className="text-heading-3 xl:text-heading-1 text-black font-semibold">
            Tunggu apa lagi?
          </h1>
          <h4 className="mt-4 xl:mt-8 text-paragraph-18 xl:text-heading-4 text-neutral-600 font-medium">
            <span className="text-green-500">Coba WangKu sekarang</span>, mulai
            dan kembangkan usahamu tanpa khawatir akan masalah dana.
          </h4>
        </section>

        <section className="hidden md:flex flex-col gap-3 items-center">
          <img src={Logo} alt="logo" className="w-36 flex-1" />
          <img src={LogoLabel} alt="logo-label" className="w-full" />
        </section>
      </header>

      <main className="py-[52px] px-7 md:px-24 lg:px-32 bg-neutral-50 ">
        <section className="flex justify-between items-start flex-col md:flex-row gap-y-8">
          <div className="flex items-center gap-2">
            <img src={Logo} alt="logo" className="w-16 h-[45px]" />
            <img src={LogoLabel} alt="logo-label" className="" />
          </div>
          <div className="flex flex-col gap-4 md:gap-2 text-label-18 font-medium">
            <a href="/#">Beranda</a>
            <a href="/#">Fitur</a>
          </div>
        </section>

        <p className="text-paragraph-16 text-neutral-600 mt-8 md:mt-4">©WangKu, Kampus Ayam 2023</p>
      </main>
    </footer>
  );
}

export default Footer;
