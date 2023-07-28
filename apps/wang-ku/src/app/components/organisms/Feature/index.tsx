import Card from '../../molecules/Card';
import MoneyImage from '../../../../assets/money.svg';
import CuateImage from '../../../../assets/cuate.svg';
import QRCode from '../../../../assets/qr-code.svg';

export function Feature() {
  return (
    <section
      id="fitur"
      className="flex items-center flex-col gap-8 min-h-screen py-16 px-7 md:px-32"
    >
      <h1 className="text-heading-3 md:text-heading-1 font-semibold text-black">
        Kenal lebih dekat dengan fitur WangKu
      </h1>
      <Card icon={MoneyImage} title="Pinjaman Modal Usaha">
        <p className="text-paragraph-12 md:text-paragraph-18">
          Untuk kamu pelaku usaha yang lagi <b>krisis keuangan</b>
          atau mau <b>ningkatin skala usaha</b>. Atau baru mau{' '}
          <b>memulai usaha</b>. Jangan khawatir masalah modal, tenaaang...
          <b>WangKu</b> hadir dan minjemin kamu modal
        </p>
      </Card>
      <Card icon={CuateImage} title="Catatan, Rencana, dan Laporan Keuangan">
        <p className="text-paragraph-12 md:text-paragraph-18">
          RIbet ya nyatet nyatet di buku kas? Jangan khawatir! <b>WangKu</b>{' '}
          memudahkan kamu untuk <b>catat arus kas</b>, <b>siapin rencana</b>,
          dan <b>laporan keuangan</b> khusus untukmu.
        </p>
      </Card>
      <Card icon={QRCode} title="Urus QR dengan Lebih Sederhana">
        <p className="text-paragraph-12 md:text-paragraph-18">
          Untuk kamu pelaku usaha yang lagi krisis keuangan atau mau ningkatin
          skala usaha. Atau baru mau memulai usaha. Jangan khawatir masalah
          modal, tenaaang... <b>WangKu</b> hadir dan minjemin kamu modal
        </p>
      </Card>
    </section>
  );
}

export default Feature;
