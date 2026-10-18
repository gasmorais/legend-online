package monthcard
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MonthCardManager;
   import mvc.module.fundVein.RewardItemInfo;
   import mvc.module.monthcard.MonthCardGiftInfo;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.PathManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   
   public class MonthCardGiftItem extends Component implements IManualSize
   {
      
      private var _back:MutipleImage;
      
      private var _titleText:FilterFrameText;
      
      private var _descText:FilterFrameText;
      
      private var _activeImage:Bitmap;
      
      private var _joinBtn:IconButton;
      
      private var _getBtn:IconButton;
      
      private var _rewardHbox:HBox;
      
      private var _rewardPanel:ScrollPanel;
      
      private var curPicStr:String;
      
      private var _data:MonthCardGiftInfo;
      
      public function MonthCardGiftItem()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,248,324);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("MonthCardGiftItem.back");
         _titleText = ComponentFactory.Instance.creatComponentByStylename("MonthCardGiftItem.titleText");
         _descText = ComponentFactory.Instance.creatComponentByStylename("MonthCardGiftItem.descText");
         _joinBtn = ComponentFactory.Instance.creatComponentByStylename("MonthCardGiftItem.joinBtn");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("MonthCardGiftItem.getBtn");
         _rewardPanel = ComponentFactory.Instance.creatComponentByStylename("MonthCardGiftItem.rewardPanel");
         _rewardHbox = ComponentFactory.Instance.creatComponentByStylename("MonthCardGiftItem.rewardHbox");
         _activeImage = new Bitmap();
         _activeImage.x = 87;
         _activeImage.y = 58;
         addChild(_back);
         addChild(_titleText);
         addChild(_activeImage);
         addChild(_descText);
         addChild(_joinBtn);
         addChild(_getBtn);
         addChild(_rewardPanel);
         _rewardPanel.setView(_rewardHbox);
         _rewardPanel.invalidateViewport();
         _rewardPanel.commitChanges();
      }
      
      private function addEvent() : void
      {
         _joinBtn.addEventListener("click",__joinClickHandler);
         _getBtn.addEventListener("click",__getClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_joinBtn)
         {
            _joinBtn.removeEventListener("click",__joinClickHandler);
         }
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",__getClickHandler);
         }
      }
      
      private function __joinClickHandler(param1:MouseEvent) : void
      {
         if(!data || Boolean(data.hasBuy))
         {
            return;
         }
         var _loc5_:String = LanguageMgr.GetTranslation("MonthCardGiftItem.buyGift.content",data.needPoint);
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.data = [confirmMakeHandler];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,true,2);
      }
      
      private function confirmMakeHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         if(!LogicUtils.judgePointEnoughToShowPay(data.needPoint,false))
         {
            return;
         }
         MonthCardManager.instance.sendMonthRequest(2,data.type);
      }
      
      private function __getClickHandler(param1:MouseEvent) : void
      {
         if(!data || !data.canGetReward)
         {
            return;
         }
         MonthCardManager.instance.sendMonthRequest(3,data.type);
      }
      
      public function get data() : MonthCardGiftInfo
      {
         return _data;
      }
      
      public function set data(param1:MonthCardGiftInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:String = null;
         refreshRewardList();
         if(data)
         {
            _titleText.text = data.giftName;
            if(data.hasBuy)
            {
               _descText.htmlText = LanguageMgr.GetTranslation("MonthCardGiftItem.descText.text2",data.leftDay);
               _joinBtn.visible = false;
               _getBtn.visible = true;
               _getBtn.enable = data.canGetReward;
            }
            else
            {
               _descText.htmlText = LanguageMgr.GetTranslation("MonthCardGiftItem.descText.text1",data.lastDay,data.needPoint);
               _joinBtn.visible = true;
               _getBtn.visible = false;
            }
            if(curPicStr != data.giftPic)
            {
               curPicStr = data.giftPic;
               LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onActiveIconLoaded);
               _loc1_ = PathManager.getMonthCardIconPath(data.giftPic);
               LoaderManagerII.instance.load(_loc1_,2,8,__onActiveIconLoaded);
            }
         }
         else
         {
            _activeImage.bitmapData = null;
            _titleText.text = "";
            _descText.text = "";
            _joinBtn.visible = false;
            _getBtn.visible = false;
         }
      }
      
      private function __onActiveIconLoaded(param1:LoaderInfo, param2:Object) : void
      {
         if(param2 && _activeImage)
         {
            _activeImage.bitmapData = (param2 as Bitmap).bitmapData;
         }
      }
      
      private function refreshRewardList() : void
      {
         var _loc4_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         var _loc3_:RewardItemInfo = null;
         _rewardHbox.removeAllChild();
         if(!data)
         {
            return;
         }
         var _loc2_:int = int(data.itemList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("MonthCardGiftItem.rewardItem");
            _loc5_ = new GoodsInfo();
            _loc3_ = data.itemList[_loc4_];
            _loc5_.templateId = _loc3_.tempId;
            _loc5_.count = _loc3_.count;
            _loc1_.data = _loc5_;
            _rewardHbox.addChild(_loc1_);
            _loc4_++;
         }
         _rewardPanel.beginChanges();
         _rewardPanel.invalidateViewport();
         _rewardPanel.commitChanges();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onActiveIconLoaded);
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_titleText);
         _titleText = null;
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_activeImage);
         _activeImage = null;
         ObjectUtils.disposeObject(_joinBtn);
         _joinBtn = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_rewardHbox);
         _rewardHbox = null;
         ObjectUtils.disposeObject(_rewardPanel);
         _rewardPanel = null;
         super.dispose();
      }
   }
}

