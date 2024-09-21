import { Body, Controller, HttpCode, HttpStatus, Post } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDTO } from './dto/login.dto';
import { SignupDTO } from './dto/signup.dto';
import {
  ApiBearerAuth, ApiConflictResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { LoginEntity } from './entity/login.entity';
import { GenericErrorEntity } from '../dto/generic-error.dto';
import { SignupEntity } from './entity/signup.entity';

@Controller('auth')
@ApiTags('Authentication')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @ApiOperation({
    summary: 'Login',
    description: 'Login',
  })
  @HttpCode(200)
  @ApiOkResponse({
    type: LoginEntity,
  })
  @ApiNotFoundResponse({
    type: GenericErrorEntity,
  })
  @ApiUnauthorizedResponse({
    type: GenericErrorEntity,
  })
  @Post('login')
  async login(@Body() body: LoginDTO) {
    return await this.authService.login(body);
  }


  @ApiOperation({
    summary: 'Signup',
    description: 'Signup',
  })
  @ApiOkResponse({
    type: SignupEntity
  })
  @ApiConflictResponse({
    type: GenericErrorEntity,
  })
  @Post('sign-up')
  async register(@Body() body: SignupDTO) {
    return await this.authService.signup(body);
  }
}
