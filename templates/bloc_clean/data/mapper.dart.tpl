import '../dtos/{{dtoFile}}';
import '../../../domain/entities/{{entityFile}}';

extension {{mapper}} on {{dto}} {
  {{entity}} toEntity() {
    // TODO: Map DTO to Entity.
    return const {{entity}}();
  }
}