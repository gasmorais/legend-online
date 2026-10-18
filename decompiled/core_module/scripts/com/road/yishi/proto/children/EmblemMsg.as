package com.road.yishi.proto.children
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class EmblemMsg extends Message implements IExternalizable
   {
      
      private var pos$field:int;
      
      private var hasField$0:uint = 0;
      
      private var resi1$field:int;
      
      private var resi1Grade$field:int;
      
      private var resi1Gp$field:int;
      
      private var resi2$field:int;
      
      private var resi2Grade$field:int;
      
      private var resi2Gp$field:int;
      
      private var resi3$field:int;
      
      private var resi3Grade$field:int;
      
      private var resi3Gp$field:int;
      
      public function EmblemMsg()
      {
         super();
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967294;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 1;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeResi1() : void
      {
         hasField$0 &= 4294967293;
         resi1$field = new int();
      }
      
      public function get hasResi1() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set resi1(param1:int) : void
      {
         hasField$0 |= 2;
         resi1$field = param1;
      }
      
      public function get resi1() : int
      {
         return resi1$field;
      }
      
      public function removeResi1Grade() : void
      {
         hasField$0 &= 4294967291;
         resi1Grade$field = new int();
      }
      
      public function get hasResi1Grade() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set resi1Grade(param1:int) : void
      {
         hasField$0 |= 4;
         resi1Grade$field = param1;
      }
      
      public function get resi1Grade() : int
      {
         return resi1Grade$field;
      }
      
      public function removeResi1Gp() : void
      {
         hasField$0 &= 4294967287;
         resi1Gp$field = new int();
      }
      
      public function get hasResi1Gp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set resi1Gp(param1:int) : void
      {
         hasField$0 |= 8;
         resi1Gp$field = param1;
      }
      
      public function get resi1Gp() : int
      {
         return resi1Gp$field;
      }
      
      public function removeResi2() : void
      {
         hasField$0 &= 4294967279;
         resi2$field = new int();
      }
      
      public function get hasResi2() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set resi2(param1:int) : void
      {
         hasField$0 |= 16;
         resi2$field = param1;
      }
      
      public function get resi2() : int
      {
         return resi2$field;
      }
      
      public function removeResi2Grade() : void
      {
         hasField$0 &= 4294967263;
         resi2Grade$field = new int();
      }
      
      public function get hasResi2Grade() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set resi2Grade(param1:int) : void
      {
         hasField$0 |= 32;
         resi2Grade$field = param1;
      }
      
      public function get resi2Grade() : int
      {
         return resi2Grade$field;
      }
      
      public function removeResi2Gp() : void
      {
         hasField$0 &= 4294967231;
         resi2Gp$field = new int();
      }
      
      public function get hasResi2Gp() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set resi2Gp(param1:int) : void
      {
         hasField$0 |= 64;
         resi2Gp$field = param1;
      }
      
      public function get resi2Gp() : int
      {
         return resi2Gp$field;
      }
      
      public function removeResi3() : void
      {
         hasField$0 &= 4294967167;
         resi3$field = new int();
      }
      
      public function get hasResi3() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set resi3(param1:int) : void
      {
         hasField$0 |= 128;
         resi3$field = param1;
      }
      
      public function get resi3() : int
      {
         return resi3$field;
      }
      
      public function removeResi3Grade() : void
      {
         hasField$0 &= 4294967039;
         resi3Grade$field = new int();
      }
      
      public function get hasResi3Grade() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set resi3Grade(param1:int) : void
      {
         hasField$0 |= 256;
         resi3Grade$field = param1;
      }
      
      public function get resi3Grade() : int
      {
         return resi3Grade$field;
      }
      
      public function removeResi3Gp() : void
      {
         hasField$0 &= 4294966783;
         resi3Gp$field = new int();
      }
      
      public function get hasResi3Gp() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set resi3Gp(param1:int) : void
      {
         hasField$0 |= 512;
         resi3Gp$field = param1;
      }
      
      public function get resi3Gp() : int
      {
         return resi3Gp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasResi1)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,resi1$field);
         }
         if(hasResi1Grade)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,resi1Grade$field);
         }
         if(hasResi1Gp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,resi1Gp$field);
         }
         if(hasResi2)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,resi2$field);
         }
         if(hasResi2Grade)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,resi2Grade$field);
         }
         if(hasResi2Gp)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,resi2Gp$field);
         }
         if(hasResi3)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,resi3$field);
         }
         if(hasResi3Grade)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,resi3Grade$field);
         }
         if(hasResi3Gp)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,resi3Gp$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         var _loc13_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: EmblemMsg.pos cannot be set twice.");
                  }
                  _loc6_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: EmblemMsg.resi1 cannot be set twice.");
                  }
                  _loc4_++;
                  resi1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: EmblemMsg.resi1Grade cannot be set twice.");
                  }
                  _loc8_++;
                  resi1Grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: EmblemMsg.resi1Gp cannot be set twice.");
                  }
                  _loc11_++;
                  resi1Gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: EmblemMsg.resi2 cannot be set twice.");
                  }
                  _loc5_++;
                  resi2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: EmblemMsg.resi2Grade cannot be set twice.");
                  }
                  _loc13_++;
                  resi2Grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: EmblemMsg.resi2Gp cannot be set twice.");
                  }
                  _loc10_++;
                  resi2Gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: EmblemMsg.resi3 cannot be set twice.");
                  }
                  _loc7_++;
                  resi3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: EmblemMsg.resi3Grade cannot be set twice.");
                  }
                  _loc3_++;
                  resi3Grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: EmblemMsg.resi3Gp cannot be set twice.");
                  }
                  _loc9_++;
                  resi3Gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

