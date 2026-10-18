import { initFields } from '../runtime';

export class AS3Error extends Error {
  static __errName = 'Error';
  errorID: number;
  constructor(message: unknown = '', id: unknown = 0) {
    super(message === undefined || message === null ? '' : String(message));
    initFields(this, new.target);
    this.errorID = Number(id) | 0;
    if (!Object.prototype.hasOwnProperty.call(this, 'name')) this.name = (new.target as any).__errName ?? 'Error';
  }
  getStackTrace(): string | null { return this.stack ?? null; }
  override toString(): string { return this.message ? `${this.name}: ${this.message}` : this.name; }
  static override [Symbol.hasInstance](v: unknown): boolean {
    if (this === AS3Error) return v instanceof Error;
    return Function.prototype[Symbol.hasInstance].call(this, v);
  }
}
Object.defineProperty(AS3Error, 'name', { value: 'Error' });

export class ArgumentError extends AS3Error { static override __errName = 'ArgumentError'; }
export class DefinitionError extends AS3Error { static override __errName = 'DefinitionError'; }
export class SecurityError extends AS3Error { static override __errName = 'SecurityError'; }
export class VerifyError extends AS3Error { static override __errName = 'VerifyError'; }
export class UninitializedError extends AS3Error { static override __errName = 'UninitializedError'; }

export class IOError extends AS3Error { static override __errName = 'IOError'; }
export class EOFError extends IOError { static override __errName = 'EOFError'; }
export class IllegalOperationError extends AS3Error { static override __errName = 'IllegalOperationError'; }
export class InvalidSWFError extends AS3Error { static override __errName = 'InvalidSWFError'; }
export class MemoryError extends AS3Error { static override __errName = 'MemoryError'; }
export class ScriptTimeoutError extends AS3Error { static override __errName = 'ScriptTimeoutError'; }
export class StackOverflowError extends AS3Error { static override __errName = 'StackOverflowError'; }
export class DRMManagerError extends AS3Error { static override __errName = 'DRMManagerError'; }
export class SQLError extends AS3Error { static override __errName = 'SQLError'; }
