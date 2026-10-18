package map.campaign.mediator.singlecampaign
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import map.campaign.CampaignManager;
   import mvc.module.singlecampaign.SingleCampaignModel;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SingleCampaignDataTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseItemView;
   
   public class SingleCampaignUIView extends Component
   {
      
      private var _rewardCon:Component;
      
      private var _rewardBack:MutipleImage;
      
      private var _rewardPanel:ScrollPanel;
      
      private var _rewardHbox:HBox;
      
      private var _npcCon:Component;
      
      private var npcList:Vector.<SingleCampaignNpcNode>;
      
      private var npcPosAry:Array = [[390,355],[580,415],[770,365],[1025,370]];
      
      public function SingleCampaignUIView()
      {
         super();
         initView();
         initListView();
         addEvent();
         refreshRewardView();
      }
      
      private function initView() : void
      {
         _rewardCon = new Component();
         _npcCon = new Component();
         _rewardBack = ComponentFactory.Instance.creatComponentByStylename("SingleCampaignUIView.rewardBack");
         _rewardPanel = ComponentFactory.Instance.creatComponentByStylename("SingleCampaignUIView.rewardPanel");
         _rewardHbox = ComponentFactory.Instance.creatComponentByStylename("SingleCampaignUIView.rewardHbox");
         addChild(_rewardCon);
         addChild(_npcCon);
         _rewardCon.addChild(_rewardBack);
         _rewardCon.addChild(_rewardPanel);
         _rewardPanel.beginChanges();
         _rewardPanel.setView(_rewardHbox);
         _rewardPanel.commitChanges();
         _rewardPanel.invalidateViewport();
      }
      
      private function initListView() : void
      {
         var _loc1_:SingleCampaignNpcNode = null;
         var _loc2_:SingleCampaignDataTempInfo = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         npcList = new Vector.<SingleCampaignNpcNode>();
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc3_ = _loc4_ + 1;
            _loc2_ = TempleteManager.instance.singleCampaignDataTempCate.getTempInfoByIndex(singleModel.campaignId,_loc3_);
            _loc1_ = new SingleCampaignNpcNode(_loc3_);
            _loc1_.data = _loc2_;
            _loc1_.x = npcPosAry[_loc4_][0];
            _loc1_.y = npcPosAry[_loc4_][1];
            _npcCon.addChild(_loc1_);
            npcList.push(_loc1_);
            _loc4_++;
         }
      }
      
      private function refreshRewardView() : void
      {
         var _loc1_:BaseItemView = null;
         var _loc2_:int = 0;
         var _loc4_:GoodsInfo = null;
         _rewardHbox.removeAllChild();
         var _loc3_:Array = singleModel.campaignTemp && singleModel.campaignTemp.Item ? singleModel.campaignTemp.Item.split(",") : [];
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("core.fallGoods.BaseItemView");
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc3_[_loc2_];
            _loc1_.data = _loc4_;
            _rewardHbox.addChild(_loc1_);
            _loc2_++;
         }
         _rewardPanel.beginChanges();
         _rewardPanel.commitChanges();
         _rewardPanel.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("UPDATE_SINGLE_CAMPAIGN",this,__updateSingleCampaign);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("UPDATE_SINGLE_CAMPAIGN",this,__updateSingleCampaign);
      }
      
      private function __updateSingleCampaign(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < npcList.length)
         {
            npcList[_loc3_].data = TempleteManager.instance.singleCampaignDataTempCate.getTempInfoByIndex(singleModel.campaignId,_loc3_ + 1);
            _loc3_++;
         }
      }
      
      public function resizeView(param1:int, param2:int) : void
      {
         _rewardCon.x = 0;
         _rewardCon.y = 200;
         _npcCon.x = (param1 - 1400) / 2 > 0 ? (param1 - 1400) / 2 : 0;
         _npcCon.y = (param2 - 900) / 2 > 0 ? (param2 - 900) / 2 : 0;
      }
      
      private function get singleModel() : SingleCampaignModel
      {
         return CampaignManager.instance.singleCampaignModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_rewardCon);
         _rewardCon = null;
         ObjectUtils.disposeObject(_rewardBack);
         _rewardBack = null;
         ObjectUtils.disposeObject(_rewardPanel);
         _rewardPanel = null;
         ObjectUtils.disposeObject(_rewardHbox);
         _rewardHbox = null;
         ObjectUtils.disposeObject(_npcCon);
         _npcCon = null;
         LogicUtils.disposeDisplayCollection(npcList);
         npcList = null;
         super.dispose();
      }
   }
}

