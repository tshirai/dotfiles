#! /bin/bash
npm config set proxy $http_proxy
npm config set https-proxy $http_proxy
npm config set registry http://registry.npmjs.org/
