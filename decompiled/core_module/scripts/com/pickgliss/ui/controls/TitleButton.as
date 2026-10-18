package com.pickgliss.ui.controls
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class TitleButton extends Component
   {
      
      private var _titleText:FilterFrameText;
      
      private var _bgUp:Bitmap;
      
      private var _bgDown:Bitmap;
      
      public function TitleButton()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _titleText = ComponentFactory.Instance.creatComponentByStylename("auction.ListTitleText");
         _bgUp = ComponentFactory.Instance.creatBitmap("asset.auction.arrowsUp");
         _bgDown = ComponentFactory.Instance.creatBitmap("asset.auction.arrowsDown");
         addChild(_titleText);
         _titleText.mouseEnabled = false;
         _titleText.selectable = false;
         mouseEnabled = true;
         this.mouseChildren = true;
         addChild(_bgUp);
         addChild(_bgDown);
         setFrame = 0;
      }
      
      override public function set width(param1:Number) : void
      {
         _titleText.width = param1;
         _bgUp.x = param1 - 18;
         _bgDown.x = param1 - 18;
         super.width = param1;
      }
      
      override public function set height(param1:Number) : void
      {
         _titleText.height = param1;
         _bgUp.y = 3;
         _bgDown.y = 3;
         super.height = param1;
      }
      
      public function set setFrame(param1:int) : void
      {
         _bgUp.visible = false;
         _bgDown.visible = false;
         setTitleColor(1);
         if(param1 == 1)
         {
            _bgDown.visible = true;
            setTitleColor(2);
         }
         else if(param1 == 2)
         {
            _bgUp.visible = true;
            setTitleColor(2);
         }
      }
      
      private function setTitleColor(param1:int) : void
      {
         if(param1 == 1)
         {
            _titleText.textColor = 16378053;
         }
         else
         {
            _titleText.textColor = 15982868;
         }
      }
      
      public function addMouseEffect() : void
      {
         addEventListener("mouseOver",onMouseOver);
         addEventListener("mouseOut",onMouseOut);
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         if(!_bgUp.visible && !_bgDown.visible)
         {
            setTitleColor(1);
         }
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         if(!_bgUp.visible && !_bgDown.visible)
         {
            setTitleColor(2);
         }
      }
      
      public function set text(param1:String) : void
      {
         _titleText.text = param1;
      }
      
      override public function dispose() : void
      {
         removeEventListener("mouseOver",onMouseOver);
         removeEventListener("mouseOut",onMouseOut);
         _bgUp = null;
         _bgDown = null;
         _titleText = null;
         super.dispose();
      }
   }
}

