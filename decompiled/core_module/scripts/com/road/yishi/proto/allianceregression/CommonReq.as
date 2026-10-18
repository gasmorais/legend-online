package com.road.yishi.proto.allianceregression
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CommonReq extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var intParam1$field:int;
      
      private var intParam2$field:int;
      
      private var intParam3$field:int;
      
      private var stringParam1$field:String;
      
      private var stringParam2$field:String;
      
      private var boolParam1$field:Boolean;
      
      private var boolParam2$field:Boolean;
      
      public function CommonReq()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeIntParam1() : void
      {
         hasField$0 &= 4294967293;
         intParam1$field = new int();
      }
      
      public function get hasIntParam1() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set intParam1(param1:int) : void
      {
         hasField$0 |= 2;
         intParam1$field = param1;
      }
      
      public function get intParam1() : int
      {
         return intParam1$field;
      }
      
      public function removeIntParam2() : void
      {
         hasField$0 &= 4294967291;
         intParam2$field = new int();
      }
      
      public function get hasIntParam2() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set intParam2(param1:int) : void
      {
         hasField$0 |= 4;
         intParam2$field = param1;
      }
      
      public function get intParam2() : int
      {
         return intParam2$field;
      }
      
      public function removeIntParam3() : void
      {
         hasField$0 &= 4294967287;
         intParam3$field = new int();
      }
      
      public function get hasIntParam3() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set intParam3(param1:int) : void
      {
         hasField$0 |= 8;
         intParam3$field = param1;
      }
      
      public function get intParam3() : int
      {
         return intParam3$field;
      }
      
      public function removeStringParam1() : void
      {
         stringParam1$field = null;
      }
      
      public function get hasStringParam1() : Boolean
      {
         return stringParam1$field != null;
      }
      
      public function set stringParam1(param1:String) : void
      {
         stringParam1$field = param1;
      }
      
      public function get stringParam1() : String
      {
         return stringParam1$field;
      }
      
      public function removeStringParam2() : void
      {
         stringParam2$field = null;
      }
      
      public function get hasStringParam2() : Boolean
      {
         return stringParam2$field != null;
      }
      
      public function set stringParam2(param1:String) : void
      {
         stringParam2$field = param1;
      }
      
      public function get stringParam2() : String
      {
         return stringParam2$field;
      }
      
      public function removeBoolParam1() : void
      {
         hasField$0 &= 4294967279;
         boolParam1$field = new Boolean();
      }
      
      public function get hasBoolParam1() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set boolParam1(param1:Boolean) : void
      {
         hasField$0 |= 16;
         boolParam1$field = param1;
      }
      
      public function get boolParam1() : Boolean
      {
         return boolParam1$field;
      }
      
      public function removeBoolParam2() : void
      {
         hasField$0 &= 4294967263;
         boolParam2$field = new Boolean();
      }
      
      public function get hasBoolParam2() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set boolParam2(param1:Boolean) : void
      {
         hasField$0 |= 32;
         boolParam2$field = param1;
      }
      
      public function get boolParam2() : Boolean
      {
         return boolParam2$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasIntParam1)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,intParam1$field);
         }
         if(hasIntParam2)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,intParam2$field);
         }
         if(hasIntParam3)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,intParam3$field);
         }
         if(hasStringParam1)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,stringParam1$field);
         }
         if(hasStringParam2)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,stringParam2$field);
         }
         if(hasBoolParam1)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,boolParam1$field);
         }
         if(hasBoolParam2)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,boolParam2$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CommonReq.op cannot be set twice.");
                  }
                  _loc11_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CommonReq.intParam1 cannot be set twice.");
                  }
                  _loc3_++;
                  intParam1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CommonReq.intParam2 cannot be set twice.");
                  }
                  _loc6_++;
                  intParam2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CommonReq.intParam3 cannot be set twice.");
                  }
                  _loc7_++;
                  intParam3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CommonReq.stringParam1 cannot be set twice.");
                  }
                  _loc10_++;
                  stringParam1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CommonReq.stringParam2 cannot be set twice.");
                  }
                  _loc4_++;
                  stringParam2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CommonReq.boolParam1 cannot be set twice.");
                  }
                  _loc5_++;
                  boolParam1 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CommonReq.boolParam2 cannot be set twice.");
                  }
                  _loc9_++;
                  boolParam2 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

