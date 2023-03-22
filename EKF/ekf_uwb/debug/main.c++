#include <stdint.h>
#include <stdbool.h>
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

#include "ekf.h"
#include "linear_algebra.h"

using namespace std;

string file_name = "data.csv";
string log_file = "log.csv";

vector<string> split_string (string s, string delimiter){ //string to be splitted passed as copy

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


string load_from_file(string fileName){
    if (fileName == "") return "";

    ifstream fin(fileName);
    stringstream buffer;

    //check is the file has been opened (otherways the path doesn's exist)
    if(! fin.is_open()) return "";

    buffer << fin.rdbuf();
    string s = buffer.str();

    return s;
}


int save_to_file(string s, string fileName){
    if (fileName == "") return 1;

    ofstream fout(fileName);
    fout << s;
    fout.close();

    return 0;
}


void append_log(ekf_data_t * v, stringstream *ss_log, int n){
    ekf_data_t eul[3];

    ekf_quat2eul(v, eul);
    *ss_log << eul[0] << ";" << eul[1] << ";" << eul[2];
    for(int j=0; j<n; j++) *ss_log << ";" << v[j];
    *ss_log << endl;
}


int main(){

    //read file and split to extract rows
    vector<string> rows = split_string(load_from_file(file_name), "\n");
    //cout << s_file << endl;

    int n = rows.size()-1;
    float acc_data[n][3], mag_data[n][3];

    // extract data
    vector<string> v_data;
    for(int i=0; i< n; i++){
        // split to extract data
        v_data = split_string(rows[i], ";");
        for(int j=0; j<3; j++){
            acc_data[i][j] = stof(v_data[j]);
            mag_data[i][j] = stof(v_data[j+3]);
        }
        //if(i==0) printf("%f\t%f\t%f\t\t%f\t%f\t%f\n", acc_data[i][0], acc_data[i][1], acc_data[i][2], mag_data[i][0], mag_data[i][1], mag_data[i][2]);
    }

    // run filter
    ekf_data_t au[3] = {10.663, 8.27316, 16.6894};
    ekf_data_t mu[3] = {21.0981, 22.5288, 21.9521};
    ekf_data_t si[9] = { 1.0562,     0.0597149,  0.00421155,
                    0.0597149,  1.01886,    -0.0164807,
                    0.00421157, -0.0164808, 0.932647};
    ekf_data_t ret[16], eul[3];
    stringstream ss_log;

    // cout << "Start filter" <<  endl;

    // init
    ekf_init(ret, au, mu, si, acc_data[0], mag_data[0]);
    append_log(ret, &ss_log, 13);

    // run
    for(int i=1; i<n; i++){
        ekf_step(ret, acc_data[i], mag_data[i]);
        append_log(ret, &ss_log, 13);
    }

    // save ss_log
    save_to_file(ss_log.str(), log_file);


    return 0;
}
