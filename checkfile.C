#include <string.h>

// Check quality of nanoAOD root files.
// In general, corrupt files cannot be either opened properly
// or alternatively problems appear when reaching a corrupt event
// in event loop
// Note: checking only e.g. the first and last event is not enough!

void checkfile(string filename="") {

  auto file = TFile::Open(filename.c_str(),"READ");
  if (file == nullptr || file->IsZombie()) exit(1);
  
  auto tree = (TTree*)file->Get("Events");

  for (int i = 0; i < tree->GetEntries(); i += 1000  ) {  // The step might need adjusting to optimize speed and error catchment capability
    if ((i-1)%100000 == 0) cout << "Opened entry: " << i << endl;
    if (tree->GetEntry(i) < 1) exit(1); 
          
   } 
}
