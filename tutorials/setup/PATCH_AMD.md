# Patching AMD processors

__*Only do this if directed to do so*__

If you run an AMD processor on Windows, you may require a patch to enable neural-network dependent functions, such as face recognition training.  To apply the patch:

1. ensure Media Server is not running
1. in your Media Server directory, overwrite the file `libopenblas.dll` with the included alternate version `libopenblas_amd_bulldozer.dll`
1. restart Media Server
1. ensure Media Server is again running by pointing your browser to [`admin`](http://127.0.0.1:14000/a=admin)
