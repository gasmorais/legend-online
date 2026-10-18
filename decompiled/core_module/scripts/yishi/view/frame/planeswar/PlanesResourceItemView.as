package yishi.view.frame.planeswar
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.planeswar.info.PlanesResourceInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.PlanesEventsTemplateInfo;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class PlanesResourceItemView extends Component
   {
      
      private var itemBack:ScaleBitmapImage;
      
      private var resourceName:FilterFrameText;
      
      private var leftTime:FilterFrameText;
      
      private var nextRewardTime:FilterFrameText;
      
      private var rewardText:FilterFrameText;
      
      private var rewardCount:FilterFrameText;
      
      private var rewardItem:BaseItemView;
      
      private var getRewardBtn:IconButton;
      
      private var _data:PlanesResourceInfo;
      
      private var _eventTempInfo:PlanesEventsTemplateInfo;
      
      private var _rewardArr:Array;
      
      private var leftNum:Number;
      
      private var nextRewardNum:Number;
      
      public function PlanesResourceItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         itemBack = ComponentFactory.Instance.creatComponentByStylename("PlanesResourceItemView.itemBack");
         resourceName = ComponentFactory.Instance.creatComponentByStylename("PlanesResourceItemView.resourceName");
         leftTime = ComponentFactory.Instance.creatComponentByStylename("PlanesResourceItemView.leftTime");
         nextRewardTime = ComponentFactory.Instance.creatComponentByStylename("PlanesResourceItemView.nextRewardTime");
         rewardText = ComponentFactory.Instance.creatComponentByStylename("PlanesResourceItemView.rewardText");
         rewardCount = ComponentFactory.Instance.creatComponentByStylename("PlanesResourceItemView.rewardCount");
         rewardItem = ComponentFactory.Instance.creatCustomObject("PlanesResourceItemView.rewardItem");
         getRewardBtn = ComponentFactory.Instance.creatComponentByStylename("PlanesResourceItemView.getRewardBtn");
         addChild(itemBack);
         addChild(resourceName);
         addChild(leftTime);
         addChild(nextRewardTime);
         addChild(rewardText);
         addChild(rewardCount);
         addChild(rewardItem);
         addChild(getRewardBtn);
         getRewardBtn.visible = false;
      }
      
      private function addEvent() : void
      {
         getRewardBtn.addEventListener("click",__getRewardClickHandler);
      }
      
      private function __getRewardClickHandler(param1:MouseEvent) : void
      {
         if(_data.canGetCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PlanesResourceItemView.noReward.alert"));
            return;
         }
         PlanesWarManager.instance.sendPlanesOpMsg(31,[_data.layerId,_data.x,_data.y]);
      }
      
      public function set data(param1:PlanesResourceInfo) : void
      {
         _data = param1;
         cleanData();
         if(!_data)
         {
            return;
         }
         _eventTempInfo = TempleteManager.instance.planesEventsTemplateCate.getTemplateByID(_data.eventId);
         if(!_eventTempInfo)
         {
            return;
         }
         rewardItem.visible = true;
         getRewardBtn.visible = true;
         getRewardBtn.enable = _data.canGetCount > 0 ? true : false;
         resourceName.text = _eventTempInfo.Name;
         rewardText.text = LanguageMgr.GetTranslation("PlanesResourceItemView.rewardText.text");
         _rewardArr = _eventTempInfo.Parameter.split(",");
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = _rewardArr[2];
         _loc2_.count = _rewardArr[3];
         rewardItem.data = _loc2_;
         if(_data.totalLeftTime == 0 && _data.nextRewardTime == 0)
         {
            leftTime.text = LanguageMgr.GetTranslation("PlanesResourceItemView.leftTime.text",DateFormatter.getConsortiaCountDate(0));
            nextRewardTime.text = LanguageMgr.GetTranslation("PlanesResourceItemView.nextRewardTime.text",DateFormatter.getConsortiaCountDate(0));
            rewardCount.text = "x" + _data.canGetCount;
         }
      }
      
      public function get data() : PlanesResourceInfo
      {
         return _data;
      }
      
      private function cleanData() : void
      {
         resourceName.text = "";
         leftTime.text = "";
         nextRewardTime.text = "";
         rewardText.text = "";
         rewardCount.text = "";
         rewardItem.visible = false;
         getRewardBtn.visible = false;
      }
      
      public function setTime() : void
      {
         if(!_data)
         {
            return;
         }
         leftTime.text = LanguageMgr.GetTranslation("PlanesResourceItemView.leftTime.text",DateFormatter.getConsortiaCountDate(_data.totalLeftTime));
         nextRewardTime.text = LanguageMgr.GetTranslation("PlanesResourceItemView.nextRewardTime.text",DateFormatter.getConsortiaCountDate(_data.nextRewardTime));
         _data.canGetCount = _data.baseCanGet + int((_rewardArr[1] * 60 - _data.baseTotalTime % (_rewardArr[1] * 60) + _data.baseTotalTime - _data.totalLeftTime) / _rewardArr[1] / 60);
         rewardCount.text = "x" + _data.canGetCount;
         getRewardBtn.enable = _data.canGetCount > 0 ? true : false;
      }
      
      private function removeEvent() : void
      {
         getRewardBtn.removeEventListener("click",__getRewardClickHandler);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(itemBack)
         {
            ObjectUtils.disposeObject(itemBack);
         }
         itemBack = null;
         if(resourceName)
         {
            ObjectUtils.disposeObject(resourceName);
         }
         resourceName = null;
         if(leftTime)
         {
            ObjectUtils.disposeObject(leftTime);
         }
         leftTime = null;
         if(nextRewardTime)
         {
            ObjectUtils.disposeObject(nextRewardTime);
         }
         nextRewardTime = null;
         if(rewardText)
         {
            ObjectUtils.disposeObject(rewardText);
         }
         rewardText = null;
         if(rewardItem)
         {
            ObjectUtils.disposeObject(rewardItem);
         }
         rewardItem = null;
         if(getRewardBtn)
         {
            ObjectUtils.disposeObject(getRewardBtn);
         }
         getRewardBtn = null;
         super.dispose();
      }
   }
}

