# Resources from Laboratory

class Lims::Core::Laboratory::Aliquot
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::Flowcell
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::Gel
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::Oligo
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::Plate
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::Sample
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::SpinColumn
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::TagGroup
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::Tube
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::TubeRack
  NOT_IN_ROOT = 1
end

# Resources from Organizations

class Lims::Core::Organization::Batch
  NOT_IN_ROOT = 1
end

class Lims::Core::Organization::Order
  NOT_IN_ROOT = 1
end

class Lims::Core::Organization::Study
  NOT_IN_ROOT = 1
end

class Lims::Core::Organization::User
  NOT_IN_ROOT = 1
end

# Resources from Laballables

class Lims::Core::Labels::Barcode2D
  NOT_IN_ROOT = 1
end

class Lims::Core::Labels::EAN13Barcode
  NOT_IN_ROOT = 1
end

class Lims::Core::Labels::Labellable
  NOT_IN_ROOT = 1
end

class Lims::Core::Labels::SangerBarcode
  NOT_IN_ROOT = 1
end

# Actions

class Lims::Core::Labels::Labellable::CreateLabellable
  NOT_IN_ROOT = 1
end

class Lims::Core::Labels::CreateLabels
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::Flowcell::CreateFlowcell
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::Gel::CreateGel
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::Plate::CreatePlate
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::Plate::PlateTransfer
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::Plate::TransferPlatesToPlates
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::SpinColumn::CreateSpinColumn
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::Tube::CreateTube
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::Tube::TransferTubesToTubes
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::Tube::TransferWellsToTubes
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::TubeRack::CreateTubeRack
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::TubeRack::TubeRackMove
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::Tube::TubeRackTransfer
  NOT_IN_ROOT = 1
end

class Lims::Core::Laboratory::TagWells
  NOT_IN_ROOT = 1
end

# Persistence
require 'lims-core/persistence/multi_criteria_filter'
class Lims::Core::Persistence::MultiCriteriaFilter
  NOT_IN_ROOT = 1
end

require 'lims-core/labels/labellable/label_filter'
class Lims::Core::Persistence::LabelFilter
  NOT_IN_ROOT = 1
end

require 'lims-core/organization/batch/batch_filter'
class Lims::Core::Persistence::BatchFilter
  NOT_IN_ROOT = 1
end

require 'lims-core/organization/order/order_filter'
class Lims::Core::Persistence::OrderFilter
  NOT_IN_ROOT = 1
end
