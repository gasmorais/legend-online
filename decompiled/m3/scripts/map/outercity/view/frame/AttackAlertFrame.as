package map.outercity.view.frame
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
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.internals.data.MapPhysics;
   import map.internals.data.template.MapTemplate;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class AttackAlertFrame extends Frame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _textBack:Bitmap;
      
      private var _textBack2:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _leftCount:FilterFrameText;
      
      private var _submitBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      private var addAttckPoint:int;
      
      public function AttackAlertFrame()
      {
         super();
         escEnable = true;
         enterEnable = true;
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("outercity.AttackFrameBack");
         _textBack = ComponentFactory.Instance.creatBitmap("asset.outercity.AttackTextBack");
         _textBack2 = ComponentFactory.Instance.creatBitmap("asset.outercity.AttackTextBack2");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("outercity.AttackNameTxt");
         _leftCount = ComponentFactory.Instance.creatComponentByStylename("outercity.AttackLeftCountTxt");
         _submitBtn = ComponentFactory.Instance.creatComponentByStylename("outercity.AttackSubmitBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("outercity.AttackCancelBtn");
         _titleText = LanguageMgr.GetTranslation("map.outercity.view.frame.AttackAlertFrame.command01");
         _submitBtn.text = LanguageMgr.GetTranslation("public.attack");
         _cancelBtn.text = LanguageMgr.GetTranslation("public.cancel");
         addToContent(_back);
         addToContent(_textBack);
         addToContent(_textBack2);
         addToContent(_nameTxt);
         addToContent(_leftCount);
         addToContent(_submitBtn);
         addToContent(_cancelBtn);
         addAttckPoint = int(TempleteManager.instance.getConfigInfoByConfigName("AddAttck_Point").ConfigValue);
      }
      
      protected function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      protected function initEvent() : void
      {
         _submitBtn.addEventListener("click",__submitBtnClickHandler);
         _cancelBtn.addEventListener("click",__cancelBtnClickHandler);
         playerInfo.addEventListener("ATTACK_COUNT_CHANGE",__updateCountHandler);
      }
      
      protected function removeEvent() : void
      {
         _submitBtn.removeEventListener("click",__submitBtnClickHandler);
         _cancelBtn.removeEventListener("click",__cancelBtnClickHandler);
         playerInfo.removeEventListener("ATTACK_COUNT_CHANGE",__updateCountHandler);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __submitBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(playerInfo.attackCount == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("map.outercity.view.frame.AttackAlertFrame.command03");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         dispatchEvent(new FrameEvent(3));
      }
      
      private function __cancelBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new FrameEvent(4));
      }
      
      private function __updateCountHandler(param1:PlayerEvent) : void
      {
         _leftCount.text = playerInfo.attackCount + "/5";
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function set data(param1:MapPhysics) : void
      {
         var _loc2_:MapTemplate = TempleteManager.instance.mapTemplateCate.getTemplateByID(param1.info.mapId);
         _nameTxt.htmlText = param1.info.names + "(" + _loc2_.MapName + " <font color=\'#e9ac0c\' size=\'12\'>" + int(param1.posX * 2 / 5) + "," + int(param1.posY * 2 / 5) + "</font>)";
         __updateCountHandler(null);
      }
      
      public function get submitBtn() : TextButton
      {
         return _submitBtn;
      }
      
      override public function dispose() : void
      {
         if(this.parent)
         {
            KeyBoardRegister.instance.keyEnable = true;
         }
         removeEvent();
         uninit();
         super.dispose();
      }
   }
}

