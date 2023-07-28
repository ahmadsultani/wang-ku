export interface PrimaryButtonProps {
  children: React.ReactNode;
  className?: string;
}

export function PrimaryButton(props: PrimaryButtonProps) {
  const { children, className } = props;
  return (
    <button className={`rounded-3xl text-neutral-50 bg-green-500 px-4 py-2 ${className}`}>
      {children}
    </button>
  )
}

export default PrimaryButton;
