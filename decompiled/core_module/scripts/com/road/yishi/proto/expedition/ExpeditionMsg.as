package com.road.yishi.proto.expedition
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ExpeditionMsg extends Message implements IExternalizable
   {
      
      private var openAreaId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var rewards$field:String;
      
      [ArrayElementType("com.road.yishi.proto.expedition.ExpeditionAreaMsg")]
      public var areas:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.expedition.ExpeditionEditMsg")]
      public var edits:Array = [];
      
      public function ExpeditionMsg()
      {
         super();
      }
      
      public function removeOpenAreaId() : void
      {
         hasField$0 &= 4294967294;
         openAreaId$field = new int();
      }
      
      public function get hasOpenAreaId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set openAreaId(param1:int) : void
      {
         hasField$0 |= 1;
         openAreaId$field = param1;
      }
      
      public function get openAreaId() : int
      {
         return openAreaId$field;
      }
      
      public function removeRewards() : void
      {
         rewards$field = null;
      }
      
      public function get hasRewards() : Boolean
      {
         return rewards$field != null;
      }
      
      public function set rewards(param1:String) : void
      {
         rewards$field = param1;
      }
      
      public function get rewards() : String
      {
         return rewards$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasOpenAreaId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,openAreaId$field);
         }
         if(hasRewards)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,rewards$field);
         }
         _loc3_ = 0;
         while(_loc3_ < areas.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,areas[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < edits.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,edits[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:ExpeditionAreaMsg = null;
         var _loc4_:ExpeditionEditMsg = null;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ExpeditionMsg.openAreaId cannot be set twice.");
                  }
                  _loc7_++;
                  openAreaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ExpeditionMsg.rewards cannot be set twice.");
                  }
                  _loc6_++;
                  rewards = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  _loc3_ = new ExpeditionAreaMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  areas.push(_loc3_);
                  break;
               case 3:
                  _loc4_ = new ExpeditionEditMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  edits.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

