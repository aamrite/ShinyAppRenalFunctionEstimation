# ShinyAppRenalFunctionEstimation
The app estimates the renal function as creatinine clearance or the estimated glomerular filtration rate based on the Cock-Gault and MDRD equations respectively.
The Cockcroft Gault equation is<br>
CrCl= [(140-Age)*Weight/(72*Scr)]*(0.85 if female)<br>
    where <br>
    CrCl: creatinine clearance (mL/min)<br>
    Age: age in years <br>
    Weight: weight in kg <br>
    Scr: serum creatinine in mg/dL<br>
The MDRD equation is <br>
     eGFR= 175*(Scr)^-1.154 * (Age)^-0.203 * (0.742 if female)* (1.212 if African American) <br>
     where <br>
     eGFR: estimated glomerular filtration rate <br>
     Age: age in years <br>
     Scr: serum creatinine in mg/DL<br>
     
   The renal function is categorized into 5 categories based on the creatinine clearance or eGFR<br>
   1) Greater than or equal to 90:  Normal Renal Function <br>
   2) 60 to 89.9: Mild Renal Function Impairment <br>
   3) 30 to 59.9: Moderate Renal Function Impairment <br>
   4) 15 to 29.9: Severe Renal Function Impairment <br>
   5) Less than 15: End Stage Renal Disease <br>
   
   The App has a radio-button to choose the method of estimation and drop down menus to select your gender and race.
   There are sliders in the app to input your age, weight, and creatinine clearance. 
   Once all the inputs are selected, press the submit button to get the results. 
   
   You will see: <br>
    1) a numeric value of your estimated GFR or creatinine clearance (depending on whether you selected MDRD or CG method)<br>
    2) a figure with an arrow showing your renal function category. 
    
The R codes for the ui.R and server.R are stored in the same Github repository at https://github.com/aamrite/ShinyAppRenalFunctionEstimation
