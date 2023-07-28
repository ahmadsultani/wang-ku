import { render } from '@testing-library/react';

import { PrimaryButton } from '.';

describe('PrimaryButton', () => {
  it('should have children', () => {
    const { getByText } = render(
      <PrimaryButton>
        <a href="/#tentang">Unduh WangKu</a>
      </PrimaryButton>
    );
    expect(getByText('Unduh WangKu')).toBeTruthy();
  });

  it('should render successfully', () => {
    const { baseElement } = render(<PrimaryButton children={undefined} />);
    expect(baseElement).toBeTruthy();
  });
});
