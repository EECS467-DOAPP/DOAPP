#ifndef MATRIX_CUH
#define MATRIX_CUH

#include "vector.cuh"

#include <cstddef>

namespace doapp {

template <typename T, std::size_t N, std::size_t M> class Matrix {
public:
  Matrix() noexcept = default;

  __host__ __device__ Matrix(std::size_t num_rows,
                             std::size_t num_cols) noexcept(noexcept(T()))
      : data_(num_rows * num_cols) {
    assert(num_rows == N);
    assert(num_cols == M);
  }

  __host__ __device__ Slice<T> operator[](std::size_t i) noexcept {
    assert(i < N);

    return {data_.data() + i * M, M};
  }

  __host__ __device__ Slice<const T> operator[](std::size_t i) const noexcept {
    assert(i < N);

    return {data_.data() + i * M, M};
  }

  __host__ __device__ Slice<T> col(std::size_t j) noexcept {
    return {data_.data() + j, N, M};
  }

  __host__ __device__ Slice<const T> col(std::size_t j) const noexcept {
    return {data_.data() + j, N, M};
  }

  __host__ __device__ std::size_t size() const noexcept { return N * M; }

  __host__ __device__ std::size_t num_rows() const noexcept { return N; }

  __host__ __device__ std::size_t num_cols() const noexcept { return M; }

  __host__ __device__ T *data() noexcept { return data_.data(); }

  __host__ __device__ const T *data() const noexcept { return data_.data(); }

  __host__ __device__ Slice<T> as_slice() noexcept { return data_.as_slice(); }

  __host__ __device__ Slice<const T> as_slice() const noexcept {
    return data_.as_slice();
  }

private:
  Vector<T, N * M> data_;
};

template <typename T> class Matrix<T, Dynamic, Dynamic> {
public:
  Matrix() noexcept = default;

  Matrix(std::size_t num_rows, std::size_t num_cols)
      : data_(num_rows * num_cols), num_rows_(num_rows), num_cols_(num_cols) {}

  __host__ __device__ Slice<T> operator[](std::size_t i) noexcept {
    assert(i < num_rows_);

    return {data_.data() + i * num_cols_, num_cols_};
  }

  __host__ __device__ Slice<const T> operator[](std::size_t i) const noexcept {
    assert(i < num_rows_);

    return {data_.data() + i * num_cols_, num_cols_};
  }

  __host__ __device__ Slice<T> col(std::size_t j) noexcept {
    return {data_.data() + j, num_rows_, num_cols_};
  }

  __host__ __device__ Slice<const T> col(std::size_t j) const noexcept {
    return {data_.data() + j, num_rows_, num_cols_};
  }

  __host__ __device__ std::size_t size() const noexcept {
    return num_rows_ * num_cols_;
  }

  __host__ __device__ std::size_t num_rows() const noexcept {
    return num_rows_;
  }

  __host__ __device__ std::size_t num_cols() const noexcept {
    return num_cols_;
  }

  __host__ __device__ T *data() noexcept { return data_.data(); }

  __host__ __device__ const T *data() const noexcept { return data_.data(); }

  __host__ __device__ Slice<T> as_slice() noexcept { return data_.as_slice(); }

  __host__ __device__ Slice<const T> as_slice() const noexcept {
    return data_.as_slice();
  }

private:
  Vector<T, Dynamic> data_;
  std::size_t num_rows_ = 0;
  std::size_t num_cols_ = 0;
};

template <typename T, std::size_t N> class Matrix<T, N, Dynamic> {
public:
  Matrix() noexcept = default;

  Matrix(std::size_t num_rows, std::size_t num_cols)
      : data_(N * num_cols), num_cols_(num_cols) {
    assert(num_rows == N);
  }

  __host__ __device__ Slice<T> operator[](std::size_t i) noexcept {
    assert(i < N);

    return {data_.data() + i * num_cols_, num_cols_};
  }

  __host__ __device__ Slice<const T> operator[](std::size_t i) const noexcept {
    assert(i < N);

    return {data_.data() + i * num_cols_, num_cols_};
  }

  __host__ __device__ Slice<T> col(std::size_t j) noexcept {
    return {data_.data() + j, N, num_cols_};
  }

  __host__ __device__ Slice<const T> col(std::size_t j) const noexcept {
    return {data_.data() + j, N, num_cols_};
  }

  __host__ __device__ std::size_t size() const noexcept {
    return N * num_cols_;
  }

  __host__ __device__ std::size_t num_rows() const noexcept { return N; }

  __host__ __device__ std::size_t num_cols() const noexcept {
    return num_cols_;
  }

  __host__ __device__ T *data() noexcept { return data_.data(); }

  __host__ __device__ const T *data() const noexcept { return data_.data(); }

  __host__ __device__ Slice<T> as_slice() noexcept { return data_.as_slice(); }

  __host__ __device__ Slice<const T> as_slice() const noexcept {
    return data_.as_slice();
  }

private:
  Vector<T, Dynamic> data_;
  std::size_t num_cols_ = 0;
};

template <typename T, std::size_t M> class Matrix<T, Dynamic, M> {
public:
  Matrix() noexcept = default;

  Matrix(std::size_t num_rows, std::size_t num_cols)
      : data_(num_rows * M), num_rows_(num_rows) {
    assert(num_cols == M);
  }

  __host__ __device__ Slice<T> operator[](std::size_t i) noexcept {
    assert(i < num_rows_);

    return {data_.data() + i * M, M};
  }

  __host__ __device__ Slice<const T> operator[](std::size_t i) const noexcept {
    assert(i < num_rows_);

    return {data_.data() + i * M, M};
  }

  __host__ __device__ Slice<T> col(std::size_t j) noexcept {
    return {data_.data() + j, num_rows_, M};
  }

  __host__ __device__ Slice<const T> col(std::size_t j) const noexcept {
    return {data_.data() + j, num_rows_, M};
  }

  __host__ __device__ std::size_t size() const noexcept {
    return num_rows_ * M;
  }

  __host__ __device__ std::size_t num_rows() const noexcept {
    return num_rows_;
  }

  __host__ __device__ std::size_t num_cols() const noexcept { return M; }

  __host__ __device__ T *data() noexcept { return data_.data(); }

  __host__ __device__ const T *data() const noexcept { return data_.data(); }

  __host__ __device__ Slice<T> as_slice() noexcept { return data_.as_slice(); }

  __host__ __device__ Slice<const T> as_slice() const noexcept {
    return data_.as_slice();
  }

private:
  Vector<T, Dynamic> data_;
  std::size_t num_rows_ = 0;
};

template <typename T, std::size_t N, std::size_t M>
__host__ __device__ Matrix<T, N, M>
operator+(const Matrix<T, N, M> &a,
          const Matrix<T, N, M> &b) noexcept(noexcept(Matrix<T, N, M>(0, 0))) {
  assert(a.num_rows() == b.num_rows());
  assert(b.num_cols() == b.num_cols());

  const std::size_t n = a.num_rows();
  const std::size_t m = a.num_cols();

  Matrix<T, N, M> c(n, m);

  for (std::size_t i = 0; i < n; ++i) {
    const auto this_row_a = a[i];
    const auto this_row_b = b[i];
    const auto this_row_c = c[i];

    for (std::size_t j = 0; j < m; ++j) {
      this_row_c[j] = this_row_a[j] + this_row_b[j];
    }
  }

  return c;
}

template <typename T, std::size_t N, std::size_t M>
__host__ __device__ Matrix<T, N, M>
operator-(const Matrix<T, N, M> &a,
          const Matrix<T, N, M> &b) noexcept(noexcept(Matrix<T, N, M>(0, 0))) {
  assert(a.num_rows() == b.num_rows());
  assert(b.num_cols() == b.num_cols());

  const std::size_t n = a.num_rows();
  const std::size_t m = a.num_cols();

  Matrix<T, N, M> c(n, m);

  for (std::size_t i = 0; i < n; ++i) {
    const auto this_row_a = a[i];
    const auto this_row_b = b[i];
    const auto this_row_c = c[i];

    for (std::size_t j = 0; j < m; ++j) {
      this_row_c[j] = this_row_a[j] - this_row_b[j];
    }
  }

  return c;
}

template <typename T, std::size_t N, std::size_t M, std::size_t P>
__host__ __device__ Matrix<T, N, P>
operator*(const Matrix<T, N, M> &a,
          const Matrix<T, M, P> &b) noexcept(noexcept(Matrix<T, N, P>(0, 0)) &&
                                             noexcept(Matrix<T, P, M>(0, 0))) {
  assert(a.num_cols() == b.num_rows());

  const std::size_t n = a.num_rows();
  const std::size_t m = a.num_cols();
  const std::size_t p = b.num_cols();

  Matrix<T, P, M> b_tr(p, m);

  for (std::size_t i = 0; i < p; ++i) {
    const auto this_col_tr = b_tr[i];
    const auto this_col = b.col(i);

    for (std::size_t j = 0; j < m; ++j) {
      this_col_tr[j] = this_col[j];
    }
  }

  Matrix<T, N, P> c(n, p);

  for (std::size_t i = 0; i < n; ++i) {
    const auto this_row_c = c[i];
    const auto this_row_a = a[i];

    for (std::size_t j = 0; j < p; ++j) {
      auto &this_elem_c = this_row_c[j];
      const auto this_col_b = b_tr[j];

      for (std::size_t k = 0; k < m; ++k) {
        this_elem_c += this_row_a[k] * this_col_b[k];
      }
    }
  }

  return c;
}

template <typename T, std::size_t N, std::size_t M>
__host__ __device__ Vector<T, N>
operator*(const Matrix<T, N, M> &a,
          const Vector<T, M> &v) noexcept(noexcept(Vector<T, N>(0))) {
  assert(a.num_cols() == v.size());

  const std::size_t n = a.num_rows();
  const std::size_t m = a.num_cols();

  Vector<T, N> u(n);

  for (std::size_t i = 0; i < n; ++i) {
    auto &this_elem_u = u[i];
    const auto this_row_a = a[i];

    for (std::size_t j = 0; j < m; ++j) {
      this_elem_u += this_row_a[j];
    }
  }

  return u;
}

} // namespace doapp

#endif
