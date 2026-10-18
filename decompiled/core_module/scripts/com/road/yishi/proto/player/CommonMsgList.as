package com.road.yishi.proto.player
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CommonMsgList extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.player.CommonMsg")]
      public var list:Array = [];
      
      private var listParam1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var listParam2$field:int;
      
      private var listParam3$field:String;
      
      private var listParam4$field:String;
      
      public function CommonMsgList()
      {
         super();
      }
      
      public function removeListParam1() : void
      {
         hasField$0 &= 4294967294;
         listParam1$field = new int();
      }
      
      public function get hasListParam1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set listParam1(param1:int) : void
      {
         hasField$0 |= 1;
         listParam1$field = param1;
      }
      
      public function get listParam1() : int
      {
         return listParam1$field;
      }
      
      public function removeListParam2() : void
      {
         hasField$0 &= 4294967293;
         listParam2$field = new int();
      }
      
      public function get hasListParam2() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set listParam2(param1:int) : void
      {
         hasField$0 |= 2;
         listParam2$field = param1;
      }
      
      public function get listParam2() : int
      {
         return listParam2$field;
      }
      
      public function removeListParam3() : void
      {
         listParam3$field = null;
      }
      
      public function get hasListParam3() : Boolean
      {
         return listParam3$field != null;
      }
      
      public function set listParam3(param1:String) : void
      {
         listParam3$field = param1;
      }
      
      public function get listParam3() : String
      {
         return listParam3$field;
      }
      
      public function removeListParam4() : void
      {
         listParam4$field = null;
      }
      
      public function get hasListParam4() : Boolean
      {
         return listParam4$field != null;
      }
      
      public function set listParam4(param1:String) : void
      {
         listParam4$field = param1;
      }
      
      public function get listParam4() : String
      {
         return listParam4$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < list.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,list[_loc2_]);
            _loc2_++;
         }
         if(hasListParam1)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,listParam1$field);
         }
         if(hasListParam2)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,listParam2$field);
         }
         if(hasListParam3)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,listParam3$field);
         }
         if(hasListParam4)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,listParam4$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:CommonMsg = null;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc7_ = new CommonMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  list.push(_loc7_);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CommonMsgList.listParam1 cannot be set twice.");
                  }
                  _loc3_++;
                  listParam1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CommonMsgList.listParam2 cannot be set twice.");
                  }
                  _loc6_++;
                  listParam2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CommonMsgList.listParam3 cannot be set twice.");
                  }
                  _loc5_++;
                  listParam3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CommonMsgList.listParam4 cannot be set twice.");
                  }
                  _loc4_++;
                  listParam4 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

