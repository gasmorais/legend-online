package com.pickgliss.ui.controls.tree
{
   import com.pickgliss.ui.core.Disposeable;
   
   public class TreeNode implements Disposeable
   {
      
      public var info:Object;
      
      public var nodeParent:TreeNode;
      
      public var left:Number;
      
      public var height:Number;
      
      public var tag:int;
      
      public var isOpen:Boolean;
      
      protected var _isDisposed:Boolean;
      
      private var _isRoot:Boolean;
      
      private var _child:Vector.<TreeNode>;
      
      public function TreeNode(param1:Boolean = false)
      {
         super();
         _isRoot = param1;
         _child = new Vector.<TreeNode>();
      }
      
      public function get isRoot() : Boolean
      {
         return _isRoot;
      }
      
      public function get hasChild() : Boolean
      {
         return _child && _child.length > 0;
      }
      
      public function append(param1:TreeNode) : TreeNode
      {
         return appendAt(param1,_child.length);
      }
      
      public function appendAt(param1:TreeNode, param2:int) : TreeNode
      {
         if(param1 == null)
         {
            return param1;
         }
         if(param1.nodeParent)
         {
            if(param1.nodeParent == this)
            {
               return param1;
            }
            param1.nodeParent.remove(param1);
         }
         param1.nodeParent = this;
         if(_child.indexOf(param1) == -1)
         {
            if(param2 > 0 && param2 < _child.length)
            {
               _child.splice(param2,0,param1);
            }
            else
            {
               _child.push(param1);
            }
         }
         return param1;
      }
      
      public function remove(param1:TreeNode) : TreeNode
      {
         var _loc2_:int = _child.indexOf(param1);
         if(_loc2_ != -1)
         {
            _child.splice(_loc2_,1);
         }
         param1.nodeParent = null;
         return param1;
      }
      
      public function children() : Vector.<TreeNode>
      {
         return _child;
      }
      
      public function dispose() : void
      {
         if(!_isDisposed)
         {
            nodeParent = null;
            while(_child.length)
            {
               _child.pop().dispose();
            }
            info = null;
            _child = null;
            _isDisposed = true;
         }
      }
   }
}

