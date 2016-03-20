@rem Bajar todas las imagenes del dia
@echo off
@echo --------- BING -------------
@call iod_bing.cmd 
@echo --------- NASA -------------
@call iod_nasa.cmd 
@echo ------- NAT  GEO -----------
@call iod_nat_geog.cmd 
@echo ----- COGE UNO AL AZAR -----
@pick_random_file_2.cmd .\imagenes ..\tinbgi\images\paisaje1.jpg

