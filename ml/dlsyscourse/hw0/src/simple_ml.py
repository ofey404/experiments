import struct
import numpy as np
import gzip
try:
    from simple_ml_ext import *
except:
    pass


def add(x, y):
    """ A trivial 'add' function you should implement to get used to the
    autograder and submission system.  The solution to this problem is in the
    the homework notebook.

    Args:
        x (Python number or numpy array)
        y (Python number or numpy array)

    Return:
        Sum of x + y
    """
    ### BEGIN YOUR CODE
    return x + y
    ### END YOUR CODE


def parse_mnist(image_filename, label_filename):
    """ Read an images and labels file in MNIST format.  See this page:
    http://yann.lecun.com/exdb/mnist/ for a description of the file format.

    Args:
        image_filename (str): name of gzipped images file in MNIST format
        label_filename (str): name of gzipped labels file in MNIST format

    Returns:
        Tuple (X,y):
            X (numpy.ndarray[np.float32]): 2D numpy array containing the loaded 
                data.  The dimensionality of the data should be 
                (num_examples x input_dim) where 'input_dim' is the full 
                dimension of the data, e.g., since MNIST images are 28x28, it 
                will be 784.  Values should be of type np.float32, and the data 
                should be normalized to have a minimum value of 0.0 and a 
                maximum value of 1.0 (i.e., scale original values of 0 to 0.0 
                and 255 to 1.0).

            y (numpy.ndarray[dtype=np.uint8]): 1D numpy array containing the
                labels of the examples.  Values should be of type np.uint8 and
                for MNIST will contain the values 0-9.
    """
    ### BEGIN YOUR CODE
    with gzip.open(label_filename, 'rb') as lbpath:
        labels = np.frombuffer(lbpath.read(), dtype=np.uint8, offset=8)

    with gzip.open(image_filename, 'rb') as imgpath:
        images = np.frombuffer(
            imgpath.read(), dtype=np.uint8, offset=16).reshape(len(labels), 784)

    return images.astype(np.float32) / 255.0, labels
    ### END YOUR CODE


def softmax_loss(Z, y):
    """ Return softmax loss.  Note that for the purposes of this assignment,
    you don't need to worry about "nicely" scaling the numerical properties
    of the log-sum-exp computation, but can just compute this directly.

    Args:
        Z (np.ndarray[np.float32]): 2D numpy array of shape
            (batch_size, num_classes), containing the logit predictions for
            each class.
        y (np.ndarray[np.uint8]): 1D numpy array of shape (batch_size, )
            containing the true label of each example.

    Returns:
        Average softmax loss over the sample.
    """
    ### BEGIN YOUR CODE
    # logit -> probability
    exp_Z = np.exp(Z - np.max(Z, axis=1, keepdims=True))  # shift to avoid overflow
    # exp_Z = np.exp(Z) # no-shift version
    softmax = exp_Z / np.sum(exp_Z, axis=1, keepdims=True)
    #
    # SEE ./2-shift-invariant.excalidraw
    #
    # The np.max(Z, axis=1, keepdims=True) is a technique used to improve
    # numerical stability when performing the softmax computation.
    #
    # The softmax function involves exponentiating the logits, which can result
    # in very large numbers if the logits are also large. This can lead to
    # numerical instability, causing NaN (Not a Number) results.
    #
    # By subtracting the maximum logit from all logits for each sample, we
    # ensure that the maximum value being exponentiated is 0 (since exp(0) = 1).
    # This prevents the generation of overly large numbers when taking the
    # exponent and helps to maintain numerical stability.
    #
    # This trick does not change the result of the softmax function, because
    # softmax is shift-invariant (i.e., adding or subtracting a constant from
    # the input does not change the output probabilities).

    # compare with true label to get the cross entropy loss
    num_samples = Z.shape[0]
    losses = -np.log(softmax[np.arange(num_samples), y])  # select the correct probability, the apply log
                                                          # numpy 2D array indexing syntax here.

    # Compute average loss
    average_loss = np.mean(losses)

    return average_loss
    ### END YOUR CODE


def softmax_regression_epoch(X, y, theta, lr = 0.1, batch=100):
    """ Run a single epoch of SGD for softmax regression on the data, using
    the step size lr and specified batch size.  This function should modify the
    theta matrix in place, and you should iterate through batches in X _without_
    randomizing the order.

    Args:
        X (np.ndarray[np.float32]): 2D input array of size
            (num_examples x input_dim).
        y (np.ndarray[np.uint8]): 1D class label array of size (num_examples,)
        theta (np.ndarrray[np.float32]): 2D array of softmax regression
            parameters, of shape (input_dim, num_classes)
        lr (float): step size (learning rate) for SGD
        batch (int): size of SGD minibatch

    Returns:
        None
    """
    ### BEGIN YOUR CODE
    num_samples, num_features = X.shape
    num_classes = theta.shape[1]

    for i in range(0, num_samples, batch):
        # Get the current batch of examples
        X_batch = X[i:i+batch]
        y_batch = y[i:i+batch]

        # Compute the softmax scores
        scores = X_batch.dot(theta)
        exp_scores = np.exp(scores)
        probs = exp_scores / np.sum(exp_scores, axis=1, keepdims=True)

        # Compute the gradient
        correct_class_probs = probs[np.arange(len(y_batch)), y_batch]
        loss = -np.log(correct_class_probs)
        dscores = probs
        dscores[np.arange(len(y_batch)), y_batch] -= 1
        dtheta = X_batch.T.dot(dscores)

        # Update the parameters
        theta -= lr * dtheta / batch

    ### END YOUR CODE

def nn_single_layer_epoch(X, y, W, lr = 0.1, batch=100):
    """A simplified version of nn_epoch()
    ofey404: I create this to debug the actual nn_epoch().

    This function run SGD on a single layer neural network:

    logits = x @ W1
    """
    num_samples, num_features = X.shape
    num_classes = W.shape[1]
    
    for i in range(0, num_samples, batch):
        # Get the current batch of examples
        X_batch = X[i:i+batch]
        y_batch = y[i:i+batch]

        # Forward pass: compute the logits
        scores = X_batch @ W

        # Compute the softmax probabilities and loss
        exp_scores = np.exp(scores)
        probs = exp_scores / np.sum(exp_scores, axis=1, keepdims=True)
        correct_class_probs = probs[np.arange(len(y_batch)), y_batch]
        loss = -np.log(correct_class_probs)

        # Backward pass: compute the gradients
        dscores = probs
        dscores[np.arange(len(y_batch)), y_batch] -= 1

        # Backpropagate the gradient to the parameters (W1 and W2)
        dW = X_batch.T @ dscores

        # Update the weights using the gradients
        W -= lr * dW / batch  # remember to divide by the batch size


def nn_epoch(X, y, W1, W2, lr = 0.1, batch=100):
    """ Run a single epoch of SGD for a two-layer neural network defined by the
    weights W1 and W2 (with no bias terms):
        logits = ReLU(X * W1) * W2
    The function should use the step size lr, and the specified batch size (and
    again, without randomizing the order of X).  It should modify the
    W1 and W2 matrices in place.

    Args:
        X (np.ndarray[np.float32]): 2D input array of size
            (num_examples x input_dim).
        y (np.ndarray[np.uint8]): 1D class label array of size (num_examples,)
        W1 (np.ndarray[np.float32]): 2D array of first layer weights, of shape
            (input_dim, hidden_dim)
        W2 (np.ndarray[np.float32]): 2D array of second layer weights, of shape
            (hidden_dim, num_classes)
        lr (float): step size (learning rate) for SGD
        batch (int): size of SGD minibatch

    Returns:
        None
    """
    ### BEGIN YOUR CODE
    num_samples, num_features = X.shape
    num_classes = W2.shape[1]
    
    for i in range(0, num_samples, batch):
        print("function:")
        # Get the current batch of examples
        X_batch = X[i:i+batch]
        y_batch = y[i:i+batch]

        # Forward pass: compute the logits
        hidden = np.maximum(0, X_batch @ W1) # ReLU activation
        scores = hidden @ W2

        print(f"prediction: {scores}")

        # Compute the softmax probabilities and loss
        exp_scores = np.exp(scores)
        probs = exp_scores / np.sum(exp_scores, axis=1, keepdims=True)
        correct_class_probs = probs[np.arange(len(y_batch)), y_batch]
        loss = -np.log(correct_class_probs)

        # Backward pass: compute the gradients
        dscores = probs
        dscores[np.arange(len(y_batch)), y_batch] -= 1

        # Backpropagate the gradient to the parameters (W1 and W2)
        dW2 = hidden.T @ dscores
        dhidden = dscores @ W2.T
        dhidden[X_batch @ W1 <= 0] = 0  # backpropagate through the ReLU non-linearity
        dW1 = X_batch.T @ dhidden

        print(f"dW1: {dW1}")
        print(f"dW2: {dW2}")

        # Update the weights using the gradients
        W1 -= lr * dW1 / batch
        W2 -= lr * dW2 / batch
    ### END YOUR CODE



### CODE BELOW IS FOR ILLUSTRATION, YOU DO NOT NEED TO EDIT

def loss_err(h,y):
    """ Helper funciton to compute both loss and error"""
    return softmax_loss(h,y), np.mean(h.argmax(axis=1) != y)


def train_softmax(X_tr, y_tr, X_te, y_te, epochs=10, lr=0.5, batch=100,
                  cpp=False):
    """ Example function to fully train a softmax regression classifier """
    theta = np.zeros((X_tr.shape[1], y_tr.max()+1), dtype=np.float32)
    print("| Epoch | Train Loss | Train Err | Test Loss | Test Err |")
    for epoch in range(epochs):
        if not cpp:
            softmax_regression_epoch(X_tr, y_tr, theta, lr=lr, batch=batch)
        else:
            softmax_regression_epoch_cpp(X_tr, y_tr, theta, lr=lr, batch=batch)
        train_loss, train_err = loss_err(X_tr @ theta, y_tr)
        test_loss, test_err = loss_err(X_te @ theta, y_te)
        print("|  {:>4} |    {:.5f} |   {:.5f} |   {:.5f} |  {:.5f} |"\
              .format(epoch, train_loss, train_err, test_loss, test_err))


def train_nn(X_tr, y_tr, X_te, y_te, hidden_dim = 500,
             epochs=10, lr=0.5, batch=100):
    """ Example function to train two layer neural network """
    n, k = X_tr.shape[1], y_tr.max() + 1
    np.random.seed(0)
    W1 = np.random.randn(n, hidden_dim).astype(np.float32) / np.sqrt(hidden_dim)
    W2 = np.random.randn(hidden_dim, k).astype(np.float32) / np.sqrt(k)

    print("| Epoch | Train Loss | Train Err | Test Loss | Test Err |")
    for epoch in range(epochs):
        nn_epoch(X_tr, y_tr, W1, W2, lr=lr, batch=batch)
        train_loss, train_err = loss_err(np.maximum(X_tr@W1,0)@W2, y_tr)
        test_loss, test_err = loss_err(np.maximum(X_te@W1,0)@W2, y_te)
        print("|  {:>4} |    {:.5f} |   {:.5f} |   {:.5f} |  {:.5f} |"\
              .format(epoch, train_loss, train_err, test_loss, test_err))



if __name__ == "__main__":
    X_tr, y_tr = parse_mnist("data/train-images-idx3-ubyte.gz",
                             "data/train-labels-idx1-ubyte.gz")
    X_te, y_te = parse_mnist("data/t10k-images-idx3-ubyte.gz",
                             "data/t10k-labels-idx1-ubyte.gz")

    print("Training softmax regression")
    train_softmax(X_tr, y_tr, X_te, y_te, epochs=10, lr = 0.1)

    print("\nTraining two layer neural network w/ 100 hidden units")
    train_nn(X_tr, y_tr, X_te, y_te, hidden_dim=100, epochs=20, lr = 0.2)
