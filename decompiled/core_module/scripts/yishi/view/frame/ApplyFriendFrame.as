package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.manager.FriendManager;
   
   public class ApplyFriendFrame extends Frame
   {
      
      private var _okBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      private var _font1Txt:FilterFrameText;
      
      private var _font2Txt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _psTxt:FilterFrameText;
      
      private var _name:String;
      
      public function ApplyFriendFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var _loc1_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("friends.applybg");
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("friends.applyOKBtn");
         _okBtn.text = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendItem.accept");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("friends.applyCancleBtn");
         _cancelBtn.text = LanguageMgr.GetTranslation("map.campaign.view.frame.PrepareBattleFrame1.reject");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("friends.applyNameTxt");
         _font1Txt = ComponentFactory.Instance.creatComponentByStylename("friends.applyFont1Txt");
         _font2Txt = ComponentFactory.Instance.creatComponentByStylename("friends.applyFont2Txt");
         _psTxt = ComponentFactory.Instance.creatComponentByStylename("friends.applyPSTxt");
         addToContent(_loc1_);
         addToContent(_okBtn);
         addToContent(_cancelBtn);
         addToContent(_nameTxt);
         addToContent(_font1Txt);
         addToContent(_font2Txt);
         addToContent(_psTxt);
         escEnable = true;
         enterEnable = true;
         titleText = LanguageMgr.GetTranslation("friends.view.ApplyFriendFrame.title");
         _font1Txt.text = LanguageMgr.GetTranslation("friends.view.ApplyFriendFrame.font1");
         _font2Txt.text = LanguageMgr.GetTranslation("friends.view.ApplyFriendFrame.font2");
         nameText = "";
         psText = "";
      }
      
      private function initEvents() : void
      {
         addEventListener("response",_reponse);
         _okBtn.addEventListener("click",_okClick);
         _cancelBtn.addEventListener("click",_cancelClick);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_reponse);
         _okBtn.removeEventListener("click",_okClick);
         _cancelBtn.removeEventListener("click",_cancelClick);
      }
      
      private function _reponse(param1:FrameEvent) : void
      {
         if(param1.responseCode == 2)
         {
            _okClick(null);
         }
         dispose();
      }
      
      private function _okClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FriendManager.getInstance().sendAddFriendRequest(_nameTxt.text,1);
         dispose();
      }
      
      private function _cancelClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      public function set nameText(param1:String) : void
      {
         _name = param1;
         _nameTxt.text = param1;
         _font1Txt.x = _nameTxt.textWidth + 20;
      }
      
      public function get nameString() : String
      {
         return _name;
      }
      
      public function set psText(param1:String) : void
      {
         _psTxt.text = param1;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         if(_okBtn)
         {
            ObjectUtils.disposeObject(_okBtn);
         }
         _okBtn = null;
         if(_cancelBtn)
         {
            ObjectUtils.disposeObject(_cancelBtn);
         }
         _cancelBtn = null;
         if(_font1Txt)
         {
            ObjectUtils.disposeObject(_font1Txt);
         }
         _font1Txt = null;
         if(_font2Txt)
         {
            ObjectUtils.disposeObject(_font2Txt);
         }
         _font2Txt = null;
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         if(_psTxt)
         {
            ObjectUtils.disposeObject(_psTxt);
         }
         _psTxt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         dispatchEvent(new Event("close"));
      }
   }
}

