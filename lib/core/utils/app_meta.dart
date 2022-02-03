class AppMeta {
  static List<Map<String, String>> maritalStatus() {
    List<Map<String, String>> suggestions = [
      {'value': 'married', 'title': 'Married'},
      {'value': 'unmarried', 'title': 'UnMarried'},
    ];
    return suggestions;
  }

  static List<String> genter() {
    List<String> suggestions = <String>[
      'Male',
      'Female',
    ];
    return suggestions;
  }

  static List<String> appProductsAvailable() {
    List<String> suggestions = <String>[
      'Loan',
      'Insurance',
    ];
    return suggestions;
  }

  static List<String> filterCategory() {
    List<String> suggestions = <String>[
      'Occupation',
      'Salary',
      'City',
    ];
    return suggestions;
  }

  static List<Map<String, String>> iDProofs() {
    List<Map<String, String>> suggestions = [
      {'value': 'driving_license', 'title': 'Driving License'},
      {'value': 'voters_id', 'title': 'Voters ID'},
      {'value': 'passport', 'title': 'Passport'},
      {'value': 'aadhaar', 'title': 'Aadhaar'},
    ];
    return suggestions;
  }

  // {'value': 'voters_id', 'title': 'Voter ID'},
  // {'value': 'pan', 'title': 'PAN'},

  static List<Map<String, String>> utilityBills() {
    List<Map<String, String>> suggestions = [
      {'value': 'vehicle_registration', 'title': 'Vehicle Registration'},
    ];
    return suggestions;
  }

  static List<Map<String, String>> additionAddressProofs() {
    List<Map<String, String>> suggestions = [
      {'value': 'tax_receipt', 'title': 'Property or Municipal Tax Receipt'},
    ];
    return suggestions;
  }

  static List<Map<String, String>> salary() {
    List<Map<String, String>> suggestions = [
      {'value': 'upto_5_lakhs', 'title': 'Upto 5 Lacs'},
      {'value': 'upto_5_lakhs_25_lakhs', 'title': '5 Lacs - 25 Lacs'},
      {'value': 'upto_25_lakhs_1_crore', 'title': '25 lacs - 1 Crore'},
      {'value': 'greater_than_1_crore', 'title': '> 1 Crore'},
    ];
    return suggestions;
  }

  static List<Map<String, String>> loanType() {
    List<Map<String, String>> suggestions = [
      {'value': 'personal_loan', 'title': 'Personal loan'},
      {'value': 'business_loan', 'title': 'Business loan'},
      {'value': 'housing_loan', 'title': 'Housing Loan'},
      {'value': 'credit_card_loan', 'title': 'Credit card loan'},
      {'value': 'agriculture_loan', 'title': 'Agriculture loan'},
      {'value': 'education_loan', 'title': 'Education loan'},
    ];
    return suggestions;
  }

  static List<Map<String, String>> jobType() {
    List<Map<String, String>> suggestions = [
      {'value': 'salaried_professional', 'title': 'Salaried Professional'},
      {
        'value': 'self_employed_professional',
        'title': 'Self Employed Professional'
      },
      {
        'value': 'self_employed_non_professional_traders',
        'title': 'Seld Employed Non Professional Traders'
      },
      {'value': 'others_profession', 'title': 'Other Profession'},
    ];
    return suggestions;
  }

  static List<Map<String, String>> occupationType() {
    List<Map<String, String>> suggestions = [
      {'value': 'salaried', 'title': 'Salaried'},
      {'value': 'housewife', 'title': 'Housewife'},
      {'value': 'student', 'title': 'Student'},
      {'value': 'retired_pensioner', 'title': 'Retired/Pensioner'},
      {'value': 'agriculturist', 'title': 'Agriculturist'},
      {
        'value': 'indv_self_employed_professional',
        'title': 'Indv-Self-Employed-Professional'
      },
      {
        'value': 'indv_self_employed_non_professional',
        'title': 'Indv-Self Employed-Non-Professional'
      },
      {'value': 'politician', 'title': 'Politician'},
      {
        'value': 'agriculture_allied_activities',
        'title': 'Agriculture/Allied Activities'
      },
      {
        'value': 'fin_services_stock_brokers_investment_mutual_fund',
        'title': 'Fin Services-Stock Brokers/Investment/Mutual Fund'
      },
      {
        'value': 'builders_and_real_estate_infra_developers',
        'title': 'Builders And Real Estate,Infra Structure Developers'
      },
      {'value': 'importers_exporters', 'title': 'Importers/Exporters'},
      {'value': 'service_sector', 'title': 'Service Sector'},
      {
        'value': 'self_employed_professional',
        'title': 'Self Employed-Professional'
      },
      {
        'value': 'self_employed_non_professional',
        'title': 'Self Employed-Non Professional/Traders'
      },
      {'value': 'jeweller_bullion_trader', 'title': 'Jeweller/Bullion Trader'},
      {'value': 'manufacturing', 'title': 'Manufacturing'},
      {
        'value': 'public_utilities_services',
        'title': 'Public Utilities Services'
      },
      {
        'value': 'arms_weapons_antiques_dealers_manufacturers',
        'title': 'Arms/Weapons/Antiques-Dealers/Manufacturers'
      },
      {
        'value': 'government_semi_government_local_bodies',
        'title': 'Government/Semi-Government/Local Bodies'
      },
      {'value': 'other_occupations', 'title': 'Others'},
    ];
    return suggestions;
  }

  static List<Map<String, String>> attachmentType() {
    List<Map<String, String>> suggestions = [
      {'value': 'address_proof', 'title': 'Address Proof'},
      {
        'value': 'additional_address_proof',
        'title': 'Additional Address Proof'
      },
      {'value': 'residence_proof', 'title': 'Residence Proof'},
      {'value': 'business_proof', 'title': 'Business Proof'},
      {'value': 'experience_proof', 'title': 'Experience Proof'},
      {'value': 'aadhaar_front_proof', 'title': 'Aadhaar Front'},
      {'value': 'aadhaar_back_proof', 'title': 'Aadhaar Back'},
      {'value': 'other_identity_proof', 'title': 'Other Identity Proof'},
      {
        'value': 'additional_identity_proof',
        'title': 'Additional Identity Proof'
      },
      {'value': 'cibil_score_proof', 'title': 'Cibil Score Proof'},
      {'value': 'it_returns_proof', 'title': 'IT Returns Proof'},
      {'value': 'office_id_proof', 'title': 'Office ID Proof'},
      {
        'value': 'hr_official_detail_proof',
        'title': 'HR Official Detail Proof'
      },
      {
        'value': 'employment_additional_document',
        'title': 'Employment Additional Document'
      },
      {'value': 'salary_slip', 'title': 'Salary Slip'},
      {'value': 'ctc_letter', 'title': 'CTC Letter'},
      {'value': 'incentive_document', 'title': 'Incentive Document'},
      {'value': 'employment_details', 'title': 'Employment Details'},
      {'value': 'property_proof', 'title': 'Property Proof'},
      {'value': 'income_proof_id', 'title': 'Income Proof'},
      {'value': 'banking_proof', 'title': 'Bank Proof'},
      {'value': 'property_proof_id', 'title': 'Property Documents'},
      {'value': 'other_proof', 'title': 'Others'},
    ];
    return suggestions;
  }

  static List<Map<String, String>> relationType() {
    List<Map<String, String>> suggestions = [
      {'value': 'father', 'title': 'Father'},
      {'value': 'mother', 'title': 'Mother'},
      {'value': 'brother', 'title': 'Brother'},
      {'value': 'sister', 'title': 'Sister'},
      {'value': 'uncle', 'title': 'Uncle'},
      {'value': 'aunt', 'title': 'Aunt'},
    ];
    return suggestions;
  }

  static List<Map<String, String>> businessDocuments() {
    List<Map<String, String>> suggestions = [
      {
        'value': 'registration_certificate',
        'title': 'Registration Certificate'
      },
      {
        'value': 'voters_id',
        'title': 'Cert/License under Shop & Establishment Act'
      },
      {'value': 'pan', 'title': 'Sales and income tax returns'},
      {
        'value': 'pan',
        'title': '36CST/VAT/GST Certificate (provisional/final)'
      },
      {
        'value': 'pan',
        'title':
            'Certificate/Registration document issued by Sales Tax/Service Tax/Professional Tax Authorities'
      },
      {
        'value': 'pan',
        'title':
            'IEC(Importer Exporter Code)/License/Certificate for import/export'
      },
      {'value': 'pan', 'title': 'Complete Income Tax Return'},
      {
        'value': 'pan',
        'title': 'Utility Bills in the name of Sole Proprietorship firm'
      },
    ];
    return suggestions;
  }

  static List<String> carrierGuideFAQs() {
    List<String> suggestions = <String>[
      'Ideal Carrer Test',
      'Skill Based Carrer Test',
      'Stream Selector Test',
      'Commerce Carrer Selector',
      'Humanities Carrer Selector',
      'Engineering Branch Selector',
      'Professional Skill Index',
      'Educator\'s Professional Skill Index'
    ];
    return suggestions;
  }

  static List<Map<String, String>> interestPayout() {
    List<Map<String, String>> suggestions = [
      {'value': 'MONTHLY', 'title': 'Monthly'},
      {'value': 'QUARTERLY', 'title': 'Quarterly'},
      {'value': 'HALF_YEARLY', 'title': 'Half Yearly'},
      {'value': 'ANNUAL', 'title': 'Annually'},
      {'value': 'ON_MATURITY', 'title': 'On Maturity'},
    ];

    return suggestions;
  }

  static List<String> bankName() {
    List<String> suggestions = <String>['SBI', 'Yes Bank', 'Canara Bank'];
    return suggestions;
  }

  static List<String> nationality() {
    List<String> suggestions = <String>[
      'Indian',
    ];
    return suggestions;
  }

  static List<String> religion() {
    List<String> suggestions = <String>[
      'Hindu',
      'Christian',
      'Sikh',
      'Buddhist',
      'Jain',
      'Parsi',
      'Others'
    ];
    return suggestions;
  }

  static List<Map<String, String>> accountType() {
    List<Map<String, String>> suggestions = [
      {'value': 'current', 'title': 'Current'},
      {'value': 'savings', 'title': 'Savings'},
      {'value': 'fd', 'title': 'FD'},
      {'value': 'rd', 'title': 'RD'},
    ];
    return suggestions;
  }

  static List<Map<String, String>> accountHolderType() {
    List<Map<String, String>> suggestions = [
      {'value': 'single', 'title': 'Single'},
      {'value': 'joint', 'title': 'Joint'},
      {'value': 'e_or_s', 'title': 'E or S'},
    ];
    return suggestions;
  }

  static List<Map<String, String>> securitiesType() {
    List<Map<String, String>> suggestions = [
      {'value': 'mutual_fund', 'title': 'Mutual Funds'},
      {'value': 'bond', 'title': 'Bonds'},
      {'value': 'company_fd', 'title': 'Company FD'},
      {'value': 'physical_share', 'title': 'Physical Shares'},
      {
        'value': 'other_physical_security',
        'title': 'Other Physical Securities'
      },
    ];
    return suggestions;
  }

  static List<Map<String, String>> schemeType() {
    List<Map<String, String>> suggestions = [
      {'value': 'ppf', 'title': 'PPF'},
      {'value': 'pf', 'title': 'PF'},
      {'value': 'epf', 'title': 'EPF'},
      {
        'value': 'government_savings_scheme',
        'title': 'Government Savings Schemes'
      },
      {'value': 'post_office_scheme', 'title': 'Post Office Schemes'},
      {'value': 'others', 'title': 'Others'},
    ];
    return suggestions;
  }

  static List<Map<String, String>> propertyType() {
    List<Map<String, String>> suggestions = [
      {'value': 'residential', 'title': 'Residential'},
      {'value': 'commercial', 'title': 'Commercial'},
      {'value': 'land', 'title': 'Land'},
    ];
    return suggestions;
  }

  static List<String> postGuidanceTimeSlot() {
    List<String> suggestions = <String>[
      '11 am',
      '12 noon',
      '3 pm',
      '6 pm',
      '7 pm'
    ];
    return suggestions;
  }

  static List<String> salutation() {
    List<String> suggestions = <String>['Mr.', 'Mrs.', 'Ms.'];
    return suggestions;
  }

  static List<Map<String, String>> nomineeRelation() {
    List<Map<String, String>> suggestions = [
      {'value': 'SPOUSE', 'title': 'Spouse'},
      {'value': 'Others', 'title': 'Others'},
      {'value': 'Friend', 'title': 'Friend'},
      {'value': 'FATHER-IN-LAW', 'title': 'Father-In-Law'},
      {'value': 'MOTHER-IN-LAW', 'title': 'Mother-In-Law'},
      {'value': 'MOTHER', 'title': 'Mother'},
      {'value': 'FATHER', 'title': 'Father'},
      {'value': 'RELATIVE', 'title': 'Relative'},
      {'value': 'DAUGHTER', 'title': 'Daughter'},
      {'value': 'SON', 'title': 'Son'},
      {'value': 'Servant', 'title': 'Servant'},
      {'value': 'KARTA', 'title': 'Karta'},
      {'value': 'NEPHEW', 'title': 'Nephew'},
      {'value': 'UNCLE', 'title': 'Uncle'},
      {'value': 'AUNT', 'title': 'Aunt'},
      {'value': 'SISTER IN LAW', 'title': 'Sister-In-Law'},
      {'value': 'BROTHER IN LAW', 'title': 'Brother-In_Law'},
      {'value': 'Cousin', 'title': 'Cousin'},
      {'value': 'Grand Mother', 'title': 'Grand-Mother'},
      {'value': 'Grand Father', 'title': 'Grand-Father'},
      {'value': 'Daughter in Law', 'title': 'Daughter-In-Law'},
      {'value': 'Son - in Law', 'title': 'Son-In-Law'},
      {'value': 'GRAND DAUTHER', 'title': 'Grand-Daughter'},
      {'value': 'NIECE', 'title': 'Niece'},
      {'value': 'GRAND SON', 'title': 'Grand-Son'},
      {'value': 'SISTER', 'title': 'Sister'},
      {'value': 'BROTHER', 'title': 'Brother'},
      {'value': 'BUSINESS PARTNER', 'title': 'Business-Partner'},
    ];
    return suggestions;
  }
}
