package com.road.yishi.proto.marriage
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MarriageGodTreeMsg extends Message implements IExternalizable
   {
      
      private var tree_gp$field:int;
      
      private var hasField$0:uint = 0;
      
      private var tree_grade$field:int;
      
      private var tree_gold_water$field:int;
      
      private var tree_diamond_water$field:int;
      
      private var tree_state$field:int;
      
      private var tree_state_value$field:int;
      
      private var tree_earning_date$field:String;
      
      private var tree_mate_state$field:int;
      
      public function MarriageGodTreeMsg()
      {
         super();
      }
      
      public function removeTreeGp() : void
      {
         hasField$0 &= 4294967294;
         tree_gp$field = new int();
      }
      
      public function get hasTreeGp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set treeGp(param1:int) : void
      {
         hasField$0 |= 1;
         tree_gp$field = param1;
      }
      
      public function get treeGp() : int
      {
         return tree_gp$field;
      }
      
      public function removeTreeGrade() : void
      {
         hasField$0 &= 4294967293;
         tree_grade$field = new int();
      }
      
      public function get hasTreeGrade() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set treeGrade(param1:int) : void
      {
         hasField$0 |= 2;
         tree_grade$field = param1;
      }
      
      public function get treeGrade() : int
      {
         return tree_grade$field;
      }
      
      public function removeTreeGoldWater() : void
      {
         hasField$0 &= 4294967291;
         tree_gold_water$field = new int();
      }
      
      public function get hasTreeGoldWater() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set treeGoldWater(param1:int) : void
      {
         hasField$0 |= 4;
         tree_gold_water$field = param1;
      }
      
      public function get treeGoldWater() : int
      {
         return tree_gold_water$field;
      }
      
      public function removeTreeDiamondWater() : void
      {
         hasField$0 &= 4294967287;
         tree_diamond_water$field = new int();
      }
      
      public function get hasTreeDiamondWater() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set treeDiamondWater(param1:int) : void
      {
         hasField$0 |= 8;
         tree_diamond_water$field = param1;
      }
      
      public function get treeDiamondWater() : int
      {
         return tree_diamond_water$field;
      }
      
      public function removeTreeState() : void
      {
         hasField$0 &= 4294967279;
         tree_state$field = new int();
      }
      
      public function get hasTreeState() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set treeState(param1:int) : void
      {
         hasField$0 |= 16;
         tree_state$field = param1;
      }
      
      public function get treeState() : int
      {
         return tree_state$field;
      }
      
      public function removeTreeStateValue() : void
      {
         hasField$0 &= 4294967263;
         tree_state_value$field = new int();
      }
      
      public function get hasTreeStateValue() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set treeStateValue(param1:int) : void
      {
         hasField$0 |= 32;
         tree_state_value$field = param1;
      }
      
      public function get treeStateValue() : int
      {
         return tree_state_value$field;
      }
      
      public function removeTreeEarningDate() : void
      {
         tree_earning_date$field = null;
      }
      
      public function get hasTreeEarningDate() : Boolean
      {
         return tree_earning_date$field != null;
      }
      
      public function set treeEarningDate(param1:String) : void
      {
         tree_earning_date$field = param1;
      }
      
      public function get treeEarningDate() : String
      {
         return tree_earning_date$field;
      }
      
      public function removeTreeMateState() : void
      {
         hasField$0 &= 4294967231;
         tree_mate_state$field = new int();
      }
      
      public function get hasTreeMateState() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set treeMateState(param1:int) : void
      {
         hasField$0 |= 64;
         tree_mate_state$field = param1;
      }
      
      public function get treeMateState() : int
      {
         return tree_mate_state$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTreeGp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,tree_gp$field);
         }
         if(hasTreeGrade)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,tree_grade$field);
         }
         if(hasTreeGoldWater)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,tree_gold_water$field);
         }
         if(hasTreeDiamondWater)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,tree_diamond_water$field);
         }
         if(hasTreeState)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,tree_state$field);
         }
         if(hasTreeStateValue)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,tree_state_value$field);
         }
         if(hasTreeEarningDate)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,tree_earning_date$field);
         }
         if(hasTreeMateState)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,tree_mate_state$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageGodTreeMsg.treeGp cannot be set twice.");
                  }
                  _loc7_++;
                  treeGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageGodTreeMsg.treeGrade cannot be set twice.");
                  }
                  _loc3_++;
                  treeGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageGodTreeMsg.treeGoldWater cannot be set twice.");
                  }
                  _loc11_++;
                  treeGoldWater = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageGodTreeMsg.treeDiamondWater cannot be set twice.");
                  }
                  _loc4_++;
                  treeDiamondWater = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageGodTreeMsg.treeState cannot be set twice.");
                  }
                  _loc9_++;
                  treeState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageGodTreeMsg.treeStateValue cannot be set twice.");
                  }
                  _loc8_++;
                  treeStateValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageGodTreeMsg.treeEarningDate cannot be set twice.");
                  }
                  _loc6_++;
                  treeEarningDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageGodTreeMsg.treeMateState cannot be set twice.");
                  }
                  _loc5_++;
                  treeMateState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

