package yishi.comm
{
   import com.netease.protobuf.Message;
   import flash.utils.ByteArray;
   
   public class PackageIn extends ByteArray
   {
      
      public static const HEADER_SIZE:Number = 20;
      
      private var _len:int;
      
      private var _checksum:int;
      
      private var _clientId:int;
      
      private var _code:int;
      
      private var _extend1:int;
      
      private var _extend2:int;
      
      public function PackageIn()
      {
         super();
      }
      
      public function load(param1:ByteArray, param2:int) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param2)
         {
            writeByte(param1.readByte());
            _loc3_++;
         }
         position = 0;
         readHeader();
      }
      
      public function loadE(param1:ByteArray, param2:int, param3:ByteArray) : void
      {
         var _loc6_:int = 0;
         var _loc5_:ByteArray = new ByteArray();
         var _loc4_:ByteArray = new ByteArray();
         _loc6_ = 0;
         while(_loc6_ < param2)
         {
            _loc5_.writeByte(param1.readByte());
            _loc4_.writeByte(_loc5_[_loc6_]);
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < param2)
         {
            if(_loc6_ > 0)
            {
               param3[_loc6_ % 8] = param3[_loc6_ % 8] + _loc5_[_loc6_ - 1] ^ _loc6_;
               _loc4_[_loc6_] = _loc5_[_loc6_] - _loc5_[_loc6_ - 1] ^ param3[_loc6_ % 8];
            }
            else
            {
               _loc4_[_loc6_] = _loc5_[_loc6_] ^ param3[0];
            }
            _loc6_++;
         }
         _loc4_.position = 0;
         _loc6_ = 0;
         while(_loc6_ < param2)
         {
            writeByte(_loc4_.readByte());
            _loc6_++;
         }
         position = 0;
         readHeader();
      }
      
      public function readHeader() : void
      {
         readShort();
         _len = readShort();
         _checksum = readShort();
         _code = readShort();
         _clientId = readInt();
         _extend1 = readInt();
         _extend2 = readInt();
      }
      
      public function get checkSum() : int
      {
         return _checksum;
      }
      
      public function readBody(param1:Message) : Message
      {
         this.position = 20;
         param1.readExternal(this);
         return param1;
      }
      
      public function get code() : int
      {
         return _code;
      }
      
      public function get clientId() : int
      {
         return _clientId;
      }
      
      public function get extend1() : int
      {
         return _extend1;
      }
      
      public function get extend2() : int
      {
         return _extend2;
      }
      
      public function set updateLeftTime(param1:int) : void
      {
         _extend2 = param1;
      }
      
      public function get Len() : int
      {
         return _len;
      }
      
      public function calculateCheckSum() : int
      {
         var _loc1_:int = 119;
         var _loc2_:int = 6;
         while(_loc2_ < length)
         {
            _loc1_ += this[_loc2_++];
         }
         return _loc1_ & 0x7F7F;
      }
      
      public function readXml() : XML
      {
         return new XML(readUTF());
      }
      
      public function readDateString() : String
      {
         return readShort() + "-" + readByte() + "-" + readByte() + " " + readByte() + ":" + readByte() + ":" + readByte();
      }
      
      public function readDate() : Date
      {
         var _loc5_:int = readShort();
         var _loc4_:int = readByte() - 1;
         var _loc7_:int = readByte();
         var _loc2_:int = readByte();
         var _loc6_:int = readByte();
         var _loc3_:int = readByte();
         return new Date(_loc5_,_loc4_,_loc7_,_loc2_,_loc6_,_loc3_);
      }
      
      public function readByteArray() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         readBytes(_loc1_,0,_len - position);
         _loc1_.position = 0;
         return _loc1_;
      }
      
      public function deCompress() : void
      {
         position = 20;
         var _loc1_:ByteArray = new ByteArray();
         readBytes(_loc1_,0,_len - 20);
         _loc1_.uncompress();
         position = 20;
         writeBytes(_loc1_,0,_loc1_.length);
         _len = 20 + _loc1_.length;
         position = 20;
      }
   }
}

