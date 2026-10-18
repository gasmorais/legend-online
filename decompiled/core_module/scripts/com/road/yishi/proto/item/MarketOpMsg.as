package com.road.yishi.proto.item
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MarketOpMsg extends Message implements IExternalizable
   {
      
      private var op_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var stall$field:StallMsg;
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      private var param3$field:int;
      
      private var param4$field:int;
      
      private var param5$field:String;
      
      private var param6$field:Boolean;
      
      public function MarketOpMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         op_type$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         op_type$field = param1;
      }
      
      public function get opType() : int
      {
         return op_type$field;
      }
      
      public function removeStall() : void
      {
         stall$field = null;
      }
      
      public function get hasStall() : Boolean
      {
         return stall$field != null;
      }
      
      public function set stall(param1:StallMsg) : void
      {
         stall$field = param1;
      }
      
      public function get stall() : StallMsg
      {
         return stall$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967293;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 2;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967291;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 4;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      public function removeParam3() : void
      {
         hasField$0 &= 4294967287;
         param3$field = new int();
      }
      
      public function get hasParam3() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set param3(param1:int) : void
      {
         hasField$0 |= 8;
         param3$field = param1;
      }
      
      public function get param3() : int
      {
         return param3$field;
      }
      
      public function removeParam4() : void
      {
         hasField$0 &= 4294967279;
         param4$field = new int();
      }
      
      public function get hasParam4() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set param4(param1:int) : void
      {
         hasField$0 |= 16;
         param4$field = param1;
      }
      
      public function get param4() : int
      {
         return param4$field;
      }
      
      public function removeParam5() : void
      {
         param5$field = null;
      }
      
      public function get hasParam5() : Boolean
      {
         return param5$field != null;
      }
      
      public function set param5(param1:String) : void
      {
         param5$field = param1;
      }
      
      public function get param5() : String
      {
         return param5$field;
      }
      
      public function removeParam6() : void
      {
         hasField$0 &= 4294967263;
         param6$field = new Boolean();
      }
      
      public function get hasParam6() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set param6(param1:Boolean) : void
      {
         hasField$0 |= 32;
         param6$field = param1;
      }
      
      public function get param6() : Boolean
      {
         return param6$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
         if(hasStall)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,stall$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,param3$field);
         }
         if(hasParam4)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,param4$field);
         }
         if(hasParam5)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,param5$field);
         }
         if(hasParam6)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,param6$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MarketOpMsg.opType cannot be set twice.");
                  }
                  _loc4_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MarketOpMsg.stall cannot be set twice.");
                  }
                  _loc8_++;
                  stall = new StallMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,stall);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MarketOpMsg.param1 cannot be set twice.");
                  }
                  _loc5_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MarketOpMsg.param2 cannot be set twice.");
                  }
                  _loc11_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MarketOpMsg.param3 cannot be set twice.");
                  }
                  _loc6_++;
                  param3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MarketOpMsg.param4 cannot be set twice.");
                  }
                  _loc10_++;
                  param4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MarketOpMsg.param5 cannot be set twice.");
                  }
                  _loc3_++;
                  param5 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MarketOpMsg.param6 cannot be set twice.");
                  }
                  _loc9_++;
                  param6 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

