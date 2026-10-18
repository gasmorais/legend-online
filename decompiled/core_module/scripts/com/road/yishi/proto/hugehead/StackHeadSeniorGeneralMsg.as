package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StackHeadSeniorGeneralMsg extends Message implements IExternalizable
   {
      
      private var user_uid$field:String;
      
      private var index$field:int;
      
      private var hasField$0:uint = 0;
      
      private var alive$field:Boolean;
      
      private var in_battle$field:Boolean;
      
      public function StackHeadSeniorGeneralMsg()
      {
         super();
      }
      
      public function removeUserUid() : void
      {
         user_uid$field = null;
      }
      
      public function get hasUserUid() : Boolean
      {
         return user_uid$field != null;
      }
      
      public function set userUid(param1:String) : void
      {
         user_uid$field = param1;
      }
      
      public function get userUid() : String
      {
         return user_uid$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967294;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 1;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeAlive() : void
      {
         hasField$0 &= 4294967293;
         alive$field = new Boolean();
      }
      
      public function get hasAlive() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set alive(param1:Boolean) : void
      {
         hasField$0 |= 2;
         alive$field = param1;
      }
      
      public function get alive() : Boolean
      {
         return alive$field;
      }
      
      public function removeInBattle() : void
      {
         hasField$0 &= 4294967291;
         in_battle$field = new Boolean();
      }
      
      public function get hasInBattle() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set inBattle(param1:Boolean) : void
      {
         hasField$0 |= 4;
         in_battle$field = param1;
      }
      
      public function get inBattle() : Boolean
      {
         return in_battle$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,user_uid$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasAlive)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,alive$field);
         }
         if(hasInBattle)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,in_battle$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadSeniorGeneralMsg.userUid cannot be set twice.");
                  }
                  _loc5_++;
                  userUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadSeniorGeneralMsg.index cannot be set twice.");
                  }
                  _loc3_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadSeniorGeneralMsg.alive cannot be set twice.");
                  }
                  _loc4_++;
                  alive = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadSeniorGeneralMsg.inBattle cannot be set twice.");
                  }
                  _loc6_++;
                  inBattle = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

