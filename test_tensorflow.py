import tensorflow as tf

a = tf.constant(3)
b = tf.constant(2)
c = a + b

sess = tf.Session(config=tf.ConfigProto(log_device_placement=True))
print('\n\n', sess.run(a), '+',sess.run(b), '=', sess.run(c), sep=' ')
