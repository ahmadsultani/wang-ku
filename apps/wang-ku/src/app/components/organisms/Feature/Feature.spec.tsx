import { render } from '@testing-library/react';

import Feature from '.';

describe('Feature', () => {
  it('should render successfully', () => {
    const { baseElement } = render(<Feature />);
    expect(baseElement).toBeTruthy();
  });
});
