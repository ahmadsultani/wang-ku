import Logo from '../../../../assets/logo.svg';
import LogoLabel from '../../../../assets/logo-label.svg';
import PrimaryButton from '../../atoms/PrimaryButton';

export function Navbar() {
  return (
    <nav className="md:sticky z-50 top-0 w-full flex justify-between py-6 bg-neutral-50 px-7 md:px-24 xl:px-32">
      <section className="flex items-center gap-2">
        <img src={Logo} alt="logo" className="w-16 h-[45px]" />
        <img src={LogoLabel} alt="logo-label" className="" />
      </section>
      <section className="hidden md:flex items-center justify-end gap-8 font-semibold ">
        <a href="/#beranda">Beranda</a>
        <a href="/#fitur">Fitur</a>
        <PrimaryButton>
          <a href="https://github.com/excalios/wang-ku">Unduh WangKu</a>
        </PrimaryButton>
      </section>
    </nav>
  );
}

export default Navbar;
