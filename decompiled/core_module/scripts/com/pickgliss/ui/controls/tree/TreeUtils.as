package com.pickgliss.ui.controls.tree
{
   public class TreeUtils
   {
      
      public function TreeUtils()
      {
         super();
      }
      
      public static function parseArrayToTree(param1:Array, param2:String) : TreeNode
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc11_:* = undefined;
         var _loc12_:String = null;
         var _loc5_:Array = param2.split(",");
         var _loc10_:Object = {};
         _loc8_ = 0;
         _loc6_ = int(param1.length);
         while(_loc8_ < _loc6_)
         {
            _loc3_ = param1[_loc8_];
            _loc4_ = _loc10_;
            _loc9_ = 0;
            _loc7_ = int(_loc5_.length);
            while(_loc9_ < _loc7_)
            {
               _loc12_ = _loc5_[_loc9_];
               _loc11_ = _loc3_[_loc12_];
               if(_loc4_[_loc11_] == null)
               {
                  _loc4_[_loc11_] = {
                     "value":_loc3_,
                     "child":{}
                  };
               }
               _loc4_ = _loc4_[_loc11_]["child"];
               _loc9_++;
            }
            _loc8_++;
         }
         var _loc13_:TreeNode = new TreeNode(true);
         parseDictToTree(_loc10_,_loc13_);
         return _loc13_;
      }
      
      private static function parseDictToTree(param1:Object, param2:TreeNode) : TreeNode
      {
         var _loc4_:TreeNode = null;
         if(param2 && param1)
         {
            for(var _loc3_:String in param1)
            {
               _loc4_ = new TreeNode();
               _loc4_.info = param1[_loc3_].value;
               parseDictToTree(param1[_loc3_].child,_loc4_);
               param2.append(_loc4_);
            }
         }
         return param2;
      }
      
      internal static function parseTree(param1:TreeNode, param2:Array) : void
      {
         var _loc3_:TreeNode = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc4_ = 0;
         _loc5_ = int(param1.children().length);
         while(_loc4_ < _loc5_)
         {
            _loc3_ = param1.children()[_loc4_];
            param2.push(_loc3_);
            parseTree(_loc3_,param2);
            _loc4_++;
         }
      }
      
      internal static function getArray(param1:Array, param2:Array, param3:Array) : Array
      {
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:TreeNode = null;
         var _loc4_:Array = [];
         var _loc8_:int = 0;
         _loc9_ = 0;
         _loc7_ = int(param1.length);
         while(_loc9_ < _loc7_)
         {
            _loc5_ = param1[_loc9_];
            if(getParentOpenStatus(_loc5_))
            {
               _loc6_ = getDepth(_loc5_);
               if(_loc6_ == 0)
               {
                  _loc5_.left = 0;
               }
               else if(param2[_loc6_] != null)
               {
                  _loc5_.left = param2[_loc6_];
               }
               else
               {
                  _loc5_.left = param2[0] * _loc6_;
               }
               if(param3[_loc6_] != null)
               {
                  _loc5_.height = param3[_loc6_];
               }
               else
               {
                  _loc5_.height = param3[0];
               }
               _loc5_.tag = _loc8_++;
               _loc4_.push(_loc5_);
            }
            _loc9_++;
         }
         return _loc4_;
      }
      
      public static function getDepth(param1:TreeNode, param2:int = 0) : int
      {
         if(param1.nodeParent == null || param1.nodeParent.isRoot)
         {
            return param2;
         }
         return getDepth(param1.nodeParent,param2 + 1);
      }
      
      public static function getParentOpenStatus(param1:TreeNode) : Boolean
      {
         var _loc2_:TreeNode = param1.nodeParent;
         if(_loc2_ == null)
         {
            return true;
         }
         if(_loc2_.isOpen)
         {
            return getParentOpenStatus(_loc2_);
         }
         return _loc2_.isRoot;
      }
   }
}

