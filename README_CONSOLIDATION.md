A new section of the Website named "Interventions" must be added and it must be accessible from the menu after "Contact". Clicking on the new "Interventions" section will bring the visitor to a new view in the Rails application. Please note that this form must be visible and usable on a mobile phone. It is therefore imperative to keep the capacities offered by Bootstrap 4.

----------->

   1.  First to create an Intervention table, I did: 
                 rails generate scaffold Intervention
   2.  Second to create a migration for CreateIntervention, I did:  
                 rails generate migration CreateIntervention
   3.  Third to modify all the related models:
                 customer, building, battery, column, elevator, employee 
   4.  Fourht to create a migration for AddInterventionReference, I did: 
                 rails g migration AddInterventionReference
   5.  Next is to a form for intervention
   6.  Then update the javascript for the form
   7.  Then place a link for intervention after an employee sign in into the My Account.
   
