package yishi.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import utils.LogicUtils;
   
   public class TokenAmountItem extends Component
   {
      
      private const LEFT:String = "left";
      
      private const CENTER:String = "center";
      
      private const RIGHT:String = "right";
      
      private var _layout:String = "left";
      
      private var _iconLink:String;
      
      private var _iconImg:Component;
      
      private var _iconTipStyle:String;
      
      private var _iconTipData:Object;
      
      private var _firstTxtLink:String;
      
      private var _firstTxt:FilterFrameText;
      
      private var _firstText:String = "";
      
      private var _secondTxtLink:String;
      
      private var _secondTxt:FilterFrameText;
      
      private var _secondText:String = "";
      
      private var _space:int = 6;
      
      private var _views:Vector.<DisplayObject> = new Vector.<DisplayObject>();
      
      private var _maxHeight:int;
      
      public function TokenAmountItem()
      {
         super();
      }
      
      public function set iconTipData(param1:Object) : void
      {
         _iconTipData = param1;
         LogicUtils.addToRender(this,render);
      }
      
      public function set iconTipStyle(param1:String) : void
      {
         if(_iconTipStyle != param1)
         {
            _iconTipStyle = param1;
            LogicUtils.addToRender(this,render);
         }
      }
      
      public function set xy(param1:String) : void
      {
         var _loc2_:Array = param1.split(",");
         this.x = _loc2_[0];
         this.y = _loc2_[1];
      }
      
      public function set space(param1:int) : void
      {
         _space = param1;
      }
      
      public function set firstTxtLink(param1:String) : void
      {
         if(_firstTxtLink != param1)
         {
            ObjectUtils.disposeObject(_firstTxt);
            _firstTxt = null;
            _firstTxtLink = param1;
            LogicUtils.addToRender(this,render);
         }
      }
      
      public function set firstText(param1:String) : void
      {
         if(_firstText != param1)
         {
            _firstText = param1;
            LogicUtils.addToRender(this,render);
         }
      }
      
      public function setFirstText(param1:String) : void
      {
         if(_firstTxt && _firstText != param1)
         {
            _firstText = param1;
            _firstTxt.text = param1;
            doLayout();
         }
      }
      
      public function set secondTxtLink(param1:String) : void
      {
         if(_secondTxtLink != param1)
         {
            ObjectUtils.disposeObject(_secondTxt);
            _secondTxt = null;
            _secondTxtLink = param1;
            LogicUtils.addToRender(this,render);
         }
      }
      
      public function set secondText(param1:String) : void
      {
         if(_secondText != param1)
         {
            _secondText = param1;
            LogicUtils.addToRender(this,render);
         }
      }
      
      public function setSecondText(param1:String) : void
      {
         if(_secondTxt && _secondText != param1)
         {
            _secondText = param1;
            _secondTxt.text = param1;
            doLayout();
         }
      }
      
      public function set countText(param1:String) : void
      {
         if(_firstText != param1)
         {
            _firstText = param1;
            render();
         }
      }
      
      public function set iconLink(param1:String) : void
      {
         if(_iconLink != param1)
         {
            ObjectUtils.disposeObject(_iconImg);
            _iconImg = null;
            _iconLink = param1;
            LogicUtils.addToRender(this,render);
         }
      }
      
      public function set layout(param1:String) : void
      {
         if(_layout != param1)
         {
            _layout = param1;
            LogicUtils.addToRender(this,render);
         }
      }
      
      private function render() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         if(!_iconImg && _iconLink)
         {
            _iconImg = new Component();
            _loc1_ = ClassUtils.getDefinition(_iconLink);
            if(_loc1_)
            {
               _loc2_ = new _loc1_();
            }
            else
            {
               _loc2_ = ComponentFactory.Instance.creatBitmapData(_iconLink);
            }
            _loc2_.x = _loc2_.y = 0;
            if(_loc2_ is BitmapData)
            {
               _loc2_ = new Bitmap(BitmapData(_loc2_));
            }
            _iconImg.width = _loc2_.width;
            _iconImg.height = _loc2_.height;
            _iconImg.addChild(DisplayObject(_loc2_));
         }
         if(!_firstTxt && _firstTxtLink)
         {
            _firstTxt = ComponentFactory.Instance.creatComponentByStylename(_firstTxtLink);
         }
         if(!_secondTxt && _secondTxtLink)
         {
            _secondTxt = ComponentFactory.Instance.creatComponentByStylename(_secondTxtLink);
         }
         if(_iconImg)
         {
            _iconImg.tipStyle = _iconTipStyle;
            _iconImg.tipData = _iconTipData;
         }
         if(_firstTxt)
         {
            _firstTxt.text = _firstText;
         }
         if(_secondTxt)
         {
            _secondTxt.text = _secondText;
         }
         doLayout();
      }
      
      private function doLayout() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _views.length = 0;
         if(_layout == "left")
         {
            setAutoSize(_firstTxt,"left");
            setAutoSize(_secondTxt,"left");
            addView(_iconImg,_firstTxt,_secondTxt);
         }
         else if(_layout == "center")
         {
            setAutoSize(_firstTxt,"right");
            setAutoSize(_secondTxt,"left");
            addView(_firstTxt,_iconImg,_secondTxt);
         }
         else if(_layout == "right")
         {
            setAutoSize(_firstTxt,"right");
            setAutoSize(_secondTxt,"right");
            addView(_firstTxt,_secondTxt,_iconImg);
         }
         _loc2_ = 0;
         while(_loc2_ < _views.length)
         {
            _views[_loc2_].x = _loc1_;
            _views[_loc2_].y = (_maxHeight - _views[_loc2_].height) * 0.5;
            this.addChild(_views[_loc2_]);
            _loc1_ += _views[_loc2_].width + _space;
            _loc2_++;
         }
      }
      
      private function setAutoSize(param1:FilterFrameText, param2:String) : void
      {
         if(param1)
         {
            param1.autoSize = param2;
         }
      }
      
      private function addView(... rest) : void
      {
         var _loc2_:int = 0;
         if(rest)
         {
            _loc2_ = 0;
            while(_loc2_ < rest.length)
            {
               if(rest[_loc2_])
               {
                  _views.push(rest[_loc2_]);
                  if(rest[_loc2_].height > _maxHeight)
                  {
                     _maxHeight = rest[_loc2_].height;
                  }
               }
               _loc2_++;
            }
         }
      }
      
      override public function dispose() : void
      {
         if(_views)
         {
            LogicUtils.disposeDisplayCollection(_views);
            _views = null;
         }
         _iconImg = null;
         _firstTxt = null;
         _secondTxt = null;
         _iconTipData = null;
         super.dispose();
      }
   }
}

