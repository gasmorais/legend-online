package com.pickgliss.ui.controls.cell
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.tree.TreeNode;
   import com.pickgliss.ui.controls.tree.TreeUtils;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class TreeListCell extends Component implements ITreeListCell
   {
      
      public static const P_arrowStyle:String = "arrowStyle";
      
      protected var _data:TreeNode;
      
      protected var _depth:int;
      
      protected var _arrow:ScaleFrameImage;
      
      protected var _container:Sprite = new Sprite();
      
      protected var _arrowStyle:String;
      
      public function TreeListCell()
      {
         addChild(_container);
         super();
      }
      
      protected function addToContainer(param1:DisplayObject) : DisplayObject
      {
         return _container.addChild(param1);
      }
      
      public function setCellOverStatus(param1:Boolean) : void
      {
      }
      
      public function setCellSelectStatus(param1:Boolean) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1;
         if(_data)
         {
            _depth = TreeUtils.getDepth(_data);
         }
         else
         {
            _depth = -1;
         }
      }
      
      override public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function get arrowStyle() : String
      {
         return _arrowStyle;
      }
      
      public function set arrowStyle(param1:String) : void
      {
         if(_arrowStyle == param1)
         {
            return;
         }
         _arrowStyle = param1;
         onPropertiesChanged("arrowStyle");
      }
      
      public function get arrow() : ScaleFrameImage
      {
         return _arrow;
      }
      
      public function get container() : Sprite
      {
         return _container;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["arrowStyle"])
         {
            _arrow = ComponentFactory.Instance.creatComponentByStylename(_arrowStyle);
         }
      }
      
      override public function dispose() : void
      {
         _data = null;
         ObjectUtils.disposeObject(_arrow);
         _arrow = null;
         ObjectUtils.disposeAllChildren(_container);
         _container = null;
         super.dispose();
      }
   }
}

