package yishi.view.base
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   
   public class BaseHelpFrame extends Frame implements IManualSize
   {
      
      private var _rect:Rectangle;
      
      private var _back:ScaleBitmapImage;
      
      private var _desc:Bitmap;
      
      private var _btn:TextButton;
      
      private var _helpTxt:FilterFrameText;
      
      private var _helpBmp_1:ScaleBitmapImage;
      
      private var _helpBmp_2:ScaleBitmapImage;
      
      private var _helpBmp_3:ScaleBitmapImage;
      
      private var _type:String;
      
      private var _callback:Function;
      
      public function BaseHelpFrame()
      {
         super();
         _rect = new Rectangle(0,0,100,100);
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _rect;
      }
      
      private function initView() : void
      {
         moveEnable = true;
         enterEnable = true;
         escEnable = true;
      }
      
      public function set helpTxt(param1:String) : void
      {
         _helpTxt = ComponentFactory.Instance.creatComponentByStylename(param1);
         _helpTxt.multiline = true;
      }
      
      private function creatHelpBmp() : void
      {
         _helpBmp_1 = ComponentFactory.Instance.creatComponentByStylename("worldboss.HelpTextBmp_1");
         _helpBmp_2 = ComponentFactory.Instance.creatComponentByStylename("worldboss.HelpTextBmp_2");
         _helpBmp_3 = ComponentFactory.Instance.creatComponentByStylename("worldboss.HelpTextBmp_3");
         if(_back)
         {
            _back.addChild(_helpBmp_1);
            _back.addChild(_helpBmp_2);
            _back.addChild(_helpBmp_3);
         }
      }
      
      private function creatFriendHelpBmp() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 25;
         var _loc1_:int = 34;
         _loc3_ = 1;
         while(_loc3_ < 10)
         {
            creatFriendItemStand(_loc2_,_loc3_ * 21 + _loc1_,_loc3_);
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
         if(_back)
         {
            _back.addChild(_loc4_);
            _back.addChild(_loc5_);
         }
      }
      
      public function set type(param1:String) : void
      {
         _type = param1;
         if(_type == "worldboss")
         {
            creatHelpBmp();
         }
         else if(_type == "friends")
         {
            creatFriendHelpBmp();
         }
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
      
      public function set btnStyle(param1:String) : void
      {
         _btn = ComponentFactory.Instance.creatComponentByStylename(param1);
         _btn.text = LanguageMgr.GetTranslation("public.confirm");
         _btn.addEventListener("click",__helpHandler);
      }
      
      public function set helpContent(param1:String) : void
      {
         _desc = ComponentFactory.Instance.creatBitmap(param1);
      }
      
      public function set helpHtmlText(param1:String) : void
      {
         _helpTxt.htmlText = LanguageMgr.GetTranslation(param1);
         addToContent(_helpTxt);
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
         if(_btn)
         {
            addToContent(_btn);
         }
         if(_helpTxt)
         {
            addToContent(_helpTxt);
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
         _rect = new Rectangle(0,0,displayWidth - 35,displayHeight);
         LayerManager.Instance.addToLayer(this,param1,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function simpleAutoLayout() : void
      {
         var _loc1_:int = _helpTxt.textHeight;
         _helpTxt.height = _loc1_ + 20;
         _back.height = _loc1_ + 23;
         _btn.y = _back.y + _back.height + 10;
         this.height = _back.height + 145;
      }
      
      override public function dispose() : void
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

