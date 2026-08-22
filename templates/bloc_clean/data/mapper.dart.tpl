import '../dtos/{{dtoFile}}';
import '../../../domain/entities/{{entityFile}}';

// FKIT generated mapper: complete the DTO/entity field mapping for this feature.
extension {{mapper}} on {{dto}} {
  {{entity}} toEntity() {
    // TODO: Map DTO to Entity.
    return const {{entity}}();
  }
}
