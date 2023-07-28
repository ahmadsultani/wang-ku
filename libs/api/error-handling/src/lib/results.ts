import { R } from '@mobily/ts-belt';

export { R } from '@mobily/ts-belt';

export type AppError<E> = {
  message: string;
  reason?: string;
  translate?: { ind: string; eng: string };
  data?: E;
};

export type AppResult<T> = R.Result<T, AppError<undefined>>;
export type AppResultWithData<T, D> = R.Result<T, AppError<D>>;

export function toAppError<T>(obj: T): AppError<undefined> {
  return {
    message: 'Oops! Something went wrong!',
    reason: `${obj}`,
  };
}

