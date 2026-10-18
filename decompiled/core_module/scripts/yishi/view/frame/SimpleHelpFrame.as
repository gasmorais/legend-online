package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   
   public class SimpleHelpFrame extends Frame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _desc:Bitmap;
      
      private var _btn:TextButton;
      
      private var _textWidth:int;
      
      private var _textHeight:int;
      
      private var _helpTxt:FilterFrameText;
      
      private var _helpBmp_1:ScaleBitmapImage;
      
      private var _helpBmp_2:ScaleBitmapImage;
      
      private var _helpBmp_3:ScaleBitmapImage;
      
      private var _helpHtmlText:String;
      
      private var _helpPanel:TextArea;
      
      private var _type:String;
      
      private var _callback:Function;
      
      private var _isOpenScorll:Boolean = false;
      
      public function SimpleHelpFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         moveEnable = true;
         enterEnable = true;
         escEnable = true;
      }
      
      public function set callback(param1:Function) : void
      {
         if(_callback == param1)
         {
            return;
         }
         _callback = param1;
      }
      
      public function set background(param1:String) : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename(param1);
      }
      
      public function set helpPanel(param1:String) : void
      {
         _helpPanel = ComponentFactory.Instance.creatComponentByStylename(param1);
      }
      
      public function set btnStyle(param1:String) : void
      {
         _btn = ComponentFactory.Instance.creatComponentByStylename(param1);
         _btn.text = LanguageMgr.GetTranslation("public.confirm");
         _btn.addEventListener("click",__helpHandler);
      }
      
      public function set helpTxt(param1:String) : void
      {
         _helpTxt = ComponentFactory.Instance.creatComponentByStylename(param1);
      }
      
      public function set helpHtmlText(param1:String) : void
      {
         _helpHtmlText = LanguageMgr.GetTranslation(param1);
      }
      
      public function set helpHtmlStr(param1:String) : void
      {
         _helpHtmlText = param1;
      }
      
      public function set textWidth(param1:int) : void
      {
         _textWidth = param1;
      }
      
      public function set textHeight(param1:int) : void
      {
         _textHeight = param1;
      }
      
      public function set helpContent(param1:String) : void
      {
         _desc = ComponentFactory.Instance.creatBitmap(param1);
      }
      
      public function set isOpenScorll(param1:Boolean) : void
      {
         _isOpenScorll = param1;
      }
      
      public function get isOpenScorll() : Boolean
      {
         return _isOpenScorll;
      }
      
      private function creatHelpBmp() : void
      {
         _helpBmp_1 = ComponentFactory.Instance.creatComponentByStylename("worldboss.HelpTextBmp_1");
         _helpBmp_2 = ComponentFactory.Instance.creatComponentByStylename("worldboss.HelpTextBmp_2");
         _helpBmp_3 = ComponentFactory.Instance.creatComponentByStylename("worldboss.HelpTextBmp_3");
         addToContent(_helpBmp_1);
         addToContent(_helpBmp_2);
         addToContent(_helpBmp_3);
      }
      
      private function creatFriendHelpBmp() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 25;
         var _loc1_:int = 51;
         _loc3_ = 1;
         while(_loc3_ < 10)
         {
            creatFriendItemStand(_loc2_,_loc3_ * 22 + _loc1_,_loc3_);
            _loc3_++;
         }
      }
      
      private function creatFriendItemStand(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.friends.StandingsBG");
         var _loc5_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("Friends.ItemStandingsTxt");
         _loc4_.x = param1;
         _loc5_.y = _loc4_.y = param2;
         _loc5_.x = param1 + _loc4_.width;
         _loc5_.text = param3.toString();
         addToContent(_loc4_);
         addToContent(_loc5_);
      }
      
      public function set type(param1:String) : void
      {
         _type = param1;
      }
      
      override public function commitChanges() : void
      {
         super.commitChanges();
         if(_back)
         {
            addToContent(_back);
         }
         if(_desc)
         {
            addToContent(_desc);
         }
         if(_type)
         {
            if(_type == "worldboss")
            {
               creatHelpBmp();
            }
            else if(_type == "friends")
            {
               creatFriendHelpBmp();
            }
         }
         if(_btn)
         {
            addToContent(_btn);
         }
         setPosition();
      }
      
      private function setPosition() : void
      {
         _helpTxt.htmlText = _helpHtmlText;
         _helpTxt.width = _textWidth;
         _helpTxt.height = _textHeight = _helpTxt.textHeight + 5;
         _btn.x = _helpTxt.width / 2 - 40;
         _btn.y = _textHeight + 20;
         _back.width = _helpTxt.width + 24;
         _back.height = _textHeight + 15;
         this.width = _textWidth + 60;
         this.height = _textHeight + 140;
         if(isOpenScorll && _helpTxt.height > _helpPanel.height)
         {
            this.addToContent(_helpPanel);
            _helpPanel.textField = _helpTxt;
            _helpPanel.width = _helpTxt.width + 22;
            _btn.y = _helpPanel.height + 20;
            _back.height = _helpPanel.height + 5;
            this.height = _helpPanel.height + 140;
            _helpPanel.invalidateViewport();
         }
         else
         {
            this.addToContent(_helpTxt);
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResposeHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",__helpHandler);
         removeEventListener("response",__frameResposeHandler);
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      override public function set closestyle(param1:String) : void
      {
      }
      
      public function get confirm() : TextButton
      {
         return _btn;
      }
      
      override public function set titleText(param1:String) : void
      {
         super.titleText = LanguageMgr.GetTranslation(param1);
      }
      
      private function __frameResposeHandler(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
               dispose();
         }
      }
      
      public function show(param1:int = 3) : void
      {
         LayerManager.Instance.addToLayer(this,param1,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         if(!isDie)
         {
            removeEvent();
            KeyBoardRegister.instance.keyEnable = true;
            ObjectUtils.disposeObject(_back);
            _back = null;
            ObjectUtils.disposeObject(_desc);
            _desc = null;
            ObjectUtils.disposeObject(_btn);
            _btn = null;
            ObjectUtils.disposeObject(_helpBmp_1);
            _helpBmp_1 = null;
            ObjectUtils.disposeObject(_helpBmp_2);
            _helpBmp_2 = null;
            ObjectUtils.disposeObject(_helpBmp_3);
            _helpBmp_3 = null;
            ObjectUtils.disposeAllChildren(this);
            super.dispose();
            if(_callback != null)
            {
               _callback();
            }
            _callback = null;
         }
      }
   }
}

