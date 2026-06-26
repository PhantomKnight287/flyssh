import { ArgumentMetadata, BadRequestException, ValidationPipe } from '@nestjs/common';

export class CustomValidationPipe extends ValidationPipe {
  async transform(value: any, metadata: ArgumentMetadata) {
    try {
      return await super.transform(value, metadata);
    } catch (error) {
      if (error instanceof BadRequestException) {
        const response = error.getResponse();
        const firstError = (response as any).message?.[0];  // Extract the first message from the array
        throw new BadRequestException(firstError || 'Validation failed');
      }
      throw error;
    }
  }
}
