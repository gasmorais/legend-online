package map.campaign.view.ui.sumcampaign
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.sumpassion.SumCampaignTaskListMsg;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.SumCampaignManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class SumCampaignListView extends Component
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _rewardsScroll:ScrollPanel;
      
      private var _rewardsVBox:VBox;
      
      private var _numTxt:FilterFrameText;
      
      private var _list:SimpleTileList;
      
      private var _noteTxt:FilterFrameText;
      
      public function SumCampaignListView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("sumCampaign.Background");
         _rewardsScroll = ComponentFactory.Instance.creatComponentByStylename("sumCampaign.ScrollPanel");
         _rewardsVBox = ComponentFactory.Instance.creatComponentByStylename("sumCampaign.TaskItemVbox");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("sumCampaign.numTxt");
         _list = ComponentFactory.Instance.creatCustomObject("sumCampaign.goodsList",[4]);
         _noteTxt = ComponentFactory.Instance.creatComponentByStylename("sumCampaign.noteTxt");
         addChild(_back);
         addChild(_rewardsScroll);
         addChild(_rewardsVBox);
         addChild(_numTxt);
         addChild(_list);
         addChild(_noteTxt);
         _rewardsScroll.setView(_rewardsVBox);
         _noteTxt.text = LanguageMgr.GetTranslation("sumcampaign.SumCampaignListView.floorRewardTxt");
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("PUBLIC_SUM_CAMPAIGN",__updateViewHandler);
         __updateViewHandler(null);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("PUBLIC_SUM_CAMPAIGN",__updateViewHandler);
      }
      
      private function __updateViewHandler(param1:NotificationEvent) : void
      {
         var _loc3_:SumCampaignListItem = null;
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:GoodsInfo = null;
         var _loc6_:BaseItemView = null;
         var _loc4_:SumCampaignTaskListMsg = SumCampaignManager.instance.sumListMsg;
         if(!_loc4_)
         {
            return;
         }
         clearView();
         _numTxt.htmlText = LanguageMgr.GetTranslation("sumcampaign.SumCampaignListView.numTxt",_loc4_.keyCount);
         _rewardsVBox.beginChanges();
         _loc9_ = 0;
         while(_loc9_ < _loc4_.task.length)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("map.campaign.view.ui.sumcampaign.SumCampaignListItem");
            _loc3_.data = _loc4_.task[_loc9_];
            _rewardsVBox.addChild(_loc3_);
            _loc9_++;
         }
         _rewardsVBox.commitChanges();
         _rewardsScroll.invalidateViewport(false);
         var _loc7_:int = int(CampaignManager.instance.mapModel.mapId);
         var _loc2_:Array = TempleteManager.instance.areaMapDropTemplateCate.getTemplateByID(_loc7_);
         _loc8_ = 0;
         while(_loc8_ < _loc2_.length)
         {
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc2_[_loc8_].itemTempId;
            _loc5_.count = _loc2_[_loc8_].count;
            _loc6_ = ComponentFactory.Instance.creatCustomObject("tips.BaseItemView");
            _loc6_.textStyle = "core.BaseItemText";
            _loc6_.data = _loc5_;
            _list.addChild(_loc6_);
            _loc8_++;
         }
      }
      
      private function clearView() : void
      {
         ObjectUtils.disposeAllChildren(_rewardsVBox);
         ObjectUtils.disposeAllChildren(_list);
      }
      
      public function get viewWidth() : Number
      {
         return _back.width;
      }
      
      public function get viewHeight() : Number
      {
         return _back.height;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,false,false,0,3);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_rewardsScroll);
         _rewardsScroll = null;
         ObjectUtils.disposeObject(_rewardsVBox);
         _rewardsVBox = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_noteTxt);
         _noteTxt = null;
         super.dispose();
      }
   }
}

