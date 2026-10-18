package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class QuickPassInfoMsg extends Message implements IExternalizable
   {
      
      private var beginDate$field:String;
      
      private var saveDate$field:int;
      
      private var hasField$0:uint = 0;
      
      private var turn$field:int;
      
      [ArrayElementType("com.road.yishi.proto.campaign.PassInfoMsg")]
      public var pass:Array = [];
      
      public function QuickPassInfoMsg()
      {
         super();
      }
      
      public function removeBeginDate() : void
      {
         beginDate$field = null;
      }
      
      public function get hasBeginDate() : Boolean
      {
         return beginDate$field != null;
      }
      
      public function set beginDate(param1:String) : void
      {
         beginDate$field = param1;
      }
      
      public function get beginDate() : String
      {
         return beginDate$field;
      }
      
      public function removeSaveDate() : void
      {
         hasField$0 &= 4294967294;
         saveDate$field = new int();
      }
      
      public function get hasSaveDate() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set saveDate(param1:int) : void
      {
         hasField$0 |= 1;
         saveDate$field = param1;
      }
      
      public function get saveDate() : int
      {
         return saveDate$field;
      }
      
      public function removeTurn() : void
      {
         hasField$0 &= 4294967293;
         turn$field = new int();
      }
      
      public function get hasTurn() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set turn(param1:int) : void
      {
         hasField$0 |= 2;
         turn$field = param1;
      }
      
      public function get turn() : int
      {
         return turn$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasBeginDate)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,beginDate$field);
         }
         if(hasSaveDate)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,saveDate$field);
         }
         if(hasTurn)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,turn$field);
         }
         _loc2_ = 0;
         while(_loc2_ < pass.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,pass[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:PassInfoMsg = null;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: QuickPassInfoMsg.beginDate cannot be set twice.");
                  }
                  _loc6_++;
                  beginDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: QuickPassInfoMsg.saveDate cannot be set twice.");
                  }
                  _loc4_++;
                  saveDate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: QuickPassInfoMsg.turn cannot be set twice.");
                  }
                  _loc7_++;
                  turn = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc3_ = new PassInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  pass.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

