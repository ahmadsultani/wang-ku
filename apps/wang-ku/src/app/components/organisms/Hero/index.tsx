import Background from '../../../../assets/background.svg';
import PrimaryButton from '../../atoms/PrimaryButton';

export function Hero() {
  return (
    <section
      id="beranda"
      className="relative h-screen max-h-[100vh] flex items-center gap-11 px-7 md:px-24 xl:px-32 font-semibold overflow-hidden"
    >
      <div className="lg:w-2/3">
        <h4 className="text-heading-5 md:text-heading-4 text-neutral-600">
          Atur keuangan pakai Wangku!
        </h4>
        <h1 className="text-heading-2 sm:text-heading-1 xl:text-display mt-4">
          <span className="text-green-500">Mulai</span> dan{' '}
          <span className="text-green-500">kembangkan</span> usahamu bersama
          kami.
        </h1>
        <PrimaryButton className="mt-8 px-6">
          <a className="text-heading-4 md:text-heading-3" href="/#">
            Unduh WangKu
          </a>
        </PrimaryButton>
      </div>
      <img
        src={Background}
        alt="background"
        className="hidden lg:block absolute -right-20 xl:right-0 top-0 h-screen -z-0"
      />
    </section>
  );
}

export default Hero;
