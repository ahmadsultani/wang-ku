import { render } from '@testing-library/react';

import Card from '.';

describe('Card', () => {
  it('should have children', () => {
    const { getByText } = render(
      <Card
        icon="/assets/images/illustrations/illustration-1.png"
        title="Mudah digunakan"
      >
        <p className="mt-8 text-heading-5">
          Wangku sangat mudah digunakan, bahkan untuk pemula sekalipun
        </p>
      </Card>
    );
    expect(getByText('Mudah digunakan')).toBeTruthy();
  });

  it('should render successfully', () => {
    const { baseElement } = render(
      <Card icon="" title="" children={undefined} />
    );
    expect(baseElement).toBeTruthy();
  });
});
