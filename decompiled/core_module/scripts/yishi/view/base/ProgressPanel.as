package yishi.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class ProgressPanel extends Sprite
   {
      
      private var _back:DisplayObject;
      
      private var _bar:DisplayObject;
      
      private var _valueTxt:FilterFrameText;
      
      private var _maskBar:Shape;
      
      private var _curr:Number = 1;
      
      private var _max:Number = 1;
      
      private var _preBar:DisplayObject;
      
      private var _preWidth:int;
      
      public function ProgressPanel()
      {
         super();
      }
      
      public function initView(param1:String, param2:String, param3:String, param4:String = null) : void
      {
         if(param1 != "" && param1 != null)
         {
            _back = ComponentFactory.Instance.creat(param1);
            addChild(_back);
         }
         if(param4 != "" && param4 != null)
         {
            _preBar = ComponentFactory.Instance.creat(param4);
            addChild(_preBar);
            _preWidth = _preBar.width;
            _preBar.visible = false;
         }
         if(param2 != "" && param2 != null)
         {
            _bar = ComponentFactory.Instance.creat(param2);
            addChild(_bar);
         }
         if(param3 != "" && param3 != null)
         {
            _valueTxt = ComponentFactory.Instance.creatComponentByStylename(param3);
            addChild(_valueTxt);
         }
         _maskBar = new Shape();
         _maskBar.x = _bar.x;
         _maskBar.y = _bar.y;
         addChild(_maskBar);
         _bar.mask = _maskBar;
      }
      
      public function barPosxy(param1:int, param2:int) : void
      {
         if(_preBar)
         {
            _preBar.x = param1;
            _preBar.y = param2;
         }
         _bar.x = param1;
         _bar.y = param2;
         _maskBar.x = _bar.x;
         _maskBar.y = _bar.y;
         if(_valueTxt)
         {
            _valueTxt.width = _bar.width;
            _valueTxt.x = _bar.x;
         }
      }
      
      public function progressValue(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         _curr = param1;
         _max = param2;
         if(_max <= 0)
         {
            _max = 1;
         }
         if(_curr > _max)
         {
            _curr = _max;
         }
         var _loc4_:int = _curr / _max * _bar.width;
         _maskBar.graphics.clear();
         _maskBar.graphics.beginFill(16711680);
         _maskBar.graphics.drawRect(0,0,_loc4_,_bar.height);
         _maskBar.graphics.endFill();
         if(_valueTxt)
         {
            if(param3)
            {
               _valueTxt.text = _curr.toString();
            }
            else
            {
               _valueTxt.text = _curr + "/" + _max;
            }
         }
         if(_preBar)
         {
            _preBar.visible = false;
         }
      }
      
      public function previewValue(param1:int) : void
      {
         if(param1 > _max)
         {
            param1 = _max;
         }
         var _loc2_:int = param1 / _max * _preWidth;
         if(_preBar)
         {
            _preBar.visible = true;
            _preBar.width = _loc2_;
         }
      }
      
      public function setPrecentValue(param1:Number, param2:Boolean = false) : void
      {
         var _loc3_:int = param1 * _bar.width;
         _maskBar.graphics.clear();
         _maskBar.graphics.beginFill(16711680);
         _maskBar.graphics.drawRect(0,0,_loc3_,_bar.height);
         _maskBar.graphics.endFill();
         if(_valueTxt)
         {
            if(param2)
            {
               _valueTxt.text = _curr.toString();
            }
            else
            {
               _valueTxt.text = _curr + "/" + _max;
            }
         }
         if(_preBar)
         {
            _preBar.visible = false;
         }
      }
      
      public function showPrecent(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = param1 / param2;
         var _loc4_:int = _loc3_ * _bar.width;
         _maskBar.graphics.clear();
         _maskBar.graphics.beginFill(16711680);
         _maskBar.graphics.drawRect(0,0,_loc4_,_bar.height);
         _maskBar.graphics.endFill();
         if(_valueTxt)
         {
            _valueTxt.text = Math.ceil(_loc3_ * 100) + "%";
         }
      }
      
      public function setValueText(param1:String) : void
      {
         _valueTxt.text = param1;
      }
      
      public function showMax() : void
      {
         progressValue(1,1);
         _valueTxt.text = "Max";
      }
      
      public function setTextFrameIndex(param1:int) : void
      {
         if(_valueTxt)
         {
            _valueTxt.setFrame(param1);
         }
      }
      
      public function get currProgressValue() : Number
      {
         return _curr;
      }
      
      public function get maxProgressValue() : Number
      {
         return _max;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_preBar);
         _preBar = null;
         ObjectUtils.disposeObject(_bar);
         _bar = null;
         ObjectUtils.disposeObject(_valueTxt);
         _valueTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _maskBar = null;
      }
   }
}

