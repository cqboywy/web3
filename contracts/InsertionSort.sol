// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract InsertionSort {
    function sort(uint[] memory data) public pure returns (uint[] memory) {
        for (uint i = 1; i < data.length; i++) {
            uint key = data[i];
            uint j = i - 1;
            
            while (int(j) >= 0 && data[j] > key) {
                data[j + 1] = data[j];
                j = j - 1;
            }
            
            data[j + 1] = key;
        }
        
        return data;
    }
}