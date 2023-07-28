export interface CardProps {
  icon: string;
  title: string;
  children: React.ReactNode;
}

export function Card(props: CardProps) {
  const { icon, title, children } = props;
  return (
    <article className="w-full flex flex-col md:flex-row bg-green-500 items-center gap-8 py-8 px-[52px] border-4 border-neutral-50 rounded-3xl">
      <img src={icon} alt="icon" className="w-fit h-fit" />
      <section className="text-center flex-1 text-neutral-50">
        <h1 className="font-bold text-heading-5 md:text-heading-3 mb-4">{title}</h1>
        {children}
      </section>
    </article>
  );
}

export default Card;
