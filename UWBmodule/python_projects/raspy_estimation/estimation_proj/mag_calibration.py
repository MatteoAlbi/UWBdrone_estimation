import numpy as np
from scipy import linalg
#from matplotlib import pyplot as plt


BOOL_DEBUG = True


# -- global magnetometer data
'''
To obtain Gravitation Field (raw format):
    1) get the Total Field for your location from here:
       http://www.ngdc.noaa.gov/geomag-web (tab Magnetic Field)
    2) Convert this values to mGauss (1nT = 10E-5 mG) and
       assign it to F
'''
global F
#raw_tot_int = 48035.4
#F = raw_tot_int * 10**(-2)
F = 380.01155


# -- accessories functions

def model_err(Winv, V, B, data):
    # compute model error (matlab)
    # Winv      mag soft iron
    # V         mag hard iron
    # B         magnetomer vector norm
    # data      test dataset

    Vmat = np.vstack((np.ones(len(data)) * V[0], np.ones(len(data)) * V[1], np.ones(len(data)) * V[2]))
    spherept = (Winv @ (data.T - Vmat)).T
    radsq = np.sum(np.square(spherept), 1)

    res = radsq - np.square(B)
    er = 1/(2*B*B) * np.sqrt( res.T @ res / (len(data)))

    return er


def is_pos_def(x):
    # check if given matrix is positive definite
    
    return np.all(np.linalg.eigvals(x) > 0)


def correct_data(data, hi, si):
    # calibrate data given fard and soft iron
    # data      data to calibrate
    # hi        mag hard iron
    # si        mag soft iron
    
    hi_mat = np.vstack((np.ones(len(data)) * hi[0], np.ones(len(data)) * hi[1], np.ones(len(data)) * hi[2]))
    corrected_data = (data - hi_mat.T) @ si

    return corrected_data


# -- file managing

def save_data(data, file_name):
    #data = np.array(data)

    with open(file_name, 'w') as fp:

        if(len(data.shape) == 1):
            for el in data:
                fp.write("%f;" % el)
        else:
            for line in data:
                for el in line:
                    fp.write("%f;" % el)
                fp.write("\n")
        fp.close()


def load_data(file_name):
    data = []
    with open(file_name, 'r') as fp:
        for line in fp:
            # remove linebreak
            line = line.strip()
            # split data
            data_vec = line.split(";")
            # remove empty element and convert to float
            data_vec = [float(val) for val in data_vec if val != '']
            #if(BOOL_DEBUG): print(data_vec)

            # add vec to the list
            data.append(data_vec)

    return data


# -- implementation from github

'''
Code by Nicolas Liaudat
https://github.com/nliaudat/magnetometer_calibration/tree/13d65281bafa86ad9d1945499d133814ae2c2d0e
'''
def compute_hi_si(data):
    global F

    ellipsoid_fit_ML(data)

    M, n, d = ellipsoid_fit_GH(data)

    # calibration parameters
    M_1 = linalg.inv(M)
    hard_iron = -np.dot(M_1, n)
    soft_iron = np.real(F / np.sqrt(np.dot(n.T, np.dot(M_1, n)) - d) * linalg.sqrtm(M))

    #remember to flatten SI
    return hard_iron, soft_iron


def ellipsoid_fit_GH(data):
    s = np.array(data, dtype=np.float64).T
    if(BOOL_DEBUG): print(s.shape)

    # D (samples)
    D = np.array([s[0]**2., s[1]**2., s[2]**2.,
                    2.*s[1]*s[2], 2.*s[0]*s[2], 2.*s[0]*s[1],
                    2.*s[0], 2.*s[1], 2.*s[2], np.ones_like(s[0])])

    # S, S_11, S_12, S_21, S_22 (eq. 11)
    S = np.dot(D, D.T)
    S_11 = S[:6,:6]
    S_12 = S[:6,6:]
    S_21 = S[6:,:6]
    S_22 = S[6:,6:]

    # C (Eq. 8, k=4)
    C = np.array([[-1,  1,  1,  0,  0,  0],
                  [ 1, -1,  1,  0,  0,  0],
                  [ 1,  1, -1,  0,  0,  0],
                  [ 0,  0,  0, -4,  0,  0],
                  [ 0,  0,  0,  0, -4,  0],
                  [ 0,  0,  0,  0,  0, -4]])

    # v_1 (eq. 15, solution)
    E = np.dot(linalg.inv(C),
                S_11 - np.dot(S_12, np.dot(linalg.inv(S_22), S_21)))

    E_w, E_v = np.linalg.eig(E)

    v_1 = E_v[:, np.argmax(E_w)]
    if v_1[0] < 0: v_1 = -v_1

    # v_2 (eq. 13, solution)
    v_2 = np.dot(np.dot(-np.linalg.inv(S_22), S_21), v_1)

    # quadric-form parameters
    M = np.array([[v_1[0], v_1[5], v_1[4]],
                  [v_1[5], v_1[1], v_1[3]],
                  [v_1[4], v_1[3], v_1[2]]])
    n = np.array([[v_2[0]],
                  [v_2[1]],
                  [v_2[2]]])
    d = v_2[3]

    return M, n, d


# -- implementation from matlab
'''
Copyright 2018 The MathWorks, Inc. 
'''
def ellipsoid_fit_ML(data):
    s = np.array(data, dtype=np.float64)
    x = s[:,0]
    y = s[:,1]
    z = s[:,2]

    return best_fit(x, y, z)


def best_fit(x, y, z):
    A, b, magB, er, _ = correct_ellipsoid4(x, y, z)

    A7, b7, magB7, er7, ispd7 = correct_ellipsoid7(x, y, z)
    if(ispd7 and np.all(np.isreal(A7)) and er7 < er):
        A, b, magB, er = A7, b7, magB7, er7

    A10, b10, magB10, er10, ispd10 = correctEllipsoid10(x,y,z)
    if(ispd10 and np.all(np.isreal(A10)) and er10 < er):
        A, b, magB, er = A10, b10, magB10, er10

    return A, b, magB


# -- ellipsoid fitting

def correct_ellipsoid4(x, y, z):
    bv = np.square(x) + np.square(y) + np.square(z)
    bv = bv.reshape((len(x),1))

    A3 = np.vstack((x,y,z)).T
    A4 = np.ones((len(x),1))
    A = np.hstack((A3,A4))

    soln, _, _, _ = np.linalg.lstsq(A,bv, rcond=None)
    Winv = np.eye(3)
    V = 0.5 * soln[0:3]
    B = np.sqrt(soln[3] + np.sum(np.square(V)))[0]

    res = (A @ soln - bv).reshape(len(x))
    er = 1/(2*B*B) * np.sqrt( (res.T @ res) / (len(x)))
    ispd = True

    return Winv, V, B, er, ispd


def correct_ellipsoid7(x, y, z):
    d = np.vstack(( np.square(x), 
                    np.square(y), 
                    np.square(z), 
                    x, 
                    y, 
                    z, 
                    np.ones_like(x))).T
    dtd = d.T @ d

    w, v = np.linalg.eig(dtd)
    idx = np.argmin(w)
    beta = v[:,idx]
    A = np.diagflat(beta[0:3])
    dA = np.prod(beta[0:3])

    # Compensate for -A
    if(dA < 0):
        A = -A
        beta = -beta
        dA = -dA 

    # hard iron offset
    V = -0.5 * np.divide(beta[3:6], beta[0:3])
    B = np.sqrt(np.abs(np.sum(np.array([A[0,0]*V[0]**2,
                                        A[1,1]*V[1]**2,
                                        A[2,2]*V[2]**2,
                                        -beta[-1]] ))))

    det3root = np.power(dA, (1/3))
    det6root = np.sqrt(det3root)
    Winv = linalg.sqrtm(A / det3root)
    B = B / det6root

    #res = model_err(Winv, V, B, np.vstack((x,y,z)).T)
    er = model_err(Winv, V, B, np.vstack((x,y,z)).T)
    ispd = is_pos_def(A)

    return Winv, V, B, er, ispd


def correctEllipsoid10(x, y, z):
    d = np.vstack(( np.square(x), 
                    2 * np.multiply(x, y),
                    2 * np.multiply(x, z),
                    np.square(y), 
                    2 * np.multiply(y, z),
                    np.square(z), 
                    x, 
                    y, 
                    z, 
                    np.ones_like(x))).T
    dtd = d.T @ d

    w, v = np.linalg.eig(dtd)
    idx = np.argmin(w)
    beta = v[:,idx]
    A = np.vstack(( beta[[0, 1, 2]],
                    beta[[1, 3, 4]],
                    beta[[2, 4, 5]]))
    dA = np.linalg.det(A)

    if(dA < 0):
        A = -A
        beta = -beta
        dA = -dA 
    
    soln = np.linalg.solve(A, beta[6:9].reshape(3,1))
    V = -0.5 * soln.flatten()
    B = np.sqrt(np.abs(np.sum(np.array([A[0,0]*V[0]**2,
                                        2*A[1,0]*V[1]*V[0],
                                        2*A[2,0]*V[2]*V[0],
                                        A[1,1]*V[1]**2,
                                        A[2,1]*V[2]*V[1],
                                        A[2,2]*V[2]**2,
                                        -beta[-1]] )))).item()
    
    det3root = np.power(dA, (1/3))
    det6root = np.sqrt(det3root)
    Winv = linalg.sqrtm(A / det3root)
    B = B / det6root

    #res = model_err(Winv,V,B, np.vstack((x,y,z)).T)
    er = model_err(Winv,V,B, np.vstack((x,y,z)).T)
    ispd = is_pos_def(A)
    
    return Winv, V, B, er, ispd


if __name__ == "__main__":

    mag_file = "./data/mag.csv"
    data = load_data(mag_file)

    hi_gh, si_gh = compute_hi_si(data)
    si_ml, hi_ml, expMFS = ellipsoid_fit_ML(data)

    data_np = np.array(data, dtype=np.float64)

    cal_data_gh = correct_data(data_np, hi_gh, si_gh)
    cal_data_ml = correct_data(data_np, hi_ml, si_ml)

    print("expected magnetic field strength: ", expMFS)
    print("calibration with gh:\nHI:\n", hi_gh, "\nSI:\n", si_gh, "\nresiduals: ", model_err(si_gh, hi_gh, F, data_np))
    print("calibration with ml:\nHI:\n", hi_ml, "\nSI:\n", si_ml, "\nresiduals: ", model_err(si_ml, hi_ml, expMFS, data_np))

    # plt.rcParams["figure.autolayout"] = True
    # fig, (ax1, ax2) = plt.subplots(1, 2, subplot_kw={'projection': '3d'})

    # # gh data
    # ax1.scatter(data_np[:,0], data_np[:,1], data_np[:,2], marker='o', color='r')
    # ax1.scatter(cal_data_gh[:,0], cal_data_gh[:,1], cal_data_gh[:,2], marker='o', color='g')
    # ax1.axis('equal')
    # #ax1.legend(("original", "git_hub"))
    # # ml data
    # ax2.scatter(data_np[:,0], data_np[:,1], data_np[:,2], marker='o', color='r')
    # ax2.scatter(cal_data_ml[:,0], cal_data_ml[:,1], cal_data_ml[:,2], marker='o', color='b')
    # ax2.axis('equal')

    # plt.show()
