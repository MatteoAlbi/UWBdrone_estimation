#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <string>
#include <math.h>
#include <new>
#include <vector>
#include <cstdlib>

#include <fstream>      
#include <streambuf>    
#include <sstream>     
#include <cstdio>

#include "rTDoA_est_opt.h"

using namespace std;

vector<string> splitString (string s, string delimiter){ //string to be splitted passed as copy

    size_t pos_start = 0, pos_end, delim_len = delimiter.length();
    string token;
    vector<string> res;

    while ((pos_end = s.find (delimiter, pos_start)) != string::npos) {//find delimeter -> if not found exit
        token = s.substr (pos_start, pos_end - pos_start);//extract substing between string start and delimiter position; ATT: modifies the string
        pos_start = pos_end + delim_len; //move the pointer to the new start string
        res.push_back (token); //save the extracted string into the vector
    }

    res.push_back (s.substr (pos_start)); //when delimiter is not found -> save the rimaining string
    return res;
}

uint64_t stou64(string s){
    uint64_t ret = 0;
    for(int i=s.length()-1, j=0; i>=0; i--, j++){
        ret += (((int) s[i]) - 48) * pow(10,j);
    }

    return ret;
}

int main(){

    ifstream rx1("..\\data\\rx1.txt");
    ifstream rx2("..\\data\\rx2.txt");
    ifstream tx1("..\\data\\tx1.txt");
    ifstream tx2("..\\data\\tx2.txt");

    FILE * out = fopen("..\\data\\out.txt", "w");
    // FILE * time = fopen("..\\data\\t.txt", "w");

    uint64_t ts[NUM_ANCH][4];
    string rx1_line, rx2_line, tx1_line, tx2_line;
    vector<string> v_rx1, v_rx2, v_tx1, v_tx2;

    int iter = 0;
    uint16_t t0 = 0;
    double t, tmax = -1;
    uint t_anchor = 1;
    uint t_phase = 2;

    bool read = true;
    read = read && getline(rx1,rx1_line);
    read = read && getline(rx2,rx2_line);
    read = read && getline(tx1,tx1_line);
    read = read && getline(tx2,tx2_line);
    while(read){
        
        v_rx1 = splitString(rx1_line, " ");
        v_rx2 = splitString(rx2_line, " ");
        v_tx1 = splitString(tx1_line, " ");
        v_tx2 = splitString(tx2_line, " ");

        for(int i=0; i<NUM_ANCH;i++){
            ts[i][0] = stou64(v_rx1[i]);
            ts[i][1] = stou64(v_rx2[i]);
            ts[i][2] = stou64(v_tx1[i]);
            ts[i][3] = stou64(v_tx2[i]);
        }

#ifdef DEBUG
        cout << rx1_line << endl;
        for(int i=0; i<NUM_ANCH; i++){
            cout << ts[i][0] << " ";
        }
        cout << endl;
        cout << rx2_line << endl;
        for(int i=0; i<NUM_ANCH; i++){
            cout << ts[i][1] << " ";
        }
        cout << endl;
        cout << tx1_line << endl;
        for(int i=0; i<NUM_ANCH; i++){
            cout << ts[i][2] << " ";
        }
        cout << endl;
        cout << tx2_line << endl;
        for(int i=0; i<NUM_ANCH; i++){
            cout << ts[i][3] << " ";
        }
        cout << endl;
        cout << endl;
#endif
        
        // if(iter == 0) t0 = ts[t_anchor][t_phase];
        // t = ((double)(ts[t_anchor][t_phase] - t0))/TIME_CONST;
        // if(t > tmax) tmax = t;
        // else{
        //     t += tmax;
        //     tmax = t;
        // }
        // fprintf(time,"%f\n", t);

        // if(iter == 0){ 
        //     t0 = ts[t_anchor][t_phase];
        //     fprintf(time,"%f\n", 0);
        // }
        // else{
        //     t = ((double)(ts[t_anchor][t_phase] - t0))/TIME_CONST;
        //     fprintf(time,"%f\n", t);
        //     t0 = ts[t_anchor][t_phase];
        // }

        rTDoA(ts, out);

        read = read && getline(rx1,rx1_line);
        read = read && getline(rx2,rx2_line);
        read = read && getline(tx1,tx1_line);
        read = read && getline(tx2,tx2_line);
        iter++;
    }

    fclose(out);
    // fclose(time);
    rx1.close();
    rx2.close();
    tx1.close();
    tx2.close();

    return 0;
}