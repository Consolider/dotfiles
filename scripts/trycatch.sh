function try()
{
    [[ $- = *e* ]]; SAVED_OPT_E=$?
    set +e
}

function throw()
{
    exit $1
}

function catch()
{
    export exception_code=$?
    (( $SAVED_OPT_E )) && set +e
    return $exception_code
}

# Here we define several custom bash functions to mimic the semantic of try and catch statements
# The throw() function is supposed to raise a custom (non-zero) exception.
# We need set +e, so that the non-zero returned by throw() will not terminate a bash script.
# Inside catch(), we store the value of exception raised by throw() in a bash variable exception_code, so that we can handle the exception in a user-defined fashion.
#
