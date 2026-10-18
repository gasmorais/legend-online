package com.road.yishi.proto.novice
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class NoviceReqMsgMsg extends Message implements IExternalizable
   {
      
      private var novice_process$field:int;
      
      private var hasField$0:uint = 0;
      
      private var army_id$field:int;
      
      private var type$field:int;
      
      private var arms_id$field:int;
      
      private var goods_id$field:int;
      
      private var grade_process$field:String;
      
      public function NoviceReqMsgMsg()
      {
         super();
      }
      
      public function removeNoviceProcess() : void
      {
         hasField$0 &= 4294967294;
         novice_process$field = new int();
      }
      
      public function get hasNoviceProcess() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set noviceProcess(param1:int) : void
      {
         hasField$0 |= 1;
         novice_process$field = param1;
      }
      
      public function get noviceProcess() : int
      {
         return novice_process$field;
      }
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4294967293;
         army_id$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 2;
         army_id$field = param1;
      }
      
      public function get armyId() : int
      {
         return army_id$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967291;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 4;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeArmsId() : void
      {
         hasField$0 &= 4294967287;
         arms_id$field = new int();
      }
      
      public function get hasArmsId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set armsId(param1:int) : void
      {
         hasField$0 |= 8;
         arms_id$field = param1;
      }
      
      public function get armsId() : int
      {
         return arms_id$field;
      }
      
      public function removeGoodsId() : void
      {
         hasField$0 &= 4294967279;
         goods_id$field = new int();
      }
      
      public function get hasGoodsId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set goodsId(param1:int) : void
      {
         hasField$0 |= 16;
         goods_id$field = param1;
      }
      
      public function get goodsId() : int
      {
         return goods_id$field;
      }
      
      public function removeGradeProcess() : void
      {
         grade_process$field = null;
      }
      
      public function get hasGradeProcess() : Boolean
      {
         return grade_process$field != null;
      }
      
      public function set gradeProcess(param1:String) : void
      {
         grade_process$field = param1;
      }
      
      public function get gradeProcess() : String
      {
         return grade_process$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNoviceProcess)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,novice_process$field);
         }
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,army_id$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasArmsId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,arms_id$field);
         }
         if(hasGoodsId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,goods_id$field);
         }
         if(hasGradeProcess)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,grade_process$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: NoviceReqMsgMsg.noviceProcess cannot be set twice.");
                  }
                  _loc5_++;
                  noviceProcess = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: NoviceReqMsgMsg.armyId cannot be set twice.");
                  }
                  _loc6_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: NoviceReqMsgMsg.type cannot be set twice.");
                  }
                  _loc8_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: NoviceReqMsgMsg.armsId cannot be set twice.");
                  }
                  _loc7_++;
                  armsId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: NoviceReqMsgMsg.goodsId cannot be set twice.");
                  }
                  _loc4_++;
                  goodsId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: NoviceReqMsgMsg.gradeProcess cannot be set twice.");
                  }
                  _loc3_++;
                  gradeProcess = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

