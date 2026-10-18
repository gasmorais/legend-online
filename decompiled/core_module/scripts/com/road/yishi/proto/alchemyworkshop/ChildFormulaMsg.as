package com.road.yishi.proto.alchemyworkshop
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildFormulaMsg extends Message implements IExternalizable
   {
      
      private var childIndex$field:int;
      
      private var hasField$0:uint = 0;
      
      private var userId$field:int;
      
      private var nickName$field:String;
      
      private var isAddCatalyst$field:Boolean;
      
      public function ChildFormulaMsg()
      {
         super();
      }
      
      public function removeChildIndex() : void
      {
         hasField$0 &= 4294967294;
         childIndex$field = new int();
      }
      
      public function get hasChildIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set childIndex(param1:int) : void
      {
         hasField$0 |= 1;
         childIndex$field = param1;
      }
      
      public function get childIndex() : int
      {
         return childIndex$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967293;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 2;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
      }
      
      public function removeIsAddCatalyst() : void
      {
         hasField$0 &= 4294967291;
         isAddCatalyst$field = new Boolean();
      }
      
      public function get hasIsAddCatalyst() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isAddCatalyst(param1:Boolean) : void
      {
         hasField$0 |= 4;
         isAddCatalyst$field = param1;
      }
      
      public function get isAddCatalyst() : Boolean
      {
         return isAddCatalyst$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasChildIndex)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,childIndex$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasIsAddCatalyst)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isAddCatalyst$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChildFormulaMsg.childIndex cannot be set twice.");
                  }
                  _loc5_++;
                  childIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChildFormulaMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildFormulaMsg.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildFormulaMsg.isAddCatalyst cannot be set twice.");
                  }
                  _loc3_++;
                  isAddCatalyst = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

