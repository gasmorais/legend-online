package yishi.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   
   public class Progress extends Component
   {
      
      public static const P_progressStyle:String = "progressStyle";
      
      public static const P_progressTextStyle:String = "progressTextStyle";
      
      public static const P_data:String = "data";
      
      private var _progressStyle:String;
      
      private var _progressTextStyle:String;
      
      private var _progress:DisplayObject;
      
      private var _mask:Shape;
      
      private var _current:int;
      
      private var _totle:int;
      
      private var _maxGp:Boolean;
      
      private var _progressTxt:FilterFrameText;
      
      public function Progress()
      {
         super();
      }
      
      public function set progressStyle(param1:String) : void
      {
         _progressStyle = param1;
         onPropertiesChanged("progressStyle");
      }
      
      public function get progressStyle() : String
      {
         return _progressStyle;
      }
      
      public function set progressTextStyle(param1:String) : void
      {
         _progressTextStyle = param1;
         onPropertiesChanged("progressTextStyle");
      }
      
      public function get progressTextStyle() : String
      {
         return _progressTextStyle;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         if(_changedPropeties["progressStyle"])
         {
            _progress = ComponentFactory.Instance.creat(_progressStyle);
            if(_progress)
            {
               _mask = new Shape();
               _mask.graphics.beginFill(16777215,0);
               _mask.graphics.drawRect(0,0,_progress.width,_progress.height);
               _mask.graphics.endFill();
               _mask.x = _progress.x;
               _mask.y = _progress.y;
               _progress.mask = _mask;
            }
         }
         if(_changedPropeties["progressTextStyle"])
         {
            _progressTxt = ComponentFactory.Instance.creatComponentByStylename(_progressTextStyle);
         }
         if(_changedPropeties["data"])
         {
            refresh();
         }
         super.onProppertiesUpdate();
      }
      
      override protected function addChildren() : void
      {
         if(_progress)
         {
            addChild(_progress);
         }
         if(_progressTxt)
         {
            addChild(_progressTxt);
         }
         if(_mask)
         {
            addChild(_mask);
         }
      }
      
      public function setFrame(param1:int) : void
      {
         if(_progress)
         {
            _progress["setFrame"](param1);
         }
      }
      
      public function setData(param1:int, param2:int, param3:Boolean = false) : void
      {
         _current = param1;
         _totle = param2;
         _maxGp = param3;
         onPropertiesChanged("data");
      }
      
      public function set text(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(_progressTxt)
         {
            _progressTxt.text = param1;
         }
      }
      
      private function refresh() : void
      {
         if(_progressTxt)
         {
            _progressTxt.text = _current + " / " + _totle;
         }
         _mask.width = _progress.width * _current / _totle;
         if(_maxGp)
         {
            _progressTxt.text = "Max";
         }
      }
      
      private function clear() : void
      {
         if(_progressTxt)
         {
            _progressTxt.text = "0 / 0";
         }
         _mask.width = 1;
      }
      
      override public function dispose() : void
      {
         if(_progress)
         {
            if(_progress.parent)
            {
               _progress.parent.removeChild(_progress);
            }
            _progress.mask = null;
         }
         if(_mask)
         {
            _mask.graphics.clear();
            if(_mask.parent)
            {
               _mask.parent.removeChild(_mask);
            }
         }
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

