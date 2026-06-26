import * as crypto from 'node:crypto';

interface SSHCredentials {
  serverIP: string;
  password: string;
  key: string;
  passphrase: string;
}

interface UserData {
  encryptedCredentials: string;
}

export class EncryptionManager {
  private readonly algorithm: string = 'aes-256-gcm';
  private readonly keyLength: number = 32; // 256 bits
  private readonly ivLength: number = 12; // 12 bytes for GCM
  private readonly saltLength: number = 16; // 16 bytes
  private readonly tagLength: number = 16; // 16 bytes
  private readonly pbkdf2Iterations: number = 100000;
  private readonly pbkdf2Digest: string = 'sha256';

  async generateMasterKey(): Promise<string> {
    return crypto.randomBytes(this.keyLength).toString('base64');
  }

  async encrypt(
    data: string | SSHCredentials,
    masterKey: string,
  ): Promise<string> {
    const salt = crypto.randomBytes(this.saltLength);
    const key = await this.deriveKey(masterKey, salt);
    const iv = crypto.randomBytes(this.ivLength);

    const cipher = crypto.createCipheriv(
      this.algorithm,
      key,
      iv,
    ) as crypto.CipherGCM;
    const encrypted = Buffer.concat([
      cipher.update(
        typeof data === 'string' ? data : JSON.stringify(data),
        'utf8',
      ),
      cipher.final(),
    ]);
    const tag = cipher.getAuthTag();

    return Buffer.concat([salt, iv, tag, encrypted]).toString('base64');
  }

  async decrypt(
    encryptedData: string,
    masterKey: string,
    parseJson = true,
  ): Promise<SSHCredentials> {
    const buffer = Buffer.from(encryptedData, 'base64');

    const salt = buffer.subarray(0, this.saltLength);
    const iv = buffer.subarray(
      this.saltLength,
      this.saltLength + this.ivLength,
    );
    const tag = buffer.subarray(
      this.saltLength + this.ivLength,
      this.saltLength + this.ivLength + this.tagLength,
    );
    const encrypted = buffer.subarray(
      this.saltLength + this.ivLength + this.tagLength,
    );

    const key = await this.deriveKey(masterKey, salt);

    const decipher = crypto.createDecipheriv(
      this.algorithm,
      key,
      iv,
    ) as crypto.DecipherGCM;
    decipher.setAuthTag(tag);

    const decrypted = Buffer.concat([
      decipher.update(encrypted),
      decipher.final(),
    ]);
    return parseJson
      ? JSON.parse(decrypted.toString('utf8'))
      : decrypted.toString('utf-8');
  }

  private async deriveKey(masterKey: string, salt: Buffer): Promise<Buffer> {
    return new Promise((resolve, reject) => {
      crypto.pbkdf2(
        masterKey,
        salt,
        this.pbkdf2Iterations,
        this.keyLength,
        this.pbkdf2Digest,
        (err, derivedKey) => {
          if (err) reject(err);
          else resolve(derivedKey);
        },
      );
    });
  }
}

export const encryptionManager = new EncryptionManager();
