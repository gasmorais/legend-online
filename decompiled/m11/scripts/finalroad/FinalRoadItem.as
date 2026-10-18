package finalroad
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MopupManager;
   import mvc.module.finalroad.FinalRoadModel;
   import yishi.datas.templates.FinalRoadChapterTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.FinalRoadManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class FinalRoadItem extends Component
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _titleBg:ScaleFrameImage;
      
      private var _itemSelected:Bitmap;
      
      private var _itemLock:Bitmap;
      
      private var _isLock:Boolean;
      
      private var _challengeBtn:IconButton;
      
      private var _continueBtn:IconButton;
      
      private var _mpopBtn:TextButton;
      
      private var _index:int;
      
      private var _tipStr:String;
      
      public function FinalRoadItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("finalRoadItem.bg");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("finalRoadItem.titleBg");
         _itemSelected = ComponentFactory.Instance.creatBitmap("asset.finalRoadFrame.itemSelected");
         _itemLock = ComponentFactory.Instance.creatBitmap("asset.finalRoadFrame.itemLock");
         _challengeBtn = ComponentFactory.Instance.creatComponentByStylename("finalRoadItem.challengeBtn");
         _continueBtn = ComponentFactory.Instance.creatComponentByStylename("finalRoadItem.continueBtn");
         _mpopBtn = ComponentFactory.Instance.creatComponentByStylename("finalRoadItem.popBtn");
         _mpopBtn.text = LanguageMgr.GetTranslation("finalRoadItem.popBtn.btntxt");
         addChild(_bg);
         addChild(_titleBg);
         addChild(_itemSelected);
         _itemSelected.visible = false;
         addChild(_itemLock);
         addChild(_challengeBtn);
         addChild(_continueBtn);
         addChild(_mpopBtn);
         _mpopBtn.visible = false;
         tipStyle = "yishi.view.tips.OneLineTip";
         tipDirctions = "4,6,5,7,0,1,2,3";
         tipGapV = -200;
         tipGapH = -200;
         isFollowMouse = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseOver",__onMouseOverHandler);
         addEventListener("mouseOut",__onMouseOutHandler);
         _challengeBtn.addEventListener("click",__challengeBtnClickHandler);
         _continueBtn.addEventListener("click",__continueBtnClickHandler);
         _mpopBtn.addEventListener("click",_mpopBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__onMouseOverHandler);
         removeEventListener("mouseOut",__onMouseOutHandler);
         _challengeBtn.removeEventListener("click",__challengeBtnClickHandler);
         _continueBtn.removeEventListener("click",__continueBtnClickHandler);
         _mpopBtn.removeEventListener("click",_mpopBtnClickHandler);
      }
      
      private function _mpopBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(model.surplusChapterTimes > 0)
         {
            if(_index > model.passChapterRecord)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("finalRoadItem.popBtn.failTip1"));
               return;
            }
            if(_index == model.currentChapter && model.groupInfo.state != 2)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("finalRoadItem.popBtn.failTip2"));
               return;
            }
            SimpleAlertHelper.instance.data = [__mpopBtnClickArltCallBack];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("finalRoadItem.popBtn.content");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("finalRoadItem.chapterTimes.text"));
         }
      }
      
      private function __mpopBtnClickArltCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            MopupManager.instance.sendMopupInfo(8,1,_index);
         }
      }
      
      private function __challengeBtnClickHandler(param1:MouseEvent) : void
      {
         if(model.surplusChapterTimes == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("finalRoadItem.chapterTimes.text"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         var _loc3_:String = LanguageMgr.GetTranslation("finalRoadItem.TodayNotAlert.content.text" + _index);
         SharedManagerHelper.ins.needAlert("finalroad.FinalRoadItem.challengeBtnClick",callBack,_loc2_,_loc3_);
      }
      
      private function callBack() : void
      {
         FinalRoadManager.instance.send(1,_index);
         FrameControllerManager.instance.openControllerByInfo("finalroad",1);
         MsgMan.notifyObserver("FINALROAD_CHALLENGE");
      }
      
      private function __continueBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("finalroad",1);
         MsgMan.notifyObserver("FINALROAD_CHALLENGE");
      }
      
      private function __onMouseOverHandler(param1:MouseEvent) : void
      {
         _itemSelected.visible = true;
      }
      
      private function __onMouseOutHandler(param1:MouseEvent) : void
      {
         _itemSelected.visible = false;
      }
      
      public function refreshView() : void
      {
         var _loc4_:FinalRoadChapterTempInfo = null;
         _bg.setFrame(_index);
         _titleBg.setFrame(_index);
         _challengeBtn.enable = true;
         _mpopBtn.visible = false;
         var _loc1_:Boolean = true;
         var _loc2_:int = int(TempleteManager.instance.royaltyTempCate.getFinalRoadLv(_index));
         if(RoyaltyBossManager.instance.model.royaltyLevel >= _loc2_)
         {
            _loc1_ = false;
         }
         var _loc3_:int = int(TempleteManager.instance.finalRoadChapterTempCate.getChapterCount());
         if(_index > model.passChapterRecord + 1 || _loc1_ || _index == _loc3_)
         {
            _itemLock.visible = true;
            this.filters = [UIFilter.getGrayFilter()];
            _challengeBtn.visible = false;
            _tipStr = LanguageMgr.GetTranslation("secret.lock.areaTip",LanguageMgr.GetTranslation("public.unopen.wait"));
            _loc4_ = TempleteManager.instance.finalRoadChapterTempCate.getTempInfoById(_index);
            if(_loc4_)
            {
               _tipStr = LanguageMgr.GetTranslation("secret.lock.areaTip",_loc4_.Description);
            }
            this.tipData = _tipStr;
         }
         else
         {
            _itemLock.visible = false;
            this.filters = [];
            _challengeBtn.visible = true;
            _mpopBtn.visible = true;
         }
         if(model.currentChapter == _index)
         {
            _continueBtn.visible = true;
            _challengeBtn.visible = false;
         }
         else
         {
            _continueBtn.visible = false;
            if(model.currentChapter > 0)
            {
               _challengeBtn.enable = false;
            }
         }
      }
      
      private function get model() : FinalRoadModel
      {
         return FinalRoadManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_itemSelected);
         _itemSelected = null;
         ObjectUtils.disposeObject(_itemLock);
         _itemLock = null;
         ObjectUtils.disposeObject(_challengeBtn);
         _challengeBtn = null;
         ObjectUtils.disposeObject(_continueBtn);
         _continueBtn = null;
         ObjectUtils.disposeObject(_mpopBtn);
         _mpopBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

