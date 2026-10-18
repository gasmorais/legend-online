package upgradepresent
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.upgradepresent.UpgradePresentInfo;
   import mvc.module.upgradepresent.UpgradePresentModel;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   import yishi.manager.UpgradePresentManager;
   import yishi.utils.MsgMan;
   
   public class UpgradePresentFrame extends Frame implements IManualSize
   {
      
      private var _leftTimeText:FilterFrameText;
      
      private var _titleImage:ScaleFrameImage;
      
      private var _rightBack:MutipleImage;
      
      private var _headImage:ScaleFrameImage;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var curPage:int;
      
      private var _itemContiner:Component;
      
      private var areaInfo:UpgradePresentInfo;
      
      public function UpgradePresentFrame()
      {
         super();
         initView();
         addEvent();
         curPage = model.showMaxPage;
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,565,510);
      }
      
      private function initView() : void
      {
         _leftTimeText = ComponentFactory.Instance.creatComponentByStylename("UpgradePresent.UpgradePresentFrame.leftTimeText");
         _titleImage = ComponentFactory.Instance.creatComponentByStylename("UpgradePresent.UpgradePresentFrame.titleImage");
         _rightBack = ComponentFactory.Instance.creatComponentByStylename("UpgradePresent.UpgradePresentFrame.rightBack");
         _headImage = ComponentFactory.Instance.creatComponentByStylename("UpgradePresent.UpgradePresentFrame.headImage");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("UpgradePresent.UpgradePresentFrame.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("UpgradePresent.UpgradePresentFrame.nextBtn");
         _itemContiner = ComponentFactory.Instance.creatComponentByStylename("UpgradePresent.UpgradePresentFrame.itemContiner");
         addToContent(_headImage);
         addToContent(_rightBack);
         addToContent(_titleImage);
         addToContent(_leftTimeText);
         addToContent(_preBtn);
         addToContent(_nextBtn);
         addToContent(_itemContiner);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _nextBtn.addEventListener("click",_nextBtnClickHandler);
         _preBtn.addEventListener("click",_preBtnClickHandler);
         MsgMan.addObserver("UPGRADE_PRESNET_INFO_CHANGE",this,__updateMsgBackHandler);
         PlayerManager.instance.currentPlayerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__timeUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",_nextBtnClickHandler);
         }
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",_preBtnClickHandler);
         }
         MsgMan.removeObserver("UPGRADE_PRESNET_INFO_CHANGE",this,__updateMsgBackHandler);
         PlayerManager.instance.currentPlayerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__timeUpdateHandler);
      }
      
      private function __timeUpdateHandler(param1:PlayerEvent) : void
      {
         _leftTimeText.htmlText = areaInfo.leftTimeStr;
      }
      
      private function __updateMsgBackHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function _nextBtnClickHandler(param1:MouseEvent) : void
      {
         curPage = curPage + 1;
         refreshView();
      }
      
      private function _preBtnClickHandler(param1:MouseEvent) : void
      {
         curPage = curPage - 1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         areaInfo = model.presentList[curPage - 1];
         if(!areaInfo)
         {
            return;
         }
         _headImage.setFrame(curPage);
         _titleImage.setFrame(curPage);
         _preBtn.visible = curPage > 1;
         _nextBtn.visible = curPage < model.showMaxPage;
         _leftTimeText.htmlText = areaInfo.leftTimeStr;
         refreshGoodsView();
      }
      
      private function refreshGoodsView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:UpgradePresentGoodsItem = null;
         ObjectUtils.disposeAllChildren(_itemContiner);
         var _loc2_:int = int(areaInfo.shopIdArr.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new UpgradePresentGoodsItem(_loc3_,_loc2_);
            _loc1_.data = areaInfo;
            _loc1_.x = _loc2_ == 1 ? 0 : (_loc3_ - 1) * 195 + 95;
            _loc1_.y = 0;
            _itemContiner.addChild(_loc1_);
            _loc3_++;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get model() : UpgradePresentModel
      {
         return UpgradePresentManager.instance.model;
      }
      
      public function show() : void
      {
         this.titleText = LanguageMgr.GetTranslation("UpgradePresentFrame.title.text");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_leftTimeText);
         _leftTimeText = null;
         ObjectUtils.disposeObject(_titleImage);
         _titleImage = null;
         ObjectUtils.disposeObject(_rightBack);
         _rightBack = null;
         ObjectUtils.disposeObject(_headImage);
         _headImage = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_itemContiner);
         _itemContiner = null;
         super.dispose();
      }
   }
}

