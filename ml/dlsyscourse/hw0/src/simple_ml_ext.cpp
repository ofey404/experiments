#include <pybind11/pybind11.h>
#include <pybind11/numpy.h>
#include <cmath>
#include <iostream>

namespace py = pybind11;


void softmax_regression_epoch_cpp(const float *X, const unsigned char *y,
								  float *theta, size_t m, size_t n, size_t k,
								  float lr, size_t batch)
{
    /**
     * A C++ version of the softmax regression epoch code.  This should run a
     * single epoch over the data defined by X and y (and sizes m,n,k), and
     * modify theta in place.  Your function will probably want to allocate
     * (and then delete) some helper arrays to store the logits and gradients.
     *
     * Args:
     *     X (const float *): pointer to X data, of size m*n, stored in row
     *          major (C) format
     *     y (const unsigned char *): pointer to y data, of size m
     *     theta (float *): pointer to theta data, of size n*k, stored in row
     *          major (C) format
     *     m (size_t): number of examples
     *     n (size_t): input dimension
     *     k (size_t): number of classes
     *     lr (float): learning rate / SGD step size
     *     batch (int): SGD minibatch size
     *
     * Returns:
     *     (None)
     */

    /// BEGIN YOUR CODE

    // TODO(ofey404): This is a non-vectorize version.
    //                I use chatgpt to generate this coarse code, but it can pass the test.
    //                As this code imports pybind11/numpy.h, there must be some vectorize shorthand,
    //                by using numpy features. I will try to find it later, but now I gonna move on.

    // Allocate memory for matrix multiplication and gradient
    float* scores = new float[m*k];
    float* grad = new float[n*k];

    // Initialize to zero
    std::fill_n(scores, m*k, 0.0f);
    std::fill_n(grad, n*k, 0.0f);

    for (size_t i = 0; i < m; i += batch) {
        for (size_t j = 0; j < batch; ++j) {
            // Calculate scores for each class
            for (size_t c = 0; c < k; ++c) {
                for (size_t d = 0; d < n; ++d) {
                    scores[(i+j)*k + c] += X[(i+j)*n + d] * theta[d*k + c];
                }
            }

            // Compute softmax scores
            float max_score = *std::max_element(scores+(i+j)*k, scores+(i+j+1)*k);
            float sum_exp_scores = 0.0f;

            for (size_t c = 0; c < k; ++c) {
                scores[(i+j)*k + c] = std::exp(scores[(i+j)*k + c] - max_score);
                sum_exp_scores += scores[(i+j)*k + c];
            }

            for (size_t c = 0; c < k; ++c) {
                scores[(i+j)*k + c] /= sum_exp_scores;
            }

            // Compute the gradient
            for (size_t c = 0; c < k; ++c) {
                float target = (c == y[i+j]) ? 1.0f : 0.0f;
                float error = scores[(i+j)*k + c] - target;

                for (size_t d = 0; d < n; ++d) {
                    grad[d*k + c] += X[(i+j)*n + d] * error;
                }
            }
        }

        // Update theta using the gradients
        for (size_t d = 0; d < n*k; ++d) {
            theta[d] -= lr * grad[d] / batch;
        }

        // Reset gradient for the next batch
        std::fill_n(grad, n*k, 0.0f);
    }

    delete[] scores;
    delete[] grad;
    /// END YOUR CODE
}


/**
 * This is the pybind11 code that wraps the function above.  It's only role is
 * wrap the function above in a Python module, and you do not need to make any
 * edits to the code
 */
PYBIND11_MODULE(simple_ml_ext, m) {
    m.def("softmax_regression_epoch_cpp",
    	[](py::array_t<float, py::array::c_style> X,
           py::array_t<unsigned char, py::array::c_style> y,
           py::array_t<float, py::array::c_style> theta,
           float lr,
           int batch) {
        softmax_regression_epoch_cpp(
        	static_cast<const float*>(X.request().ptr),
            static_cast<const unsigned char*>(y.request().ptr),
            static_cast<float*>(theta.request().ptr),
            X.request().shape[0],
            X.request().shape[1],
            theta.request().shape[1],
            lr,
            batch
           );
    },
    py::arg("X"), py::arg("y"), py::arg("theta"),
    py::arg("lr"), py::arg("batch"));
}
