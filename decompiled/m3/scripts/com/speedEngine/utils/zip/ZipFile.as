package com.speedEngine.utils.zip
{
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.IDataInput;
   
   public class ZipFile
   {
      
      private var buf:ByteArray;
      
      private var entryList:Array;
      
      private var entryTable:Dictionary;
      
      private var locOffsetTable:Dictionary;
      
      public function ZipFile(param1:IDataInput)
      {
         super();
         buf = new ByteArray();
         buf.endian = "littleEndian";
         param1.readBytes(buf);
         readEntries();
      }
      
      public function get entries() : Array
      {
         return entryList;
      }
      
      public function get size() : uint
      {
         return entryList.length;
      }
      
      public function getEntry(param1:String) : ZipEntry
      {
         return entryTable[param1];
      }
      
      public function getInput(param1:ZipEntry) : ByteArray
      {
         var _loc3_:ByteArray = null;
         var _loc4_:Inflater = null;
         buf.position = locOffsetTable[param1.name] + 30 - 2;
         var _loc5_:uint = uint(buf.readShort());
         buf.position += param1.name.length + _loc5_;
         var _loc2_:ByteArray = new ByteArray();
         if(param1.compressedSize > 0)
         {
            buf.readBytes(_loc2_,0,param1.compressedSize);
         }
         switch(param1.method)
         {
            case 0:
               return _loc2_;
            case 8:
               _loc3_ = new ByteArray();
               _loc4_ = new Inflater();
               _loc4_.setInput(_loc2_);
               _loc4_.inflate(_loc3_);
               return _loc3_;
            default:
               throw new ZipError("invalid compression method");
         }
      }
      
      private function readEntries() : void
      {
         var _loc4_:* = 0;
         var _loc3_:ByteArray = null;
         var _loc2_:* = 0;
         var _loc1_:ZipEntry = null;
         readEND();
         entryTable = new Dictionary();
         locOffsetTable = new Dictionary();
         _loc4_ = 0;
         while(_loc4_ < entryList.length)
         {
            _loc3_ = new ByteArray();
            _loc3_.endian = "littleEndian";
            buf.readBytes(_loc3_,0,46);
            if(_loc3_.readUnsignedInt() != 33639248)
            {
               throw new ZipError("invalid CEN header (bad signature)");
            }
            _loc3_.position = 28;
            _loc2_ = _loc3_.readUnsignedShort();
            if(_loc2_ == 0)
            {
               throw new ZipError("missing entry name");
            }
            _loc1_ = new ZipEntry(buf.readUTFBytes(_loc2_));
            _loc2_ = _loc3_.readUnsignedShort();
            _loc1_.extra = new ByteArray();
            if(_loc2_ > 0)
            {
               buf.readBytes(_loc1_.extra,0,_loc2_);
            }
            buf.position += _loc3_.readUnsignedShort();
            _loc3_.position = 6;
            _loc1_.version = _loc3_.readUnsignedShort();
            _loc1_.flag = _loc3_.readUnsignedShort();
            if((_loc1_.flag & 1) == 1)
            {
               throw new ZipError("encrypted ZIP entry not supported");
            }
            _loc1_.method = _loc3_.readUnsignedShort();
            _loc1_.dostime = _loc3_.readUnsignedInt();
            _loc1_.crc = _loc3_.readUnsignedInt();
            _loc1_.compressedSize = _loc3_.readUnsignedInt();
            _loc1_.size = _loc3_.readUnsignedInt();
            entryList[_loc4_] = _loc1_;
            entryTable[_loc1_.name] = _loc1_;
            _loc3_.position = 42;
            locOffsetTable[_loc1_.name] = _loc3_.readUnsignedInt();
            _loc4_++;
         }
      }
      
      private function readEND() : void
      {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.endian = "littleEndian";
         buf.position = findEND();
         buf.readBytes(_loc1_,0,22);
         _loc1_.position = 10;
         entryList = new Array(_loc1_.readUnsignedShort());
         _loc1_.position = 16;
         buf.position = _loc1_.readUnsignedInt();
      }
      
      private function findEND() : uint
      {
         var _loc2_:uint = buf.length - 22;
         var _loc1_:uint = Math.max(0,_loc2_ - 65535);
         _loc2_;
         while(_loc2_ >= _loc1_)
         {
            if(buf[_loc2_] == 80)
            {
               buf.position = _loc2_;
               if(buf.readUnsignedInt() == 101010256)
               {
                  return _loc2_;
               }
            }
            _loc2_--;
         }
         throw new ZipError("invalid zip");
      }
   }
}

